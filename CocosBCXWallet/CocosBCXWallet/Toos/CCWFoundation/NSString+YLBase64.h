//
//  NSString+YLBase64.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YLBase64)
+ (NSString *)yl_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)yl_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)yl_base64EncodedString;
- (NSString *)yl_base64DecodedString;
- (NSData *)yl_base64DecodedData;
@end
