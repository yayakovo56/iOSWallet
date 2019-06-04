//
//  CCWWalletAccount.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/18.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWWalletAccount.h"
#import <objc/runtime.h>

@implementation CCWWalletAccount

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:strName];
            !value ? : [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        
        id value = [self valueForKey:strName];
        !value ? : [encoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

@end
