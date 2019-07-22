//
//  CCWScanQRCodeViewController.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/11/30.
//  Copyright © 2018年 CCW. All rights reserved.
//
// 主页扫码
// 添加联系人
// 其他，转账界面扫码

typedef NS_ENUM(NSUInteger, CCWScanQRCodePerVC) {
    CCWScanQRCodePerVCTransOutVC = 0, //转账界面扫码
    CCWScanQRCodePerVCAddContactVC = 1  // 添加联系人
};

#import <UIKit/UIKit.h>

@interface CCWScanQRCodeViewController : UIViewController

/** 上一个控制器 */
@property (nonatomic, assign) CCWScanQRCodePerVC perVCscanQRCodePerVC;
// 扫码回调
@property (nonatomic, copy) void(^scanQRCodeBlock)(NSDictionary *qrData);
@end
