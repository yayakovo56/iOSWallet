//
//  RSAUtill.h
//  RSA_Data
//
//  Created by SYLing on 2018/5/31.
//  Copyright © 2018年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCWRSAUtill : NSObject
//加密str
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
//加密DATA
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;


/**
 解密
 */
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
@end
