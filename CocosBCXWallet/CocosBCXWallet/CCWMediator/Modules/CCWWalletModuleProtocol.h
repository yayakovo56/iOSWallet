//
//  CCWWalletModuleProtocol.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/1/29.
//  Copyright © 2019年 邵银岭. All rights reserved.
//
#import "CCWModuleProtocol.h"

@protocol CCWWalletModuleProtocol <CCWModuleProtocol>

// 首页模块
- (UIViewController *)CCW_WalletViewController;

@end
