//
//  CCWDataBase+CCWContact.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/20.
//  Copyright © 2018年 CCW. All rights reserved.
//
//  联系人

#import "CCWDataBase.h"
#import "CCWContactModel.h"

@interface CCWDataBase (CCWContact)
/* 创建联系人表 */
- (void)CCW_CreateContactTable;

/* 保存联系人 */
- (void)CCW_SaveMyContactModel:(CCWContactModel *)contact;

/** 查询当前用户联系人 */
- (void)CCW_QueryMyContactComplete:(void(^)(NSMutableArray<CCWContactModel *> * contactArray))complete;

/** 查询当前用户联系人 */
- (NSMutableArray<CCWContactModel *> *)CCW_QueryMyContact;

/** 使用某个钱包地址查询联系人(当前用户) */
- (NSMutableArray<CCWContactModel *> *)CCW_QueryMyContactWithWalletAddress:(NSString *)address;

/** 根据用户名称查询联系人(当前用户) */
- (NSMutableArray<CCWContactModel *> *)CCW_QueryMyContactWithName:(NSString *)name;

/* 删除数据库中的某个联系人(当前用户) */
- (void)CCW_DeleteContact:(CCWContactModel *)contact;

@end
