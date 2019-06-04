//
//  CCWDataBase+CCWNodeINfo.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/6/3.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWDataBase.h"
#import "CCWNodeInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWDataBase (CCWNodeINfo)

/* 创建用户节点表 */
- (void)CCW_CreateNodeInfoTable;

/* 存入节点 */
- (void)CCW_SaveNodeInfo:(CCWNodeInfoModel *)nodeInfo;

/** 存入网络节点 */
- (void)CCW_SaveSerVerNodeInfoArray:(NSMutableArray *)nodeInfoArray;

/** 查找所有的节点 */
- (NSMutableArray<CCWNodeInfoModel *> *)CCW_QueryNodeInfo;

/* 删除节点 */
- (void)CCW_DeleteNodeInfo:(CCWNodeInfoModel *)nodeInfo;

/* 删除所有网络节点 */
- (void)CCW_DeleteServerNodeInfo;

@end

NS_ASSUME_NONNULL_END
