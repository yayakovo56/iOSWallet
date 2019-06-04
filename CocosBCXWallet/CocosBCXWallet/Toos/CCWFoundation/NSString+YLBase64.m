//
//  NSString+YLBase64.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSString+YLBase64.h"
#import "NSData+YLBase64.h"

@implementation NSString (YLBase64)
+ (NSString *)yl_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)yl_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)yl_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}
- (NSString *)yl_base64DecodedString
{
    return [NSString yl_stringWithBase64EncodedString:self];
}
- (NSData *)yl_base64DecodedData
{
    return [NSData dataWithBase64EncodedString:self];
}
@end
