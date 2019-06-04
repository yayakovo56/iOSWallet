//
//  MBProgressHUD+YS.m
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//

#import "MBProgressHUD+YSAdd.h"
#import "UIColor+YSAdd.h"

@implementation MBProgressHUD (YSAdd)

+ (void)showSuccess:(NSString *)success
{
    [self hideHUD];
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self hideHUD];
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showLoadingMessageNeedDimBack:(NSString *)message
{
    [self hideHUD];
    return [self showMessage:message needDimBack:YES];
}

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message
{
    [self hideHUD];
    return [self showMessage:message needDimBack:NO];
}
+ (MBProgressHUD *)showMessage:(NSString *)message needDimBack:(BOOL)needDisBack {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = needDisBack;
    return hud;
}

+ (void)customTransformWithView:(UIView *)customView Options:(UIViewAnimationOptions)options
{
    [UIView animateWithDuration:0.25f delay: 0.0f options:options animations:^{
        customView.transform = CGAffineTransformRotate(customView.transform, M_PI / 2);
    } completion: ^(BOOL finished) {
        if (finished) {
            [self customTransformWithView:customView Options:UIViewAnimationOptionCurveLinear];
//            if (animating) {
//                [self customTransformWithView:customView Options:UIViewAnimationOptionCurveLinear];
//            } else if (options != UIViewAnimationOptionCurveEaseOut) {
//
//                [self customTransformWithView: UIViewAnimationOptionCurveEaseOut];
//            }
        }
    }];
}
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}
#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"seele_error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}


/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标 37*37
 *  @param view 显示的视图
 */
+ (void)showHUDWithText:(NSString *)text
                   icon:(NSString *)icon
                   view:(UIView *)view {
    
    __block UIView *blockView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
    if (blockView == nil) blockView = [UIApplication sharedApplication].keyWindow;
        // 快速显示一个提示信息
        MBProgressHUD *hud = [self showHUDAddedTo:blockView animated:YES];
        hud.color = [UIColor ys_colorWithARGB:0x5f5f5f];//[[UIColor darkGrayColor] colorWithAlphaComponent:0.6]; 0x999999
//        hud.labelText = text;
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14];
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        hud.square = YES;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        
        // 1秒之后再消失
        [hud hide:YES afterDelay:0.7];
    });
}

+ (void)showHUDWithText:(NSString *)text
                   icon:(NSString *)icon {
    [self showHUDWithText:text icon:icon view:nil];
}

+ (void)showMessage:(NSString *)text {
    [self showMessage:text mode:MBProgressHUDModeText view:nil];
}

+ (void)showMessage:(NSString *)text delay:(float)delay view:(UIView *)view {
    __block UIView *blockView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (blockView == nil) blockView = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD *HUD = [self showHUDAddedTo:blockView animated:YES];
        HUD.color = [UIColor ys_colorWithARGB:0x5f5f5f];
        HUD.userInteractionEnabled = NO;
        HUD.removeFromSuperViewOnHide = YES;
//        HUD.labelText = text;
        HUD.detailsLabelText = text;
        HUD.detailsLabelFont = [UIFont systemFontOfSize:14];
        HUD.mode = MBProgressHUDModeText;
        [HUD hide:YES afterDelay:delay];
    });
}

+ (void)showMessage:(NSString *)text delay:(float)delay view:(UIView *)view completion:(void (^)(void))completion {
    __block UIView *blockView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (blockView == nil) blockView = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD *HUD = [[self alloc] initWithView:blockView];
        HUD.userInteractionEnabled = NO;
        HUD.removeFromSuperViewOnHide = YES;
        HUD.color = [UIColor ys_colorWithARGB:0x5f5f5f];
//        HUD.labelText = text;
        HUD.detailsLabelText = text;
        HUD.detailsLabelFont = [UIFont systemFontOfSize:14];
        HUD.mode = MBProgressHUDModeText;
        HUD.minShowTime = delay;
        [view addSubview:HUD];
        [HUD showAnimated:YES whileExecutingBlock:^{
            
        } completionBlock:completion];
    });
}

+ (void)showMessage:(NSString *)text
               mode:(MBProgressHUDMode)mode
               view:(UIView *)view {
    __block UIView *blockView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (blockView == nil) blockView = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD *HUD = [self showHUDAddedTo:blockView animated:YES];
        HUD.mode = mode;
        HUD.color = [UIColor ys_colorWithARGB:0x5f5f5f];
        HUD.removeFromSuperViewOnHide = YES;
//        HUD.labelText = text;
        HUD.detailsLabelText = text;
        HUD.detailsLabelFont = [UIFont systemFontOfSize:14];
        HUD.minSize = CGSizeMake(100.f, 100.f);
        
        HUD.animationType = MBProgressHUDAnimationZoom;
        HUD.margin = 8;
        [view addSubview:HUD];
        [HUD show:YES];
    });
}

+ (void)showLocation:(NSString *)text view:(UIView *)view offset:(float)offset{
    __block UIView *blockView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (blockView == nil) blockView = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD *HUD = [[self alloc] initWithView:blockView];
        HUD.color = [UIColor ys_colorWithARGB:0x5f5f5f];

        HUD.mode = MBProgressHUDModeText;
        HUD.removeFromSuperViewOnHide = YES;
//        HUD.labelText = text;
        HUD.detailsLabelText = text;
        HUD.detailsLabelFont = [UIFont systemFontOfSize:14];
        if (offset > 0) {
            HUD.yOffset = offset;
        }
        HUD.margin = 8;
        HUD.animationType = MBProgressHUDAnimationZoom;
        [view addSubview:HUD];
        [HUD show:YES];
    });
}


/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD {
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view {
//    __block UIView *blockView = view;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (blockView == nil) blockView = [UIApplication sharedApplication].keyWindow;
//    });
    [self hideHUDForView:view animated:YES];
    
}

@end
