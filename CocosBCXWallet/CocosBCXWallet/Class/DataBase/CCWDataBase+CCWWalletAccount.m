//
//  CCWDataBase+CCWWalletAccount.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/18.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWDataBase+CCWWalletAccount.h"

@implementation CCWDataBase (CCWWalletAccount)
/* 创建用户钱包账户表 */
- (void)CCW_CreateWalletAccountTable
{
    // 创表(字段：钱包地址、名字、钱包私钥、助记词、keyStore、密码)
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_mywallet (account_id text PRIMARY KEY, account_name text);"];
    }];

}

/* 存入当前钱包账户 */
- (void)CCW_SaveWalletAccount:(CCWWalletAccount *)accountModel
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"INSERT OR REPLACE INTO t_mywallet(account_id, account_name) VALUES (?, ?);", accountModel.account_id, accountModel.account_name];
    }];
}

/** 查找所有钱包账户 */
- (NSMutableArray<CCWWalletAccount *> *)CCW_QueryLocalWalletAccount
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = @"SELECT * FROM t_mywallet;";
    // 执行SQL
    NSMutableArray *myAllWalletArray = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        while (resultSet.next) {
            CCWWalletAccount *accountModel = [[CCWWalletAccount alloc] init];
            accountModel.account_id = [resultSet stringForColumn:@"account_id"];
            accountModel.account_name = [resultSet stringForColumn:@"account_name"];
            [myAllWalletArray addObject:accountModel];
        }
        [resultSet close];
    }];
    return myAllWalletArray;
}
@end
