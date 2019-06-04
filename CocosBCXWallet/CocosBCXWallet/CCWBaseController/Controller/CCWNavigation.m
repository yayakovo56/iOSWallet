//
//  YLNavigation.m
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWNavigation.h"
#import <objc/runtime.h>

// -----------------------------------------------------------------------------
// UINavigationBar
@implementation UIColor (CCWNavigation)

static char kCCWDefaultNavBarBarTintColorKey;
static char kCCWDefaultNavBarTintColorKey;
static char kCCWDefaultNavBarTitleColorKey;
static char kCCWDefaultNavBarShadowImageHiddenKey;
static char kCCWDefaultStatusBarStyleKey;

/** 颜色过渡*/
+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent {
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}
// --------------------------------------------------- //
/** 全局设置导航栏背景颜色 */
+ (void)ccw_setDefaultNavBackgroundColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kCCWDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UIColor *)defaultNavBackgroundColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kCCWDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}

/** 全局设置导航栏按钮颜色 */
+ (void)ccw_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kCCWDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kCCWDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}

/** 全局设置导航栏标题颜色 */
+ (void)ccw_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kCCWDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UIColor *)defaultNavBarTitleColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kCCWDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}

/** 全局设置导航栏黑色分割线是否隐藏*/
+ (void)ccw_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kCCWDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kCCWDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}

/** 全局设置状态栏样式*/
+ (void)ccw_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kCCWDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UIStatusBarStyle)defaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &kCCWDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
@end

// -----------------------------------------------------------------------------
// UINavigationBar
@implementation UINavigationBar (CCWNavigation)

static char kCCWBackgroundViewKey;
static char kCCWBackgroundImageViewKey;

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kCCWBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView {
    objc_setAssociatedObject(self, &kCCWBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kCCWBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kCCWBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// -> 设置导航栏背景图片
- (void)ccw_setBackgroundImage:(UIImage *)image {
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    if (!self.backgroundImageView) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.subviews.firstObject.bounds];
        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;  // ****
        // _UIBarBackground is first subView for navigationBar
        /** iOS11下导航栏不显示问题 */
        if (self.subviews.count > 0) {
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        } else {
            [self insertSubview:self.backgroundImageView atIndex:0];
        }
    }
    self.backgroundImageView.image = image;
}

// -> 设置导航栏背景颜色
- (void)ccw_setBackgroundColor:(UIColor *)color {
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    
    if (!self.backgroundView) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:self.subviews.firstObject.bounds];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;  // ****
        // _UIBarBackground is first subView for navigationBar
        /** iOS11下导航栏不显示问题 */
        if (self.subviews.count > 0) {
            [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
        } else {
            [self insertSubview:self.backgroundView atIndex:0];
        }
    }
    self.backgroundView.backgroundColor = color;
}
#pragma mark - public method -------
/** 设置当前 NavigationBar 背景透明度*/
- (void)ccw_setBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.subviews.firstObject;
    barBackgroundView.alpha = alpha;
    
    if (self.isTranslucent) {
        if ([barBackgroundView subviews].count > 1) {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    }
    
    if (@available(iOS 11.0, *)) {  // iOS11 下 UIBarBackground -> UIView/UIImageViwe
        for (UIView *view in self.subviews) {
            if ([NSStringFromClass([view class]) containsString:@"UIbarBackGround"]) {
                view.alpha = 0;
            }
        }
        // iOS 下如果不设置 UIBarBackground 下的UIView的透明度，会显示一个白色图层
        if (barBackgroundView.subviews.firstObject) {
            barBackgroundView.subviews.firstObject.alpha = alpha;
        }
    }
}
/** 设置当前 NavigationBar 底部分割线是否隐藏*/
- (void)ccw_setShadowImageHidden:(BOOL)hidden {
    self.shadowImage = hidden ? [UIImage new] : nil;
}
/** 设置当前 NavigationBar _UINavigationBarBackIndicatorView (默认的返回箭头)是否隐藏*/
- (void)ccw_setBarBackIndicatorViewHidden:(BOOL)hidden {
    for (UIView *view in self.subviews) {
        Class _UINavigationBarBackIndicatorViewClass = NSClassFromString(@"_UINavigationBarBackIndicatorView");
        if (_UINavigationBarBackIndicatorViewClass != nil) {
            if ([view isKindOfClass:_UINavigationBarBackIndicatorViewClass]) {
                view.hidden = hidden;
            }
        }
    }
}
/** 设置导航栏所有 barButtonItem 的透明度*/
- (void)ccw_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES) {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if (![view isKindOfClass:_UIBarBackgroundClass]) {
                    view.alpha = alpha;
                }
            }
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if (![view isKindOfClass:_UINavigationBarBackground]) {
                    view.alpha = alpha;
                }
            }
        } else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if (![view isKindOfClass:_UIBarBackgroundClass]) {
                        view.alpha = alpha;
                    }
                }
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if (![view isKindOfClass:_UINavigationBarBackground]) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

/** 设置当前 NavigationBar 垂直方向上的平移距离*/
- (void)ccw_setTranslationY:(CGFloat)translationY {
    // CGAffineTransformMakeTranslation  平移
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}
- (CGFloat)ccw_getTranslationY {
    return self.transform.ty;
}

@end
// -----------------------------------------------------------------------------
/** 因为在 UINavigationController 中使用了 VC 中的扩展方法，所以需要提到上面来声明，否则无法调用*/
@interface UIViewController (ccwNavigation_Add)
// 设置当前 push 是否完成
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
// 当前 VC 是否需要添加一个假的NavigationBar
- (BOOL)shouldAddFakeNavigationBar;
@end
// -----------------------------------------------------------------------------
// UINavigationController
@implementation UINavigationController (ccwNavigation)

static CGFloat ccwPopDuration = 0.12;       // 侧滑动画时间
static int ccwPopDisplayCount = 0;          //
// 当前 pop 进度
- (CGFloat)ccwPopProgress {
    CGFloat all = 60 * ccwPopDuration;
    int current = MIN(all, ccwPopDisplayCount);
    return current / all;
}

static CGFloat ccwPushDuration = 0.10;
static int ccwPushDisplayCount = 0;
// 当前 push 进度
- (CGFloat)ccwPushProgress {
    CGFloat all = 60 * ccwPushDuration;
    int current = MIN(all, ccwPushDisplayCount);
    return current / all;
}

#pragma mark - swizzling method
// runtime
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[4] = {
                          NSSelectorFromString(@"_updateInteractiveTransition:"),       // 监听侧滑手势进度
                          @selector(popToViewController:animated:),                     // pop To VC
                          @selector(popToRootViewControllerAnimated:),                  // pop Root VC
                          @selector(pushViewController:animated:)                       // push
                      };
                      
                      for (int i = 0; i < 4;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [[NSString stringWithFormat:@"ccw_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}
// 交换方法 - 监听侧滑手势进度
- (void)ccw_updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    
    // 调用自己
    [self ccw_updateInteractiveTransition:percentComplete];
}
// 交换方法 - pop To VC
- (NSArray<UIViewController *> *)ccw_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        ccwPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:ccwPopDuration];
    [CATransaction begin];
    // 调用自己
    NSArray<UIViewController *> *vcs = [self ccw_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}
// 交换方法 - pop Root VC
- (NSArray<UIViewController *> *)ccw_popToRootViewControllerAnimated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        ccwPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:ccwPopDuration];
    [CATransaction begin];
    // 调用自己
    NSArray<UIViewController *> *vcs = [self ccw_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}
// 交换方法 - push VC
- (void)ccw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        ccwPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:ccwPushDuration];
    [CATransaction begin];
    // 调用自己
    [self ccw_pushViewController:viewController animated:animated];
    [CATransaction commit];
}
// pop
- (void)popNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        ccwPopDisplayCount += 1;
        CGFloat popProgress = [self ccwPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}
// push
- (void)pushNeedDisplay {
    if (self.topViewController && self.topViewController.transitionCoordinator != nil) {
        ccwPushDisplayCount += 1;
        CGFloat pushProgress = [self ccwPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}
// ** 根据进度更新导航栏 **
- (BOOL)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress {
    // 如果 VC 中有隐藏了导航栏的就不做切换效果
    if ([fromVC ccw_navBarHidden] || [toVC ccw_navBarHidden]) {
        return NO;
    }
    // 如果 VC 中设置了自定义导航栏图片
    if (([fromVC ccw_navBarBackgroundImage] || [toVC ccw_navBarBackgroundImage])) {
        return NO;
    }
    // 如果 VC 中设置了切换样式为两种导航栏
    if ([fromVC ccw_navigationSwitchStyle] == 1 || [toVC ccw_navigationSwitchStyle] == 1) {
        return NO;
    }
    // 如果 VC 中两个导航栏的透明度不一样，也使用假的导航栏
    if ([fromVC ccw_navBarBackgroundAlpha] != [toVC ccw_navBarBackgroundAlpha]) {
        return NO;
    }
    // -------------------------------------------------------------------------
    // 颜色过渡
    {
        // 导航栏按钮颜色
        UIColor *fromTintColor = [fromVC ccw_navBarTintColor];
        UIColor *toTintColor = [toVC ccw_navBarTintColor];
        UIColor *newTintColor = [UIColor middleColor:fromTintColor toColor:toTintColor percent:progress];
        [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
        // 导航栏标题颜色
        UIColor *fromTitleColor = [fromVC ccw_navBarTitleColor];
        UIColor *toTitleColor = [toVC ccw_navBarTitleColor];
        UIColor *newTitleColor = [UIColor middleColor:fromTitleColor toColor:toTitleColor percent:progress];
        [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
        // 导航栏背景颜色
        UIColor *fromBarTintColor = [fromVC ccw_navBackgroundColor];
        UIColor *toBarTintColor = [toVC ccw_navBackgroundColor];
        UIColor *newBarTintColor = [UIColor middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
        [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
        // 导航栏背景透明度
        CGFloat fromBarBackgroundAlpha = [fromVC ccw_navBarBackgroundAlpha];
        CGFloat toBarBackgroundAlpha = [toVC ccw_navBarBackgroundAlpha];
        CGFloat newBarBackgroundAlpha = [UIColor middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
    }
    return YES;
}
#pragma mark - deal the gesture of return
// 导航栏返回按钮点击
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive]) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10) {
            if (@available(iOS 10.0, *)) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    __strong typeof (self) pThis = weakSelf;
                    [pThis dealInteractionChanges:context];
                }];
            }
        } else {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}
// 处理侧滑手势
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key) {
        if (![self.topViewController shouldAddFakeNavigationBar]) {
            UIColor *curColor = [[context viewControllerForKey:key] ccw_navBackgroundColor];
            CGFloat curAlpha = [[context viewControllerForKey:key] ccw_navBarBackgroundAlpha];
            [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
            [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
        }
    };
    
    if ([context isCancelled]) {        // 自动取消侧滑手势
        double cancelDuration = [context transitionDuration] * [context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {                            // 自动完成侧滑手势
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}
#pragma mark - setter
// -> 设置当前导航栏需要改变导航栏背景透明度
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar ccw_setBackgroundAlpha:barBackgroundAlpha];
}
// -> 设置当前导航栏背景图片
- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar ccw_setBackgroundImage:backgroundImage];
}
// -> 设置当前导航栏 barTintColor | 导航栏背景颜色
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar ccw_setBackgroundColor:barTintColor];
}
// -> 设置当前导航栏的 TintColor | 按钮颜色
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}
// -> 设置当前导航栏 titleColor | 标题颜色
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor {
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}
// -> 设置当前导航栏 shadowImageHidden
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = hidden ? [UIImage new] : nil;
}
#pragma mark - 状态栏 -----------------------------------------------------------
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}
#pragma mark - 屏幕旋转相关 ------------------------------------------------------
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}
// 横屏后设置是否隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return [self.topViewController prefersStatusBarHidden];
}
// 默认的屏幕方向（当前 ViewController 必须是通过模态出来的 UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end

// -----------------------------------------------------------------------------
// UIViewController
/** VC 导航栏扩展实现*/
@implementation UIViewController (ccwNavigation)

static char kCCWPushToCurrentVCFinishedKey;         // 跳转到当前是否完成
static char kCCWPushToNextVCFinishedKey;            // 跳转到下一个VC是否完成

static char kCCWNavSwitchStyleKey;                  // 当前导航栏切换样式
static char kCCWNavBarHiddenKey;                    // 当前导航栏是否隐藏
static char kCCWNavBarBackgroundImageKey;           // 当前导航栏背景图片
static char kCCWNavBarBackgroundAlphaKey;           // 当前导航栏背景透明度
static char kCCWNavBarBackgroundColorKey;           // 当前导航栏背景颜色
static char kCCWNavBarTintColorKey;                 // 当前导航栏按钮颜色
static char kCCWNavBarTitleColorKey;                // 当前导航栏标题颜色
static char kCCWNavBarShadowImageHiddenKey;         // 当前导航栏底部黑线是否隐藏
static char kCCWNavBarTranslationYKey;              // 当前导航栏浮动高度Y
static char kCCWStatusBarStyleKey;                  // 当前导航栏状态栏样式

static char kCCWFakeNavigationBarKey;               // 假的导航栏，实现两种颜色导航栏

// runtime
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // -> 交换方法
        SEL needSwizzleSelectors[4] = {
            @selector(viewWillAppear:),
            @selector(viewWillDisappear:),
            @selector(viewDidAppear:),
            @selector(viewDidDisappear:)
        };
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"ccw_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}
// 交换方法 - 将要出现
- (void)ccw_viewWillAppear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        [self setPushToNextVCFinished:NO];
        // iOS 10.3.1 下第一个VC也会出现默认导航栏返回箭头的BUG，
        if (self.navigationController.viewControllers.count == 1) {
            [self.navigationController.navigationBar ccw_setBarBackIndicatorViewHidden:YES];
        } else {
            [self.navigationController.navigationBar ccw_setBarBackIndicatorViewHidden:NO];
        }
        // 当前导航栏是否隐藏
        [self.navigationController setNavigationBarHidden:[self ccw_navBarHidden] animated:YES];
        // 恢复导航栏浮动偏移
        if ([self ccw_navBarTranslationY] > 0) {
            [self.navigationController.navigationBar ccw_setTranslationY:0.0f];
            [self.navigationController.navigationBar ccw_setBarButtonItemsAlpha:1.0f hasSystemBackIndicator:YES];
        }
        // 添加一个假 NavigationBar
        if ([self shouldAddFakeNavigationBar]) {
            [self addFakeNavigationBar];
        }
        // 更新导航栏信息
        if (![self ccw_navBarHidden]) {
            // ** 当两个VC都是颜色过渡的时候，这里不设置背景，不然会闪动一下 **
            if (!self.fakeNavigationBar && ![self isTransitionStyle]) {
                if ([self ccw_navBarBackgroundImage]) {
                    [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:[self ccw_navBarBackgroundImage]];
                } else {
                    [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self ccw_navBackgroundColor]];
                }
            }
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self ccw_navBarTintColor]];
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self ccw_navBarTitleColor]];
        }
    }
    // 调自己
    [self ccw_viewWillAppear:animated];
}
// 交换方法 - 已经出现
- (void)ccw_viewDidAppear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        // 当前导航栏是否隐藏
        [self.navigationController setNavigationBarHidden:[self ccw_navBarHidden] animated:YES];
        [self removeFakeNavigationBar];     // 删除 fake NavigationBar
        [self updateNavigationInfo];
    }
    // 调自己
    [self ccw_viewDidAppear:animated];
}
// 交换方法 - 将要消失
- (void)ccw_viewWillDisappear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        [self setPushToNextVCFinished:YES];
        // 当前导航栏是否隐藏
        [self.navigationController setNavigationBarHidden:[self ccw_navBarHidden] animated:YES];
        // 恢复导航栏浮动偏移
        if ([self ccw_navBarTranslationY] > 0) {
            [self.navigationController.navigationBar ccw_setTranslationY:0.0f];
            [self.navigationController.navigationBar ccw_setBarButtonItemsAlpha:1.0f hasSystemBackIndicator:YES];
        }
        // 更新导航栏信息
        if (![self ccw_navBarHidden]) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self ccw_navBarTintColor]];
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self ccw_navBarTitleColor]];
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self ccw_navBarBackgroundAlpha]];
        }
    }
    // 调自己
    [self ccw_viewWillDisappear:animated];
}
// 交换方法 - 已经消失
- (void)ccw_viewDidDisappear:(BOOL)animated {
    // 删除 fake NavigationBar
    [self removeFakeNavigationBar];
    // 调用自己
    [self ccw_viewDidDisappear:animated];
}
// 更新导航栏
- (void)updateNavigationInfo {
    if ([self ccw_navBarHidden]) {
        return;
    }
    if (!self.fakeNavigationBar) {
        if ([self ccw_navBarBackgroundImage]) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:[self ccw_navBarBackgroundImage]];
        } else {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self ccw_navBackgroundColor]];
        }
    }
    [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self ccw_navBarTintColor]];
    [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self ccw_navBarTitleColor]];
    [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self ccw_navBarBackgroundAlpha]];
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self ccw_navBarShadowImageHidden]];
    [self ccw_setNavBarTranslationY:[self ccw_navBarTranslationY]];
}
#pragma mark - fake navigation bar ---------------------------------------------
- (UIViewController *)fromVC {
    return [self.navigationController.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
}
- (UIViewController *)toVC {
    return [self.navigationController.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
}
// 是否需要添加一个假的 NavigationBar
- (BOOL)shouldAddFakeNavigationBar {
    // 判断当前导航栏交互的两个VC其中是否设置了导航栏样式为两种颜色导航栏，或者设置了导航栏背景图片，或者透明度不一致(用过渡不好看..)
    UIViewController *fromVC = [self fromVC];
    UIViewController *toVC = [self toVC];
    if ((fromVC && ([fromVC ccw_navigationSwitchStyle] == 1 || [fromVC ccw_navBarBackgroundImage])) ||
        (toVC && ([toVC ccw_navigationSwitchStyle] == 1 || [toVC ccw_navBarBackgroundImage])) ||
        [fromVC ccw_navBarHidden] != [toVC ccw_navBarHidden] ||
        [fromVC ccw_navBarBackgroundAlpha] != [toVC ccw_navBarBackgroundAlpha]) {
        return YES;
    }
    return NO;
}
// 是否都是颜色渐变过渡
- (BOOL)isTransitionStyle {
    UIViewController *fromVC = [self fromVC];
    UIViewController *toVC = [self toVC];
    // 如果 VC 中有隐藏了导航栏的就不做切换效果
    if ([fromVC ccw_navBarHidden] || [toVC ccw_navBarHidden]) {
        return NO;
    }
    // 如果 VC 中设置了自定义导航栏图片
    if (([fromVC ccw_navBarBackgroundImage] || [toVC ccw_navBarBackgroundImage])) {
        return NO;
    }
    // 如果 VC 中设置了切换样式为两种导航栏
    if ([fromVC ccw_navigationSwitchStyle] == 1 || [toVC ccw_navigationSwitchStyle] == 1) {
        return NO;
    }
    // 如果 VC 中两个导航栏的透明度不一样，也使用假的导航栏
    if ([fromVC ccw_navBarBackgroundAlpha] != [toVC ccw_navBarBackgroundAlpha]) {
        return NO;
    }
    return YES;
}
// 添加一个假的 NavigationBar
- (void)addFakeNavigationBar {
    UIViewController *fromVC = [self fromVC];
    UIViewController *toVC = [self toVC];
    
    [fromVC removeFakeNavigationBar];
    [toVC removeFakeNavigationBar];
    
    if (!fromVC.fakeNavigationBar && ![fromVC ccw_navBarHidden]) {
        CGRect fakeNavFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),
                                         [self ccw_navigationBarAndStatusBarHeight]);
        // 1. 判断边缘布局的方式，UIRectEdgeNone 是以导航栏下面开始的
        if (fromVC.edgesForExtendedLayout == UIRectEdgeNone) {
            fakeNavFrame = CGRectMake(0, -[self ccw_navigationBarAndStatusBarHeight], CGRectGetWidth(self.view.bounds),
                                      [self ccw_navigationBarAndStatusBarHeight]);
        }
        // 2. 判断当前 vc 是否是 UITableViewController 或 UICollectionViewController , 因为这种 vc.view 会为 scrollview
        // ** 虽然 view frame 为全屏开始，但是因为安全区域，使得内容视图在导航栏下面 **
        // ** 千万不要再设置 edgesForExtendedLayout 为 None，因为 tableview 默认开启了 clipsToBounds 会使得添加的导航栏失效 **
        if ([fromVC.view isKindOfClass:[UIScrollView class]]) {
            // 需要重新计算导航栏在滚动视图中的位置
            fakeNavFrame = [fromVC.view convertRect:fakeNavFrame fromView:fromVC.navigationController.view];
        }
        fromVC.fakeNavigationBar = [[UIImageView alloc] initWithFrame:fakeNavFrame];
        //fromVC.fakeNavigationBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        fromVC.fakeNavigationBar.backgroundColor = [fromVC ccw_navBackgroundColor];
        fromVC.fakeNavigationBar.image = [fromVC ccw_navBarBackgroundImage];
        fromVC.fakeNavigationBar.alpha = [fromVC ccw_navBarBackgroundAlpha];
        [fromVC.view addSubview:fromVC.fakeNavigationBar];
        [fromVC.view bringSubviewToFront:fromVC.fakeNavigationBar];
        //
        [fromVC.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:0.0f];
    }
    if (!toVC.fakeNavigationBar && ![toVC ccw_navBarHidden]) {
        CGRect fakeNavFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),[self ccw_navigationBarAndStatusBarHeight]);
        // 判断边缘布局的方式，UIRectEdgeNone 是以导航栏下面开始的
        if (toVC.edgesForExtendedLayout == UIRectEdgeNone) {
            fakeNavFrame = CGRectMake(0, -[self ccw_navigationBarAndStatusBarHeight], CGRectGetWidth(self.view.bounds),
                                      [self ccw_navigationBarAndStatusBarHeight]);
        }
        // 2. 判断当前 vc 是否是 UITableViewController 或 UICollectionViewController , 因为这种 vc.view 会为 tableview
        // 虽然 view frame 为全屏开始，但是内容视图在不设置 edgesForExtendedLayout 的情况下 adjustedContentInset 为在导航栏下面
        if ([toVC.view isKindOfClass:[UIScrollView class]]) {
            fakeNavFrame = [toVC.view convertRect:fakeNavFrame fromView:toVC.navigationController.view];
            CGPoint offset = ((UIScrollView *)toVC.view).contentOffset;
            if (offset.y == 0) {
                fakeNavFrame = CGRectMake(fakeNavFrame.origin.x, fakeNavFrame.origin.y -[self ccw_navigationBarAndStatusBarHeight], fakeNavFrame.size.width, fakeNavFrame.size.height);
            }
        }
        //
        toVC.fakeNavigationBar = [[UIImageView alloc] initWithFrame:fakeNavFrame];
        //toVC.fakeNavigationBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        toVC.fakeNavigationBar.backgroundColor = [toVC ccw_navBackgroundColor];
        toVC.fakeNavigationBar.image = [toVC ccw_navBarBackgroundImage];
        toVC.fakeNavigationBar.alpha = [toVC ccw_navBarBackgroundAlpha];
        [toVC.view addSubview:toVC.fakeNavigationBar];
        [toVC.view bringSubviewToFront:toVC.fakeNavigationBar];
        //
        [toVC.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:0.0f];
    }
}
// 将假的导航栏背景删除
- (void)removeFakeNavigationBar {
    if (self.fakeNavigationBar) {
        [self.fakeNavigationBar removeFromSuperview];
        self.fakeNavigationBar = nil;
    }
}
//
- (UIImageView *)fakeNavigationBar {
    return (UIImageView *)objc_getAssociatedObject(self, &kCCWFakeNavigationBarKey);
}
- (void)setFakeNavigationBar:(UIImageView *)navigationBar {
    objc_setAssociatedObject(self, &kCCWFakeNavigationBarKey, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - private method --------------------------------------------------
- (BOOL)canUpdateNavigationBar {
    // 如果当前有导航栏，且当前是全屏，//且没有手动设置隐藏导航栏
    if (self.navigationController) {  //  && CGRectEqualToRect(self.view.frame, [UIScreen mainScreen].bounds)
        return YES;
    }
    return NO;
}
/** 回到当前VC是否完成*/
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kCCWPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kCCWPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
/** 跳转到下个VC是否完成*/
- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kCCWPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kCCWPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
#pragma mark - public method ---------------------------------------------------
/** 设置当前导航栏侧滑过度效果*/
- (void)ccw_setNavigationSwitchStyle:(CCWNavigationSwitchStyle)style {
    objc_setAssociatedObject(self, &kCCWNavSwitchStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CCWNavigationSwitchStyle)ccw_navigationSwitchStyle {
    id style = objc_getAssociatedObject(self, &kCCWNavSwitchStyleKey);
    return style?[style integerValue]:0;
}

/** 设置隐藏当前导航栏*/
- (void)ccw_setNavBarHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kCCWNavBarHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)ccw_navBarHidden {
    id hidden = objc_getAssociatedObject(self, &kCCWNavBarHiddenKey);
    return hidden?[hidden boolValue]:NO;
}

/** 设置当前导航栏的背景图片*/
- (void)ccw_setNavBarBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kCCWNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)ccw_navBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kCCWNavBarBackgroundImageKey);
    return image?: nil;
}

/** 当前导航栏的透明度*/
- (void)ccw_setNavBarBackgroundAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, &kCCWNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
}
- (CGFloat)ccw_navBarBackgroundAlpha {
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kCCWNavBarBackgroundAlphaKey);
    return barBackgroundAlpha ? [barBackgroundAlpha floatValue] : 1.0;
}
/** 设置当前导航栏 barTintColor(导航栏背景颜色)*/
- (void)ccw_setNavBackgroundColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kCCWNavBarBackgroundColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self pushToCurrentVCFinished] && ![self pushToNextVCFinished]) {
        [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
    }
}
- (UIColor *)ccw_navBackgroundColor {
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kCCWNavBarBackgroundColorKey);
    return (barTintColor != nil) ? barTintColor : [UIColor defaultNavBackgroundColor];
}
/** 设置当前导航栏 TintColor(导航栏按钮等颜色)*/
- (void)ccw_setNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kCCWNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (![self pushToNextVCFinished]) {
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
    }
}
- (UIColor *)ccw_navBarTintColor {
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kCCWNavBarTintColorKey);
    return (tintColor != nil) ? tintColor : [UIColor defaultNavBarTintColor];
}

/** 设置当前导航栏 titleColor(标题颜色)*/
- (void)ccw_setNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kCCWNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (![self pushToNextVCFinished]) {
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
    }
}
- (UIColor *)ccw_navBarTitleColor {
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kCCWNavBarTitleColorKey);
    return (titleColor != nil) ? titleColor : [UIColor defaultNavBarTitleColor];
}

/** 设置当前导航栏 shadowImage(底部分割线)是否隐藏*/
- (void)ccw_setNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kCCWNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}
- (BOOL)ccw_navBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kCCWNavBarShadowImageHiddenKey);
    return hidden?[hidden boolValue]:[UIColor defaultNavBarShadowImageHidden];
}

/** 当前当前导航栏距离顶部的浮动高度*/
- (void)ccw_setNavBarTranslationY:(CGFloat)translationY {
    if (translationY <= 0) translationY = 0;
    if (translationY >= [self ccw_navgationBarHeight]) translationY = [self ccw_navgationBarHeight];
    
    objc_setAssociatedObject(self, &kCCWNavBarTranslationYKey, @(translationY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController.navigationBar ccw_setTranslationY:-translationY];
    [self.navigationController.navigationBar ccw_setBarButtonItemsAlpha:(1.0 - (translationY / [self ccw_navgationBarHeight])) hasSystemBackIndicator:YES];
}
- (CGFloat)ccw_navBarTranslationY {
    id translationY = objc_getAssociatedObject(self, &kCCWNavBarTranslationYKey);
    return translationY?[translationY floatValue]:0;
}

/** 设置当前状态栏样式 白色/黑色 */
- (void)ccw_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kCCWStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];       // 调用导航栏的 preferredStatusBarStyle 方法
}
- (UIStatusBarStyle)ccw_statusBarStyle {
    id style = objc_getAssociatedObject(self, &kCCWStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [UIColor defaultStatusBarStyle];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self ccw_statusBarStyle];
}
/** 获取*/
/** 获取当前导航栏高度*/
- (CGFloat)ccw_navgationBarHeight {
    return CGRectGetHeight(self.navigationController.navigationBar.bounds);
}
/** 获取导航栏加状态栏高度*/
- (CGFloat)ccw_navigationBarAndStatusBarHeight {
    return CGRectGetHeight(self.navigationController.navigationBar.bounds) +
    CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}
#pragma mark - 屏幕旋转相关 ------------------------------------------------------
/** VC 重写以下方法就行*/
// 横屏状态栏是否隐藏
- (BOOL)prefersStatusBarHidden {
    return NO;
}
// 默认不支持旋转 - 支持设备自动旋转
- (BOOL)shouldAutorotate {
    return NO;
}
// 支持竖屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end

/**
 objc_setAssociatedObject 来把一个对象与另外一个对象进行关联。该函数需要四个参数：源对象，关键字，关联的对象和一个关联策略。
 */


