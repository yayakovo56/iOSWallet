//
//  CCWAnimator.m
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWAnimator.h"

@implementation CCWAnimator

//设置动画的时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.25;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
//设置怎样展示动画
//无论是弹出还是销毁都会调用这个方法来设置动画
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containnerView = [transitionContext containerView];
    
    if (self.presented) { // modal时候
        
        //    1.获取toView
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

        containnerView.backgroundColor = self.contantColor;
        containnerView.alpha = 0.0;
        
        toView.transform = self.isAlrent ? CGAffineTransformMakeScale(0.1, 0.1) : CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            containnerView.alpha = 1.0;
            
            toView.transform = CGAffineTransformIdentity;
            [toView layoutIfNeeded];
            
        }completion:^(BOOL finished) {
            //  等动画结束的时候,要告诉系统动画已经结束
            [transitionContext completeTransition:YES];
        }];
        
        
    }else{ // dissmiss时候
        
        //   1.获取视图
        //UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            containnerView.alpha = 0.0;
            
        }completion:^(BOOL finished) {
            //  等动画结束的时候,要告诉系统动画已经结束
            [transitionContext completeTransition:YES];
        }];
        
        
    }
    
}
- (UIColor *)contantColor {
    if (!_contantColor) {
        _contantColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    }
    return _contantColor;
}

@end
