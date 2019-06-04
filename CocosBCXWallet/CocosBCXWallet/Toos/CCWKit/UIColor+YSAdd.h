//
//  UIColor+YSAdd.h
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YSAdd)
/**
 * 将16进制颜色转换成UIColor
 *
 **/
+ (UIColor *)getColor:(NSString *)hexColor;
/**
 * 将16进制颜色转换成UIColor 设置透明度 (add by zhangsg 2016.11.14)
 *
 **/
+ (UIColor *)getColor:(NSString *)hexColor alpha:(CGFloat)alpha;
/**
 获取渐变色

 @param colors 颜色变化
 @param gradientType 变化类型从哪个位置到哪个位置
 @param colorSize 大小
 */
+ (UIColor *)gradientColorFromColors:(NSArray*)colors
                           gradientType:(CCWGradientType)gradientType
                              colorSize:(CGSize)colorSize;

+ (UIColor *)ys_colorWithARGB:(NSInteger)argb alpha:(CGFloat)alpha;

+ (UIColor *)ys_colorWithARGB:(NSInteger)argb;

- (UIImage *)color2Image;

@end
