//
//  CCWEncryptTool.h
//  RSA_Data
//
//  Created by SYLing on 2018/5/31.
//  Copyright © 2018年 andy. All rights reserved.
//

#define OptionMode uint32_t

#import <Foundation/Foundation.h>

@interface CCWEncryptTool : NSObject
#pragma mark - 加密
/**
 AES加密
 @param password 密码
 */
+ (NSString *)AESEncryptStr:(NSString *)str password:(NSString *)password;
+ (NSData *)AESEncryptData:(NSData *)data password:(NSString *)password;

/**
 AES 16位 加密  （AES128)
 
 @param key 密钥
 @param Iv 向量
 @param mode 加密方式(kCCOptionPKCS7Padding   = 0x0001, kCCOptionECBMode        = 0x0002)
 @return 加密后的data
 */
+ (NSString *)AES128EncryptStr:(NSString *)str Key:(NSString *)key iv:(NSString *)Iv option:(OptionMode)mode;
+ (NSData *)AES128EncrypData:(NSData *)data Key:(NSString *)key iv:(NSString *)Iv option:(OptionMode)mode;

/**
 RSA加密
 @param pubKey 公钥
 */
+ (NSString *)RSAEncryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)RSAEncryptData:(NSData *)data publicKey:(NSString *)pubKey;



#pragma mark - 解密
/**
 AES解密
 @param password 密码
 */
+ (NSString *)AESDecryptStr:(NSString *)base64EncodedString password:(NSString *)password;
+ (NSData *)AESDecryptData:(NSData *)data password:(NSString *)password;

/**
 RSA解密
 @param str 密文
 @param privKey 私钥
 @return 明文
 */
+ (NSString *)RSADecryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)RSADecryptData:(NSData *)data privateKey:(NSString *)privKey;

/**
 AES 16位 解密  （AES128)
 
 @param key 密钥
 @param Iv 向量
 @param mode 加密方式 (kCCOptionPKCS7Padding   = 0x0001, kCCOptionECBMode        = 0x0002)
 @return 解密后的string
 */
+ (NSString *)AES128DecryptString:(NSString *)str Key:(NSString *)key iv:(NSString *)Iv option:(OptionMode)mode;
+ (NSData *)AES128DecryptData:(NSData *)data Key:(NSString *)key iv:(NSString *)Iv option:(OptionMode)mode;



@end
