//
//  CCWDataBase.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@class CCWDataBase;

@interface CCWDataBase : NSObject
{
    FMDatabaseQueue *_dataBaseQueue;
}

+ (instancetype)CCW_shareDatabase;

/**
 判断一张表是否已经存在
 @param tablename 表名
 */
- (BOOL)CCW_isExistTable:(NSString *)tablename;
@end
