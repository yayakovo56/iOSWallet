//
//  CCWWalletAccount.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/18.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCWWalletAccount : NSObject <NSCoding>
/** <#视图#> */
@property (nonatomic, copy) NSString *account_id;
/** <#视图#> */
@property (nonatomic, copy) NSString *account_name;
/** 模式 account */
@property (nonatomic, copy) NSString *mode;
/** 是否锁定 */
@property (nonatomic, assign) BOOL locked;

@end

NS_ASSUME_NONNULL_END
