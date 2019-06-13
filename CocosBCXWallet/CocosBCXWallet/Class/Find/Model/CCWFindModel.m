//
//  CCWFindModel.m
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/6.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import "CCWFindModel.h"
#import "CCWDappModel.h"

@implementation CCWFindModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data": [CCWDappModel class],
             };
}

@end
