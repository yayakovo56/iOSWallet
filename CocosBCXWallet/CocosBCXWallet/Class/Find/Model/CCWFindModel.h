//
//  CCWFindModel.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/6.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCWFindModel : NSObject
/** 分组名称 */
@property (nonatomic, copy) NSString *header;
/** 内容 */
@property (nonatomic, strong) NSArray *data;
@end
