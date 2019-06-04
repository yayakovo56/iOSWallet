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
@property (nonatomic, copy) NSString *title;
/** 分组 类型 0 未上榜,1 超级热门,2 精选游戏,3 常用工具 */
@property (nonatomic, copy) NSString *type;
/** 内容 */
@property (nonatomic, strong) NSArray *items;
@end
