//
//  CCWWalletModuleProtocol.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/1/29.
//  Copyright © 2019年 邵银岭. All rights reserved.
//
#import "CCWModuleProtocol.h"
@class CCWNHAssetsModel;

@protocol CCWWalletModuleProtocol <CCWModuleProtocol>

// 首页模块
- (UIViewController *)CCW_WalletViewController;

// 出售道具资产
- (UIViewController *)CCW_SellAssetsViewControllerWithAsset:(CCWNHAssetsModel *)nhAssetModel;
@end
