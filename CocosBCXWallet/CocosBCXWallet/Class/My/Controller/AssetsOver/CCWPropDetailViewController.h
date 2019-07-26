//
//  CCWPropDetailViewController.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/22.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWTransferNhAssetViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWPropDetailViewController : UIViewController
/** 资产 */
@property (nonatomic, strong) CCWNHAssetsModel *nhAssetModel;

/** 删除成功 */
@property (nonatomic, copy) void(^deleteNHAssetComplete)();
@end

NS_ASSUME_NONNULL_END
