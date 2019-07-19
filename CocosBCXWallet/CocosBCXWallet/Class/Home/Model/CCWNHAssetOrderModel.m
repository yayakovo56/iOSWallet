//
//  CCWNHAssetOrderModel.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWNHAssetOrderModel.h"

@implementation CCWNHAssetOrderModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
}

- (NSString *)expiration
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 获得日期对象
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:timeZone];
    
    NSDate *createDate = [formatter dateFromString:_expiration];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone* timeZone8 = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [formatter setTimeZone:timeZone8];
    return [formatter stringFromDate:createDate];
}

@end
