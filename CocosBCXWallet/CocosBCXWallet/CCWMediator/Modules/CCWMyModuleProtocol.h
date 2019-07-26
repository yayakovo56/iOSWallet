//
//  CCWMyModuleProtocol.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWModuleProtocol.h"

@protocol CCWMyModuleProtocol <CCWModuleProtocol>

// 我的模块
- (UIViewController *)CCW_MyViewController;
// 选择联系人
- (UIViewController *)CCW_MyContactViewControllerWithBlock:(void(^)(NSString *address))aBlockBack;

// 扫码转账
- (UIViewController *)CCW_ScanQRCodeToTransferWithBlock:(void(^)(NSDictionary *qrData))blockBack;
// 非同质资产
- (UIViewController *)CCW_AssetsOverviewViewController;
@end
