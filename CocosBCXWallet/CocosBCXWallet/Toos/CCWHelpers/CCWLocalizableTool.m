//
//  CCWLocalizableController.m
//  LYLink
//
//  Created by SYLing on 2016/11/29.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import "CCWLocalizableTool.h"

@implementation CCWLocalizableTool
static NSBundle *bundle = nil;

+ ( NSBundle * )bundle{
    return bundle;
}

+(void)initUserLanguage{
    // 简体
    NSString *string = [CCWSaveTool objectForKey:CCWUserLanguage];
    
    if(string.length == 0){
        NSArray* languages = [CCWSaveTool objectForKey:@"AppleLanguages"];
        NSString *current = [languages objectAtIndex:0];
        current = [self convertLanguageStringWithCurrentLan:current];
        string = current;
        [CCWSaveTool setObject:current forKey:CCWUserLanguage];
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:CCWlproj];
    bundle = [NSBundle bundleWithPath:path];
}

+(NSString *)userLanguage{
    
    return [CCWSaveTool objectForKey:CCWUserLanguage];
}

+ (NSString *)userLanguageString
{
    NSString *userLanguage = [self userLanguage];
    if ([userLanguage isEqualToString:CCWLanzh]) {// 中文
        return @"中文";
    }else{
        return @"English";
    }
}

+(void)setUserlanguage:(NSString *)language{
    
    [CCWSaveTool setObject:language forKey:CCWUserLanguage];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:CCWlproj];
    bundle = [NSBundle bundleWithPath:path];
}

+ (NSString *)convertLanguageStringWithCurrentLan:(NSString *)currntStr
{
    NSString *convertStr = CCWLanBase;
    NSArray *lanArray = @[CCWLanEn_us, CCWLanEn, CCWLanzhHans];
    for (NSString *lanstr in lanArray) {
        if ([currntStr containsString:lanstr]) {
            convertStr = lanstr;
            if (lanstr == CCWLanEn_us || lanstr == CCWLanEn) {
                convertStr = CCWLanEn;
            } else {
                convertStr = CCWLanzh;
            }
            break;
        }
    }
    return convertStr;
}

//+ (NSString *)convertLanguageStringWithCurrentLan:(NSString *)currntStr
//{
//    NSArray *lanArray = @[CCWLanEn_us,CCWLanEn,CCWLanzhHans,CCWLanzhHant,CCWLanzh_CCW,CCWLanzh_HK];
//    for (NSString *lanstr in lanArray) {
//        if ([currntStr containsString:lanstr]) {
//            currntStr = lanstr;
//            if (lanstr == CCWLanEn_us || lanstr == CCWLanEn) {
//                currntStr = CCWLanEn;
//            }else if (lanstr == CCWLanzh_CCW || lanstr == CCWLanzh_HK) {
//                currntStr = CCWLanzhHant;
//            } else {
//                currntStr = CCWLanzhHans;
//
//            }
//            break;
//        }else {
//            currntStr = CCWLanBase;
//        }
//    }
//    return currntStr;
//
//}

@end
