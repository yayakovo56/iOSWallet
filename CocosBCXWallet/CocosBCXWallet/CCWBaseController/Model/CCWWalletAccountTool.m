//
//  CCWWalletAccountTool.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/19.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWWalletAccountTool.h"

@implementation CCWWalletAccountTool
static CCWWalletAccountTool *_shareWalletModel = nil;

+ (instancetype)shareAuthModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareWalletModel = [[CCWWalletAccountTool alloc] init];
    });
    return _shareWalletModel;
}
// 获得保存钱包模型的路径
- (NSString *)getWalletModelFilePath
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"wallet.archive"];
    
    return path;
}

/** 归档authModel对象 */
- (void)archiveWalletAccountModel:(CCWWalletAccount *)accountModel
{
    [NSKeyedArchiver archiveRootObject:accountModel toFile:[self getWalletModelFilePath]];
}

/** 解档authModel对象 */
- (CCWWalletAccount *)unarchiveWalletAccountModel
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getWalletModelFilePath]];
}

/** authModel得到方法 */
- (CCWWalletAccount *)accountModel
{
    return [self unarchiveWalletAccountModel];
}

@end
