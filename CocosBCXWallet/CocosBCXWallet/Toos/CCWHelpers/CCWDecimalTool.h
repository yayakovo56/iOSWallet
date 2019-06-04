//
//  TWDecimalTool.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCWDecimalTool : NSObject

/** string类型转NSDecimalNumber */
+(NSDecimalNumber *)CCW_decimalNumberWithString:(NSString *)stringValue;

/**
 计算两数积 = 乘数 * 被乘数
 
 @param multiplier 乘数
 @param faciend 被乘数
 */
+(NSDecimalNumber *)CCW_multiplyTotalAssetsWithMultiplier:(NSString *)multiplier faciend:(NSString *)faciend;

/**
 汇率转换(向下取正)

 @param price 需要转换的价格
 @param scale 小数点
 */
+(NSString *)CCW_convertRateWithPrice:(NSString *)price scale:(NSInteger)scale;


/**
 截取NSString变量的后几位
 
 @param stringValue 源变量
 @param aScale 小数点后面多少位
 @return 向下取正后的值
 */
+(NSString *)CCW_decimalSubScaleString:(NSString *)stringValue scale:(NSInteger) aScale;

@end
