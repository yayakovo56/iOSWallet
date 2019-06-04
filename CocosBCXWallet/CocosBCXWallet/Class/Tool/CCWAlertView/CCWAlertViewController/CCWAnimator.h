//
//  CCWAnimator.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCWAnimator : NSObject <UIViewControllerAnimatedTransitioning>
/** 是否处于modal状态 */
@property(nonatomic,assign)BOOL presented;


/**
 *  是否为弹出框的形式
 */
@property(nonatomic,assign) BOOL isAlrent;

/** 背景颜色 contantColor */
@property(nonatomic,strong) UIColor *contantColor;
@end
