//
//  MBProgressHUD+YS.h
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//
// 过期
#define MBHUDDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#import "MBProgressHUD.h"

@interface MBProgressHUD (YSAdd)

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

// 有蒙版
+ (MBProgressHUD *)showLoadingMessageNeedDimBack:(NSString *)message;
// 加载的动画
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message;
/**
 *  显示自定义视图
 *
 *  @param text 显示文本
 *  @param icon 图标名称(37*37)
 */
+ (void)showHUDWithText:(NSString *)text
                   icon:(NSString *)icon;
/**
 *  显示自定义视图
 *
 *  @param text 显示文本
 *  @param icon 图标名称(37*37)
 *  @param view 显示MBProgressHUD的视图
 */
+ (void)showHUDWithText:(NSString *)text
                   icon:(NSString *)icon
                   view:(UIView *)view ;
/**
 *  显示文本
 *
 *  @param text 显示文本
 */
+ (void)showMessage:(NSString *)text;

+ (void)showMessage:(NSString *)text delay:(float)delay view:(UIView *)view;

+ (void)showMessage:(NSString *)text delay:(float)delay view:(UIView *)view completion:(void (^)(void))completion;
/**
 *  显示文本
 *
 *  @param text 显示文本
 *  @param mode 显示样式
 *  @param view 显示MBProgressHUD的视图
 */
+ (void)showMessage:(NSString *)text
               mode:(MBProgressHUDMode)mode
               view:(UIView *)view;
/**
 *  纯文本显示位置
 *
 *  @param text   显示的文本
 *  @param view   显示MBProgressHUD的视图
 *  @param offset Y轴方向上的偏移量
 */
+ (void)showLocation:(NSString *)text view:(UIView *)view offset:(float)offset;
/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD;
/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view;

@end
