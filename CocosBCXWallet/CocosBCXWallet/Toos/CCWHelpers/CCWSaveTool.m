//
//  CCWSaveTool.m
//  LYLink
//
//  Created by SYLing on 2016/11/29.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import "CCWSaveTool.h"

@implementation CCWSaveTool

// 读取数据
+ (id)objectForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

// 存储数据
+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    // 强制写入
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)removeObject:(NSString *) aStrKey{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:aStrKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 存储数值
+ (void)setFloat:(CGFloat)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:defaultName];
    
    // 强制写入
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 读取数值
+ (CGFloat)floatForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] floatForKey:defaultName];
}
// 存储BOOL值
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:defaultName];
    // 强制写入
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 读取BOOL值
+ (BOOL)boolForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}

+ (NSString *)cacheDirPathWithFilePath:(NSString *)filePath
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[filePath lastPathComponent]];
}
+ (NSString *)documentDirPathWithFilePath:(NSString *)filePath
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[filePath lastPathComponent]];
}

+ (NSString *)tempDirPathWithFilePath:(NSString *)filePath
{
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:[filePath lastPathComponent]];
}
/**
 语音缓存路径不截取
 
 @param fileName 文件名
 */
+(NSString *)cachePathWith:(NSString *)fileName
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

@end
