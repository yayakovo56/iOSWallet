//
//  CCWTransRecordModel.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/20.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWTransRecordModel.h"

@implementation CCWAmountFee


@end

@implementation CCWMemo


@end

@implementation CCWOperation

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"fee": [CCWAmountFee class],
             @"amount": [CCWAmountFee class],
             @"memo": [CCWMemo class]
             };
}


@end

@implementation CCWTransRecordModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"operation": [CCWOperation class],
             };
}

- (NSString *)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 获得日期对象
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:timeZone];
    
    NSDate *createDate = [formatter dateFromString:_timestamp];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone* timeZone8 = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [formatter setTimeZone:timeZone8];
    return [formatter stringFromDate:createDate];
}

@end
