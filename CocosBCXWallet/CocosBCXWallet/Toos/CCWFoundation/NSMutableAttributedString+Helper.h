//
//  NSMutableAttributedString+Helper.h
//  YCPublicCocosHDWallet
//
//  Created by xiaoliang on 2017/9/1.
//  Copyright © 2017年 xiaoliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Helper)

+ (NSMutableAttributedString *)attributedString:(NSString *)mainStr fromIndex:(NSInteger)fromIndex textColor:(UIColor *)leftTextColor fontSize:(CGFloat)leftFontSize rightColor:(UIColor*)rightColor rightFontSize:(CGFloat)rightFontSize;

@end
