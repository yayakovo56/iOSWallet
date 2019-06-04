//
//  NSData+AES128.m
//  LYTSoketSDKDemo
//
//  Created by Shangen Zhang on 2017/9/4.
//  Copyright © 2017年 深圳柒壹思诺科技有限公司. All rights reserved.
//

#import "NSData+AES128.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+GTMBase64.h"

@implementation NSData (AES128)
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)Iv option:(OptionMode)mode
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [Iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          mode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];;
        return [[resultData lyt_encodingDataString] dataUsingEncoding:NSUTF8StringEncoding];
        //return [[GTMBase64 stringByEncodingData:resultData] dataUsingEncoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}


- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)Iv option:(OptionMode)mode
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [Iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = self.lyt_decodeData;
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          mode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
    
}

@end


@implementation NSString (AES128)

- (NSString *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)Iv option:(OptionMode)mode {
    NSStringEncoding encode = NSUTF8StringEncoding;
    NSData *data = [[self dataUsingEncoding:encode] AES128EncryptWithKey:key iv:Iv option:mode];
    return [[NSString alloc] initWithData:data encoding:encode];
}

- (NSString *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)Iv option:(OptionMode)mode {
    NSStringEncoding encode = NSUTF8StringEncoding;
    NSData *data = [[self dataUsingEncoding:encode] AES128DecryptWithKey:key iv:Iv option:mode];
    return [[NSString alloc] initWithData:data encoding:encode];
}
@end
