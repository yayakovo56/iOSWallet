//
//  UIColor+YSAdd.m
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//

#import "UIColor+YSAdd.h"

@implementation UIColor (YSAdd)
/**
 * 将16进制颜色转换成UIColor
 *
 **/
+(UIColor *)getColor:(NSString *)hexColor {
    return [self getColor:hexColor alpha:1.0]; // modify by zhangsg 2016.11.14
}

+(UIColor *)getColor:(NSString *)hexColor alpha:(CGFloat)alpha {
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:alpha];
}

//获取渐变色
+ (UIColor *)gradientColorFromColors:(NSArray*)colors
                           gradientType:(CCWGradientType)gradientType
                              colorSize:(CGSize)colorSize
{
    return [UIColor colorWithPatternImage:[UIImage gradientColorImageFromColors:colors gradientType:gradientType imgSize:colorSize]];
}

+ (UIColor *)ys_colorWithARGB:(NSInteger)argb alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((CGFloat)((argb & 0xFF0000) >> 16))/255.0
                           green:((CGFloat)((argb & 0xFF00) >> 8))/255.0
                            blue:((CGFloat)(argb & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)ys_colorWithARGB:(NSInteger)argb {
    return [self ys_colorWithARGB:argb alpha:1];
}

- (UIImage *)color2Image {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
