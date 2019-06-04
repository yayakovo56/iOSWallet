//
//  CCWDappModel.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/11/15.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCWDappModel : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image;
/** 标题 */
@property (nonatomic, copy) NSString *name;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 链接 */
@property (nonatomic, copy) NSString *url;

@end
