//
//  CCWContactViewController.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/20.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCWContactViewController : UIViewController

/** 是否是选择联系人转账 */
@property (nonatomic, assign) BOOL isSelectToTransfer;

// 选择联系人回调
@property (nonatomic,copy) void(^blockBackString)(NSString *address);

@end
