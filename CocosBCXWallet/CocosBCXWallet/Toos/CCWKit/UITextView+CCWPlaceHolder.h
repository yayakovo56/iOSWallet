//
//  UITextView+CCWPlaceHolder.h
//  tigerwallet
//
//  Created by andy on 2018/9/10.
//  Copyright © 2018年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CCWPlaceHolder)

/** 占位文字 */
@property (copy, nonatomic) NSString *placeHoldString;

/** 占位文字颜色 */
@property (strong, nonatomic) UIColor *placeHoldColor;

/** 占位文字字体 */
@property (strong, nonatomic) UIFont *placeHoldFont;


@end

NS_ASSUME_NONNULL_END
