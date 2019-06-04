//
//  UIImage+YSAdd.h
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CCWGradientType) {
    CCWGradientTypeTopToBottom = 0,//从上到小
    CCWGradientTypeLeftToRight = 1,//从左到右
    CCWGradientTypeUpleftToLowright = 2,//左上到右下
    CCWGradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (YSAdd)

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  获取渐变颜色图片
 *
 *  @param colors     渐变颜色
 *  @param gradientType 渐变方向
 *  @param imgSize   图片尺寸
 */
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(CCWGradientType)gradientType imgSize:(CGSize)imgSize;

/**
 *  获取渐变颜色图片
 *
 *  @param size       图片尺寸
 *  @param colors     渐变颜色
 *  @param startPoint 开始位置
 *  @param endPoint   结束位置
 */
+ (UIImage*)ys_imageWithGradientColors:(NSArray*)colors size:(CGSize)size startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 *  获取纯色图片
 *  @param color 颜色
 *  @param size  图片尺寸
 */
+ (UIImage *)ys_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  将图片剪裁至目标尺寸
 *
 *  @param sourceImage 原图
 *  @param targetSize 目标尺寸
 *  @return 图片
 */
+ (UIImage *)ys_imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

/**
 *  获取圆角图片
 *
 *  @param cornerRadius 圆角半径
 */
- (UIImage *)ys_roundedCornerWithCornerRadius:(CGFloat)cornerRadius;

- (UIImage *)ys_roundedCorner;

/**
 *  将图片设置成指定大小
 *
 *  @param size 图片大小
 *
 *  @return 图片最终大小
 */
- (UIImage *)ys_scaleToSize:(CGSize)size;

/**
 圆角Image
 
 @param cornerRadius 圆角半径 小于或等于0表示无圆角
 @param corners The corners of a rectangle
 @return 圆角Image
 */
- (UIImage *)ys_roundedCornerWithCornerRadius:(CGFloat)cornerRadius
                               roundingCorner:(UIRectCorner)corners;


- (UIImage *)ys_fixOrientation;

// 改变图片颜色
- (instancetype)imageWithOverlayColor:(UIColor *)overlayColor;


+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;
@end
