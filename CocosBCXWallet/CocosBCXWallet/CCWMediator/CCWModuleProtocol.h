//
//  CCWModuleProtocol
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWModuleChildViewControllerProtocol.h"

@protocol CCWModuleProtocol <NSObject>

@optional

+ (id<UIApplicationDelegate>)moduleApplicationDelegate;

- (id)remoteWithActionName:(NSString *)actionName params:(NSDictionary *)params;

- (UIViewController<YSModuleChildViewControllerProtocol> *)moduleChildViewControllerWithKey:(NSString *)key;

@end
