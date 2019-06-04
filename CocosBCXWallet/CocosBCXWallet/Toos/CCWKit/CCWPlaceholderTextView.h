//
//  CCWPlaceholderTextView.h
//  
//
//  Created by 邵银岭 on 15/8/21.
//  Copyright (c) 2015年 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCWPlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) IBInspectable  NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@end
