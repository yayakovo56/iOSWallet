//
//  CCWLocalizableTool.h
//  LYLink
//
//  Created by SYLing on 2016/11/29.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCWLocalizableConst.h"

#define CCWLocalizable(key) [[CCWLocalizableTool bundle] localizedStringForKey:(key) value:@"" table:nil]

@interface CCWLocalizableTool : NSObject
+(NSBundle *)bundle;

+(void)initUserLanguage;

// 设置语言
+(void)setUserlanguage:(NSString *)language;
// 语言 系统格式
+(NSString *)userLanguage;

// 语言中文格式
+(NSString *)userLanguageString;

@end
