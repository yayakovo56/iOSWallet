//
//  CCWWalletAccountModel.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/4/11.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCWAssetsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWWalletAccountModel : NSObject

@property (nonatomic, strong) CocosDBAccountModel *dbAccountModel;

@property (nonatomic, strong) CCWAssetsModel *cocosAssets;
@end

NS_ASSUME_NONNULL_END
