//
//  CCWOrderDetailViewController.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

typedef NS_ENUM(NSInteger,CCWNHAssetOrderType){
    CCWNHAssetOrderTypeMy = 0,
    CCWNHAssetOrderTypeAllNet = 1
};

#import <UIKit/UIKit.h>
#import "CCWNHAssetOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWOrderDetailViewController : UIViewController

@property (nonatomic, strong) CCWNHAssetOrderModel *orderModel;
/** 订单类型 */
@property (nonatomic, assign) CCWNHAssetOrderType orderType;

/** 删除成功 */
@property (nonatomic, copy) void(^deleteComplete)(CCWNHAssetOrderType orderType);
@end

NS_ASSUME_NONNULL_END
