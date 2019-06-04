//
//  YCNSDateFormatter.h
//  YCPublicCocosHDWallet
//
//  Created by Mac on 2017/5/23.
//  Copyright © 2017年 xinhuanwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YcFormatterStyle) {
    
    YcFormatterStyleYYYYMMddHHmmss ,//YYYY-MM-dd HH:mm:ss
    YcFormatterStyleYYYYMMddD,//YYYY.MM.dd
    YcFormatterStyleMdHm ,//MM-dd HH:mm
    YcFormatterStyleYMdHm ,//YYYY年MM月dd日 HH:mm
    YcFormatterStyleMdHmC ,//MM月dd日 HH:mm
    YcFormatterStyleYMdC ,//YYYY年MM月dd日
    YcFormatterStyleYMd ,//YYYY-MM-dd
    YcFormatterStyleYmd ,//YYYY-M-d

};

@interface YCNSDateFormatter : NSDateFormatter

+ (instancetype)shareFormatter;

- (instancetype)defaultDateFormatterWithStyle:(YcFormatterStyle)style;

@end
