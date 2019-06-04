//
//  CCWBaseAlert.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWAlertController.h"


@protocol CCWBaseAlertDataSource <NSObject>
#pragma mark - 子类需要实现的方法
@required
// 需要展示点击的按钮
- (NSArray<CCWAlertAction *> *)getActions;

@optional
// 弹出的样式
- (CCWAlertControllerStyle)showWithStyle;

// 弹出框的标题
- (NSString *)showWithTitle;

// 弹出框的消息
- (NSString *)showWithMessage;

@end


/*****************************
 
 ***  该类为一个抽象的类，本身不具备弹框的功能，要想使用该类进行弹框封装必须继承该类实现对应得方法
 
 *    实现 CCWBaseAlertDataSource 数据源方法可以设置 弹框样式（默认是alert）、要展示点击的action
 *    实现 CCWAlertControllerDelegate 可以自定义标题栏、消息栏样式
 
 *****************************/
@interface CCWBaseAlert : NSObject <CCWBaseAlertDataSource,CCWAlertControllerDelegate>
/**
 *  弹出框
 *
 *  @param formController 用于弹出（alert控制器）的控制器
 */
- (void)alertWithController:(UIViewController *)formController;


/**
 *  弹出框 使用跟控制器弹出
 */
- (void)alertWithRootViewController;
/** 带有处理事件的弹窗 */
- (void)alertWithRootViewControllerAddAction:(NSArray<CCWAlertAction *> *)actions;

- (void)disMiss;

@end
