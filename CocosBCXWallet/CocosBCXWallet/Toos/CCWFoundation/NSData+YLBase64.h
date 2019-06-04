//
//  NSData+YLBase64.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/1/26.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YLBase64)

/**
 NSData 转  十六进制string
 
 @return NSString类型的十六进制string
 */
- (NSString *)convertDataToHexStr;

// 16 进制字符串转 Data
+ (NSData *)hexStringToData:(NSString *)hexString;

/**
 *  @brief  字符串base64后转data
 *
 *  @param string 传入字符串
 *
 *  @return 传入字符串 base64后的data
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
/**
 *  @brief  NSData转string
 *
 *  @param wrapWidth 换行长度  76  64
 *
 *  @return base64后的字符串
 */
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
/**
 *  @brief  NSData转string 换行长度默认64
 *
 *  @return base64后的字符串
 */
- (NSString *)base64EncodedString;
/**
 *  @brief  NSData转string
 *
 *  @return UTF8后的字符串
 */
- (NSString *)UTF8StringEncodingString;

//转换成十六进制
+ (NSString *)to16:(int)num;

//字符串转为utf－8的编码
+(NSData*)unicodeToUtf8:(NSString*)string;

- (NSString *)hexadecimalString;
@end
