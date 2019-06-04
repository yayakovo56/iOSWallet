//
//  CCWWalletAccountTool.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/19.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCWWalletAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWWalletAccountTool : NSObject
+ (instancetype)shareAuthModel;

/** 归档WalletAccount对象 */
- (void)archiveWalletAccountModel:(CCWWalletAccount *)accountModel;
/** 解档WalletAccount对象 */
- (CCWWalletAccount *)unarchiveWalletAccountModel;

@property (nonatomic ,strong) CCWWalletAccount *accountModel;

@end

NS_ASSUME_NONNULL_END
