//
//  CCWInitWalletModule.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWInitWalletModule.h"
#import "CCWLoginViewController.h"
#import "CCWCreateViewController.h"

@implementation CCWInitWalletModule

// 注册控制器
- (UIViewController *)CCW_LoginRegisterWalletViewController
{
    return [[CCWLoginViewController alloc] init];
}

// 创建控制器
- (UIViewController *)CCW_CreateWalletViewController
{
    return [[CCWCreateViewController alloc] init];
}


@end
