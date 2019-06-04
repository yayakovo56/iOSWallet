//
//  CCWMyModule
//  CocosBCXWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWMyModule.h"
#import "CCWMyViewController.h"
#import "CCWContactViewController.h"
#import "CCWScanQRCodeViewController.h"
#import "CCWAssetsOverviewViewController.h"

@implementation CCWMyModule

- (UIViewController *)CCW_MyViewController
{
    CCWMyViewController *viewController = [[CCWMyViewController alloc] init];
    return viewController;
}

// 选择联系人
- (UIViewController *)CCW_MyContactViewControllerWithBlock:(void(^)(NSString *address))aBlockBack
{
    CCWContactViewController *viewController = [[CCWContactViewController alloc] init];
    viewController.isSelectToTransfer = YES;
    viewController.blockBackString = aBlockBack;
    return viewController;
}

// 扫码转账
- (UIViewController *)CCW_ScanQRCodeToTransferWithBlock:(void(^)(NSDictionary *qrData))blockBack
{
    CCWScanQRCodeViewController *sacnQRCodeVC = [[CCWScanQRCodeViewController alloc] init];
    sacnQRCodeVC.perVCscanQRCodePerVC = CCWScanQRCodePerVCTransOutVC;
    sacnQRCodeVC.scanQRCodeBlock = blockBack;
    return sacnQRCodeVC;
}

// 道具资产
- (UIViewController *)CCW_AssetsOverviewViewController
{
    CCWAssetsOverviewViewController *assetsOverviewVC = [[CCWAssetsOverviewViewController alloc] initWithShowPropAsset];
    return assetsOverviewVC;
}
@end

