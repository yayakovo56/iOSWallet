//
//  CCWDataBase+CCWNodeINfo.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/6/3.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWDataBase+CCWNodeINfo.h"

@implementation CCWDataBase (CCWNodeINfo)

/* 创建用户节点表 */
- (void)CCW_CreateNodeInfoTable
{
    // 创表(字段：名称 和钱包地址作为主键, 名字、备注、钱包地址)
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_nodeInfotable (chainId text,coreAsset text,faucetUrl text, name text,ws text, type bit, isSelfSave bit);"];
    }];
}

/* 存入节点 */
- (void)CCW_SaveNodeInfo:(CCWNodeInfoModel *)nodeInfo
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"INSERT OR REPLACE INTO t_nodeInfotable(chainId, coreAsset,faucetUrl,name,ws,type,isSelfSave) VALUES (?,?,?,?,?,?,?);", nodeInfo.chainId,nodeInfo.coreAsset,nodeInfo.faucetUrl,nodeInfo.name,nodeInfo.ws,@(nodeInfo.type),@(nodeInfo.isSelfSave)];
    }];
}

/** 存入网络节点 */
- (void)CCW_SaveSerVerNodeInfoArray:(NSMutableArray *)nodeInfoArray
{
    [self CCW_DeleteServerNodeInfo];
    CCWWeakSelf;
    [nodeInfoArray enumerateObjectsUsingBlock:^(CCWNodeInfoModel *NodeInfoModel, NSUInteger idx, BOOL * stop) {
        NodeInfoModel.isSelfSave = NO;
        [weakSelf CCW_SaveNodeInfo:NodeInfoModel];
    }];
}
/** 查找所有的节点 */
- (NSMutableArray<CCWNodeInfoModel *> *)CCW_QueryNodeInfo
{
    NSMutableArray *nodeInfoArray = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        // 根据请求参数生成对应的查询SQL语句
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM t_nodeInfotable;"];
        while (resultSet.next) {
            CCWNodeInfoModel *nodeInfo = [[CCWNodeInfoModel alloc] init];
            nodeInfo.chainId = [resultSet stringForColumn:@"chainId"];
            nodeInfo.coreAsset = [resultSet stringForColumn:@"coreAsset"];
            nodeInfo.faucetUrl = [resultSet stringForColumn:@"faucetUrl"];
            nodeInfo.name = [resultSet stringForColumn:@"name"];
            nodeInfo.ws = [resultSet stringForColumn:@"ws"];
            nodeInfo.type = [resultSet boolForColumn:@"type"];
            nodeInfo.isSelfSave = [resultSet boolForColumn:@"isSelfSave"];
            [nodeInfoArray addObject:nodeInfo];
        }
        [resultSet close];
    }];
    return nodeInfoArray;
}

/* 删除节点 */
- (NSMutableArray<CCWNodeInfoModel *> *)CCW_DeleteNodeInfo:(CCWNodeInfoModel *)nodeInfo
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdateWithFormat:@"DELETE FROM t_nodeInfotable WHERE ws = %@ and faucetUrl = %@ and chainId = %@;",nodeInfo.ws, nodeInfo.faucetUrl,nodeInfo.chainId];
    }];
    return [self CCW_QueryNodeInfo];
}

/* 删除所有网络节点 */
- (void)CCW_DeleteServerNodeInfo
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdateWithFormat:@"DELETE FROM t_nodeInfotable WHERE isSelfSave = 0;"];
    }];
}

@end
