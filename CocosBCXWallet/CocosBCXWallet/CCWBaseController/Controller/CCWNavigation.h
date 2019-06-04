//
//  YLNavigation.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (CCWNavigation)

/** 全局设置导航栏背景颜色 */
+ (void)ccw_setDefaultNavBackgroundColor:(UIColor *)color;
/** 全局设置导航栏按钮颜色 */
+ (void)ccw_setDefaultNavBarTintColor:(UIColor *)color;
/** 全局设置导航栏标题颜色 */
+ (void)ccw_setDefaultNavBarTitleColor:(UIColor *)color;
/** 全局设置导航栏黑色分割线是否隐藏*/
+ (void)ccw_setDefaultNavBarShadowImageHidden:(BOOL)hidden;
/** 全局设置状态栏样式*/
+ (void)ccw_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

@end

// -----------------------------------------------------------------------------
@interface UINavigationBar (CCWNavigation)

/** 设置当前 NavigationBar 背景图片*/
- (void)ccw_setBackgroundImage:(UIImage *)image;
/** 设置当前 NavigationBar 背景颜色*/
- (void)ccw_setBackgroundColor:(UIColor *)color;
/** 设置当前 NavigationBar 背景透明度*/
- (void)ccw_setBackgroundAlpha:(CGFloat)alpha;
/** 设置当前 NavigationBar 底部分割线是否隐藏*/
- (void)ccw_setShadowImageHidden:(BOOL)hidden;
/** 设置当前 NavigationBar _UINavigationBarBackIndicatorView (默认的返回箭头)是否隐藏*/
- (void)ccw_setBarBackIndicatorViewHidden:(BOOL)hidden;
/** 设置导航栏所有 barButtonItem 的透明度*/
- (void)ccw_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置当前 NavigationBar 垂直方向上的平移距离*/
- (void)ccw_setTranslationY:(CGFloat)translationY;
/** 获取当前导航栏垂直方向上偏移了多少*/
- (CGFloat)ccw_getTranslationY;

@end

// -----------------------------------------------------------------------------
typedef NS_ENUM(NSInteger, CCWNavigationSwitchStyle) {
    CCWNavigationSwitchStyleTransition = 0,        // 颜色过渡的方式，支付宝个人中心到余额宝切换效果
    CCWNavigationSwitchStyleFakeNavBar = 1,        // 两种不同颜色导航栏，类似微信红包
};

/** UIViewController 导航栏扩展 */
@interface UIViewController (CCWNavigation)

/** 设置当前导航栏侧滑过渡效果*/
- (void)ccw_setNavigationSwitchStyle:(CCWNavigationSwitchStyle)style;
- (CCWNavigationSwitchStyle)ccw_navigationSwitchStyle;

/** 设置当前导航栏是否隐藏，设置隐藏后不会有过渡效果，想要有过渡效果不要隐藏导航栏，而是设置导航栏透明度为 0.0f*/
- (void)ccw_setNavBarHidden:(BOOL)hidden;
- (BOOL)ccw_navBarHidden;

/** 设置当前导航栏的背景图片，即使当前导航栏过渡样式为颜色渐变也为执行两种导航栏样式过渡*/
- (void)ccw_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)ccw_navBarBackgroundImage;

/** 设置当前导航栏的透明度*/
- (void)ccw_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)ccw_navBarBackgroundAlpha;

/** 设置当前导航栏 barTintColor(导航栏背景颜色)*/
- (void)ccw_setNavBackgroundColor:(UIColor *)color;
- (UIColor *)ccw_navBackgroundColor;

/** 设置当前导航栏 TintColor(导航栏按钮等颜色)*/
- (void)ccw_setNavBarTintColor:(UIColor *)color;
- (UIColor *)ccw_navBarTintColor;

/** 设置当前导航栏 titleColor(标题颜色)*/
- (void)ccw_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)ccw_navBarTitleColor;

/** 设置当前导航栏 shadowImage(底部分割线)是否隐藏*/
- (void)ccw_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)ccw_navBarShadowImageHidden;

/** 设置当前导航栏向上的偏移量(浮动导航栏) 默认0不偏移，(0到44之间，顶部露出状态栏，其他情况不好看)*/
- (void)ccw_setNavBarTranslationY:(CGFloat)translationY;
- (CGFloat)ccw_navBarTranslationY;

/** 设置当前状态栏样式 白色/黑色，也可以直接重写 preferredStatusBarStyle */
- (void)ccw_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)ccw_statusBarStyle;

/** 获取当前导航栏高度*/
- (CGFloat)ccw_navgationBarHeight;
/** 获取当前导航栏加状态栏高度*/
- (CGFloat)ccw_navigationBarAndStatusBarHeight;

@end
