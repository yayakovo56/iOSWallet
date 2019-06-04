//
//  CCWCheckJailbreak.m
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWCheckJailbreak.h"
#include <dlfcn.h>
#import <sys/stat.h>
#import <sys/types.h>

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif  // !defined(PT_DENY_ATTACH)

@implementation CCWCheckJailbreak

//越狱后增加的越狱文件判断，判断这些文件是否存在，只要有存在的，就可以认为手机已经越狱了。
+ (NSString *)isJailBreakPath {
    NSArray *jailbreak_tool_paths = @[
                                      @"/Applications/Cydia.app",
                                      @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                      @"/bin/bash",
                                      @"/usr/sbin/sshd",
                                      @"/etc/apt"
                                      ];
    for (int i=0; i<jailbreak_tool_paths.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:jailbreak_tool_paths[i]]) {
//            TWLog(@"The device is jail broken!");
            return @"1";
        }
    }
//    TWLog(@"The device is NOT jail broken!");
    return @"0";
}

//根据是否能打开cydia判断
+ (NSString *)isJailBreakOpenCydia {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
//        TWLog(@"The device is jail broken!");
        return @"1";
    }
//    TWLog(@"The device is NOT jail broken!");
    return @"0";
}
//根据是否能获取所有应用的名称判断,没有越狱的设备是没有读取所有应用名称的权限的。
+ (NSString *)isJailBreakReadApp {
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
//        TWLog(@"The device is jail broken!");
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"User/Applications/" error:nil];
//        TWLog(@"appList = %@", appList);
        return @"1";
    }
//    TWLog(@"The device is NOT jail broken!");
    return @"0";
}
//根据使用stat方法来判断cydia是否存在来判断,同时会判断是否有注入动态库。
//不可e
-(NSString *) isJailBreakCydia{
    int iIsJailBreak = checkCydia();
    if (iIsJailBreak == 0) {
        return @"0";
    }else{
        return @"1";
    }
    return @"0";
}
int checkInjectStat() {
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char*, struct stat*) = stat;
    char *dylib_name = "/usr/lib/system/libsystem_kernel.dylib";
    ret = dladdr(func_stat, &dylib_info);
//    TWLog(@"lib :%s", dylib_info.dli_fname);

    if ((ret = dladdr(func_stat, &dylib_info)) && strncmp(dylib_info.dli_fname, dylib_name, strlen(dylib_name))) {
        //检查正确性 todo huang
        return 0;
    }
    return 1;
}

int checkCydia() {
    struct stat stat_info;
    if (!checkInjectStat()) {
        if (0 == stat("/Applications/Cydia.app", &stat_info)) {
            return 1;
        }
    } else {
        return 1;
    }
    return 0;
}


//根据读取的环境变量是否有值,判断DYLD_INSERT_LIBRARIES环境变量在非越狱的设备上应该是空的，而越狱的设备基本上都会有Library/MobileSubstrate/MobileSubstrate.dylib
char* printEnv(void) {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
//    TWLog(@"%s", env);
    return env;
}

+(NSString *)isJailBreakDylib {
    if (printEnv()) {
//        TWLog(@"The device is jail broken!");
        return @"1";
    }
//    TWLog(@"The device is NOT jail broken!");
    return @"0";
}

//获取BundleID
+ (NSString*) getBundleID
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

// 反调试，阻止GDB依附
void disable_gdb() {
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

@end
