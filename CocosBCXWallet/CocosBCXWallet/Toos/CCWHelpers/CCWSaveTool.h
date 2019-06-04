//
//  CCWSaveTool.h
//  LYLink
//
//  Created by SYLing on 2016/11/29.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCWSaveTool : NSObject

/**
 *  读取数据
 */
+ (id)objectForKey:(NSString *)defaultName;
/**
 * 存储数据
 */
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

/**
 删除数据

 @param aStrKey
 */
+(void)removeObject:(NSString *)aStrKey;

/**
 * 读取数值
 */
+ (CGFloat)floatForKey:(NSString *)defaultName;
/**
 * 存储数值
 */
+ (void)setFloat:(CGFloat)value forKey:(NSString *)defaultName;
/**
 * 读取BOOL值
 */
+ (BOOL)boolForKey:(NSString *)defaultName;
/**
 * 存储BOOL值
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

/**
 *  生成缓存目录全路径
 */
+ (NSString *)cacheDirPathWithFilePath:(NSString *)filePath;
/**
 *  生成文档目录全路径
 */
+ (NSString *)documentDirPathWithFilePath:(NSString *)filePath;
/**
 *  生成临时目录全路径
 */
+ (NSString *)tempDirPathWithFilePath:(NSString *)filePath;

/**
 语音缓存路径不截取

 @param fileName 文件名
 */
+(NSString *)cachePathWith:(NSString *)fileName;
@end
