//
//  CCWWalletModule
//  CocosBCXWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWWalletModule.h"
#import "CCWWalletViewController.h"

@implementation CCWWalletModule

- (UIViewController *)CCW_WalletViewController
{
    CCWWalletViewController *viewController = [[CCWWalletViewController alloc] init];
    return viewController;
}

@end

