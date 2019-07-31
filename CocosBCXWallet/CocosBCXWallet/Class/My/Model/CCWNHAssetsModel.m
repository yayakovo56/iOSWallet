//
//  CCWNHAssetsModel.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWNHAssetsModel.h"

@implementation CCWNHAssetsModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
}

- (NSString *)create_time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 获得日期对象
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:timeZone];
    
    NSDate *createDate = [formatter dateFromString:_create_time];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 东八区
//    NSTimeZone* timeZone8 = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    // 获取系统时区
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
//    // 获取本地时区
//    NSTimeZone *zone2 = [NSTimeZone localTimeZone];
//    // 获取默认时区
//    NSTimeZone *zone3 = [NSTimeZone defaultTimeZone];
    
    [formatter setTimeZone:zone1];
    return [formatter stringFromDate:createDate];
}
@end
