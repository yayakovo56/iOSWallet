//
//  CCWEncryptTool.m
//  RSA_Data
//
//  Created by SYLing on 2018/5/31.
//  Copyright © 2018年 andy. All rights reserved.
//

#import "CCWEncryptTool.h"
#import "CCWAES.h"
#import "CCWRSAUtill.h"
#import "NSData+AES128.h"

@implementation CCWEncryptTool
// 加密
+ (NSString *)AESEncryptStr:(NSString *)str password:(NSString *)password{
    return  [CCWAES encrypt:str password:password];
}
+ (NSData *)AESEncryptData:(NSData *)data password:(NSString *)password{
    return [CCWAES encryptData:data password:password];
}

+ (NSString *)AES128EncryptStr:(NSString *)str Key:(NSString *)key iv:(NSString *)Iv option:(uint32_t)mode
{
    return [str AES128EncryptWithKey:key iv:Iv option:mode];
}

+ (NSData *)AES128EncrypData:(NSData *)data Key:(NSString *)key iv:(NSString *)Iv option:(uint32_t)mode
{
    return [data AES128EncryptWithKey:key iv:Iv option:mode];
}

+ (NSString *)RSAEncryptString:(NSString *)str publicKey:(NSString *)pubKey
{
    return [CCWRSAUtill encryptString:str publicKey:pubKey];
}
+ (NSData *)RSAEncryptData:(NSData *)data publicKey:(NSString *)pubKey{
    return [CCWRSAUtill encryptData:data publicKey:pubKey];
}

// 解密
+ (NSString *)AESDecryptStr:(NSString *)base64EncodedString password:(NSString *)password{
    return [CCWAES decrypt:base64EncodedString password:password];
}

+ (NSData *)AESDecryptData:(NSData *)data password:(NSString *)password{
    return [CCWAES decryptData:data password:password];
}

+ (NSString *)RSADecryptString:(NSString *)str privateKey:(NSString *)privKey{
    return [CCWRSAUtill decryptString:str privateKey:privKey];
}

+ (NSData *)RSADecryptData:(NSData *)data privateKey:(NSString *)privKey
{
    return [CCWRSAUtill decryptData:data privateKey:privKey];
}

+ (NSData *)AES128DecryptData:(NSData *)data Key:(NSString *)key iv:(NSString *)Iv option:(uint32_t)mode
{
    return [data AES128DecryptWithKey:key iv:Iv option:mode];
}

+ (NSString *)AES128DecryptString:(NSString *)str Key:(NSString *)key iv:(NSString *)Iv option:(uint32_t)mode
{
    return [str AES128DecryptWithKey:key iv:Iv option:mode];
}
@end
