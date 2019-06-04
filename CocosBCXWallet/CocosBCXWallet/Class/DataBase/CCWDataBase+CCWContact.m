//
//  CCWDataBase+CCWContact.m
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/20.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import "CCWDataBase+CCWContact.h"

@implementation CCWDataBase (CCWContact)
/* 创建联系人表 */
- (void)CCW_CreateContactTable
{
    // 创表(字段：名称 和钱包地址作为主键, 名字、备注、钱包地址)
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_mycontact (address text PRIMARY KEY,name text,note text, phone text);"];
        // 添加字段
//        if (![db columnExists:@"ID" inTableWithName:@"t_mycontact"]){
//            NSString *addIDSql = [NSString stringWithFormat:@"ALTER TABLE t_mycontact ADD COLUMN ID text;"];
//            [db executeUpdate:addIDSql];
//        }
    }];
}

/* 保存联系人 */
- (void)CCW_SaveMyContactModel:(CCWContactModel *)contact
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"INSERT OR REPLACE INTO t_mycontact(address, name, note) VALUES (? ,? ,?);",contact.address, contact.name,contact.note];
    }];
}

/** 查询当前用户联系人 */
- (void)CCW_QueryMyContactComplete:(void(^)(NSMutableArray<CCWContactModel *> * contactArray))complete
{
    // 执行SQL
    NSMutableArray *myAllContactArray = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        // 根据请求参数生成对应的查询SQL语句
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM t_mycontact;"];
        while (resultSet.next) {
            CCWContactModel *contactModel = [[CCWContactModel alloc] init];
            contactModel.name = [resultSet stringForColumn:@"name"];
            contactModel.address = [resultSet stringForColumn:@"address"];
            contactModel.note = [resultSet stringForColumn:@"note"];
            [myAllContactArray addObject:contactModel];
        }
        [resultSet close];
    }];
    !complete ?: complete(myAllContactArray);
}

/** 查询当前用户联系人 */
- (NSMutableArray<CCWContactModel *> *)CCW_QueryMyContact
{
    // 执行SQL
    NSMutableArray *myAllContactArray = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        // 根据请求参数生成对应的查询SQL语句
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM t_mycontact;"];
        while (resultSet.next) {
            CCWContactModel *contactModel = [[CCWContactModel alloc] init];
            contactModel.name = [resultSet stringForColumn:@"name"];
            contactModel.address = [resultSet stringForColumn:@"address"];
            contactModel.note = [resultSet stringForColumn:@"note"];
            [myAllContactArray addObject:contactModel];
        }
        [resultSet close];
    }];
    return myAllContactArray;
}

/** 使用钱包地址查询联系人(当前用户) */
- (NSMutableArray<CCWContactModel *> *)CCW_QueryMyContactWithWalletAddress:(NSString *)address
{
    // 执行SQL
    NSMutableArray *myContactArray = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM t_mycontact where address = %@;",address];
        while (resultSet.next) {
            CCWContactModel *contactModel = [[CCWContactModel alloc] init];
            contactModel.name = [resultSet stringForColumn:@"name"];
            contactModel.address = [resultSet stringForColumn:@"address"];
            contactModel.note = [resultSet stringForColumn:@"note"];
            [myContactArray addObject:contactModel];
        }
        [resultSet close];
    }];
    return myContactArray;
}

/** 根据用户名称查询联系人(当前用户) */
- (NSMutableArray<CCWContactModel *> *)CCW_QueryMyContactWithName:(NSString *)name
{
    // 执行SQL
    NSMutableArray *myContactArray = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM t_mycontact where name = %@;",name];
        while (resultSet.next) {
            CCWContactModel *contactModel = [[CCWContactModel alloc] init];
            contactModel.name = [resultSet stringForColumn:@"name"];
            contactModel.address = [resultSet stringForColumn:@"address"];
            contactModel.note = [resultSet stringForColumn:@"note"];
            [myContactArray addObject:contactModel];
        }
        [resultSet close];
    }];
    return myContactArray;
}

/* 删除数据库中的某个联系人(当前用户) */
- (void)CCW_DeleteContact:(CCWContactModel *)contact
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdateWithFormat:@"DELETE FROM t_mycontact WHERE name = %@ and address = %@;",contact.name, contact.address];
    }];
}

@end
