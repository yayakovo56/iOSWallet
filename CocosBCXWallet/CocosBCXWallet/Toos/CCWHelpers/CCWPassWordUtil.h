//
//  CCWPassWordUtil.h
//  Demo
//
//  Created by 邵银岭 on 2019/1/28.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCWPassWordUtil : NSString

// 验证加密的字符串和当前password是否相等
+ (BOOL)validatePasswordWithSha256:(NSString *)sha256 password:(NSString *)password;

// 随机加密字符串
+ (NSString *)shapwdWithPassword:(NSString *)password;

@end
