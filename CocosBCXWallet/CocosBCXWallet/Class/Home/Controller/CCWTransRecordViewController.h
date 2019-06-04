//
//  CCWTransRecordViewController.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWAssetsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWTransRecordViewController : CCWWalletBaseViewController
/** 资产模型 */
@property (nonatomic, strong) CCWAssetsModel *assetsModel;
@end

NS_ASSUME_NONNULL_END
