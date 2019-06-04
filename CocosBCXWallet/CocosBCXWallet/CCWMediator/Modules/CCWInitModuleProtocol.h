//
//  CCWInitModuleProtocol.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWModuleProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CCWInitModuleProtocol <CCWModuleProtocol>
// 注册控制器
- (UIViewController *)CCW_LoginRegisterWalletViewController;
// 创建控制器
- (UIViewController *)CCW_CreateWalletViewController;
@end

NS_ASSUME_NONNULL_END
