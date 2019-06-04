//
//  CCWPassWordUtil.m
//  Demo
//
//  Created by 邵银岭 on 2019/1/28.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWPassWordUtil.h"

@implementation CCWPassWordUtil

// 验证加密的字符串和当前password是否相等
+ (BOOL)validatePasswordWithSha256:(NSString *)sha256 password:(NSString *)password{
    if (sha256.length < 32) {
        return NO;
    }
    NSString *passwordSha256 =  [sha256 substringFromIndex:32];
    NSString *randomStr = [sha256 substringToIndex:32];
    NSString *decryptStr = [NSString stringWithFormat:@"%@%@",randomStr,password];
    NSString *newSha256 = [decryptStr sha256String];
    if ([newSha256 isEqualToString:passwordSha256]) {
        return YES;
    }else{
        return NO;
    }
}

// 随机加密字符串
+ (NSString *)shapwdWithPassword:(NSString *)password{
    NSString *randomStr = [NSString randomStringWithLength:32];
    NSString *encryptStr = [NSString stringWithFormat:@"%@%@", randomStr,password];
    NSString *password_sha256 = [encryptStr sha256String];
    NSString *savePassword = [NSString stringWithFormat:@"%@%@", randomStr,password_sha256];
    return savePassword;
}

@end
