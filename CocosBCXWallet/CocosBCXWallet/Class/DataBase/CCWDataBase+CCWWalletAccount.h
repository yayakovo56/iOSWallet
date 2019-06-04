//
//  CCWDataBase+CCWWalletAccount.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/18.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWDataBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWDataBase (CCWWalletAccount)
/* 创建用户钱包账户表 */
- (void)CCW_CreateWalletAccountTable;

/* 存入当前钱包账户 */
- (void)CCW_SaveWalletAccount:(CCWWalletAccount *)accountModel;

/** 查找所有钱包账户 */
- (NSMutableArray<CCWWalletAccount *> *)CCW_QueryLocalWalletAccount;
@end

NS_ASSUME_NONNULL_END
