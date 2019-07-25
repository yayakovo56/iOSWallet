//
//  CCWSelectSellCoinViewController.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWAssetsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWSelectSellCoinViewController : UIViewController

/** 资产模型 */
@property (nonatomic, strong) CCWAssetsModel *selectAssetModel;

/** 选择后的回调 */
@property (nonatomic, copy) void(^selectBlock)(CCWAssetsModel *selectAssetModel);
@end

NS_ASSUME_NONNULL_END
