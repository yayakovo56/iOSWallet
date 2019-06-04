//
//  NSMutableAttributedString+Helper.m
//  YCPublicCocosHDWallet
//
//  Created by xiaoliang on 2017/9/1.
//  Copyright © 2017年 xiaoliang. All rights reserved.
//

#import "NSMutableAttributedString+Helper.h"

@implementation NSMutableAttributedString (Helper)

+ (NSMutableAttributedString *)attributedString:(NSString *)mainStr fromIndex:(NSInteger)fromIndex textColor:(UIColor *)leftTextColor fontSize:(CGFloat)leftFontSize rightColor:(UIColor*)rightColor rightFontSize:(CGFloat)rightFontSize{

    NSMutableAttributedString *result = [NSMutableAttributedString new];
    NSString *leftStr = @"";
    NSString *rightStr = @"";
    if (fromIndex > mainStr.length) {
        return [[NSMutableAttributedString alloc]initWithString:mainStr];
    }else{
        leftStr = [mainStr substringToIndex:fromIndex];
        rightStr = [mainStr substringFromIndex:fromIndex];
    }
    NSAttributedString *sum1 = [[NSAttributedString alloc] initWithString:leftStr attributes:@{NSForegroundColorAttributeName:leftTextColor, NSFontAttributeName:[UIFont systemFontOfSize:leftFontSize]}];
    NSAttributedString *sum2 = [[NSAttributedString alloc] initWithString:rightStr attributes:@{NSForegroundColorAttributeName:rightColor, NSFontAttributeName:[UIFont systemFontOfSize:rightFontSize]}];

    [result appendAttributedString:sum1];
    [result appendAttributedString:sum2];
    return result;
}
@end
