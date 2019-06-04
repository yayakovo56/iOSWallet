//
//  CCWModuleChildViewControllerDelegate
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCWModuleChildViewControllerProtocol;

@protocol CCWModuleChildViewControllerDelegate <NSObject>

@optional

- (void)moduleChildViewController:(UIViewController<CCWModuleChildViewControllerProtocol> *)moduleChildViewController changeHeight:(CGFloat)height;

- (void)didFefreshDataInModuleChildViewController:(UIViewController<CCWModuleChildViewControllerProtocol> *)moduleChildViewController;

- (void)errorFefreshDataInModuleChildViewController:(UIViewController<CCWModuleChildViewControllerProtocol> *)moduleChildViewController;

@end

@protocol YSModuleChildViewControllerProtocol <NSObject>

@property (nonatomic, weak) id<CCWModuleChildViewControllerDelegate> delegate;
@property (nonatomic, readonly) CGFloat defaultHeight;

- (void)fefreshData;

@end
