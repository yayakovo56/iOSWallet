//
//  CCWWalletModule
//  CocosBCXWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWWalletModule.h"
#import "CCWWalletViewController.h"
#import "CCWSellNHAssetViewController.h"

@implementation CCWWalletModule

- (UIViewController *)CCW_WalletViewController
{
    CCWWalletViewController *viewController = [[CCWWalletViewController alloc] init];
    return viewController;
}

// 出售道具资产
- (UIViewController *)CCW_SellAssetsViewControllerWithAsset:(CCWNHAssetsModel *)nhAssetModel success:(void (^)(void))successBlock
{
    CCWSellNHAssetViewController *viewController = [[CCWSellNHAssetViewController alloc] init];
    viewController.nhAssetModel = nhAssetModel;
    viewController.sellSuccess = successBlock;
    return viewController;
}

@end

