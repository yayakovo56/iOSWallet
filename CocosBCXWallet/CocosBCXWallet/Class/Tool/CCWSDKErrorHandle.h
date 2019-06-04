//
//  CCWSDKErrorHandle.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/28.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCWSDKErrorHandle : NSObject
// 请求错误码处理
+ (NSString *)httpErrorStatusWithCode:(id)errorResponse;
@end

NS_ASSUME_NONNULL_END
