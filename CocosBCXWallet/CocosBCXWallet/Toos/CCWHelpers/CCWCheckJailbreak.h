//
//  CCWCheckJailbreak.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCWCheckJailbreak : NSObject

//越狱后增加的越狱文件判断，判断这些文件是否存在，只要有存在的，就可以认为手机已经越狱了。
+ (NSString *)isJailBreakPath;

//根据是否能打开cydia判断
+ (NSString *)isJailBreakOpenCydia;

//根据是否能获取所有应用的名称判断,没有越狱的设备是没有读取所有应用名称的权限的。
+ (NSString *)isJailBreakReadApp;

//根据使用stat方法来判断cydia是否存在来判断,同时会判断是否有注入动态库。
//+(NSString *) isJailBreakCydia;

//根据读取的环境变量是否有值判断DYLD_INSERT_LIBRARIES环境变量在非越狱的设备上应该是空的，而越狱的设备基本上都会有Library/MobileSubstrate/MobileSubstrate.dylib
+(NSString *)isJailBreakDylib;

//获取BundleID
+ (NSString*) getBundleID;

// 反调试，阻止GDB依附
void disable_gdb(void);

@end
