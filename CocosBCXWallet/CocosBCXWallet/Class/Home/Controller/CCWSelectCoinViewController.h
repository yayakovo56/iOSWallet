//
//  CCWSelectCoinViewController.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/4/10.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWInitBaseViewController.h"
typedef NS_ENUM(NSInteger, CCWSelectCoinStyle) {
    CCWSelectCoinStyleTransfer = 0,        // 转账
    CCWSelectCoinStyleReceive = 1,         // 收款
};

NS_ASSUME_NONNULL_BEGIN

@interface CCWSelectCoinViewController : CCWInitBaseViewController

@property (nonatomic, assign) CCWSelectCoinStyle selectCoinStyle;

@property (nonatomic, strong) NSMutableArray *assetsModelArray;
@end

NS_ASSUME_NONNULL_END
