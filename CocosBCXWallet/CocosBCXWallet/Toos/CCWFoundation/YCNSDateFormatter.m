//
//  YCNSDateFormatter.m
//  YCPublicCocosHDWallet
//
//  Created by Mac on 2017/5/23.
//  Copyright © 2017年 xinhuanwangluo. All rights reserved.
//

#import "YCNSDateFormatter.h"

@implementation YCNSDateFormatter

//性能问题
+ (instancetype)shareFormatter{
    
    static YCNSDateFormatter *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[YCNSDateFormatter alloc] init];
    });
    return _instance;
    
}
/*
YcFormatterStyleYYYYMMddHHmmss ,//YYYY-MM-dd HH:mm:ss
YcFormatterStyleYYYYMMddD,//YYYY.MM.dd
YcFormatterStyleMdHm ,//MM-dd HH:mm
YcFormatterStyleYMdHm ,//YYYY年MM月dd日 HH:mm
YcFormatterStyleMdHmC ,//MM月dd日 HH:mm
YcFormatterStyleYMdC ,//YYYY年MM月dd日
YcFormatterStyleYMd ,//YYYY-MM-dd
 */
- (instancetype)defaultDateFormatterWithStyle:(YcFormatterStyle)style
{
    static YCNSDateFormatter *staticDateFormatter;
    
    staticDateFormatter = [YCNSDateFormatter shareFormatter];
    switch (style) {
        case YcFormatterStyleYYYYMMddHHmmss:
            [staticDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            break;
        case YcFormatterStyleYYYYMMddD:
            [staticDateFormatter setDateFormat:@"YYYY.MM.dd"];
            break;
        case YcFormatterStyleMdHm:
            [staticDateFormatter setDateFormat:@"MM-dd HH:mm"];
            break;
        case YcFormatterStyleYMdHm:
            [staticDateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
            break;
        case YcFormatterStyleMdHmC:
            [staticDateFormatter setDateFormat:@"MM月dd日 HH:mm"];
            break;
        case YcFormatterStyleYMdC:
            [staticDateFormatter setDateFormat:@"YYYY年MM月dd日"];
            break;
        case YcFormatterStyleYMd:
            [staticDateFormatter setDateFormat:@"YYYY-MM-dd"];
            break;
        case YcFormatterStyleYmd:
            [staticDateFormatter setDateFormat:@"YYYY-M-d"];
            break;
        default:
            [staticDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            break;
    }

    return staticDateFormatter;
}


@end
