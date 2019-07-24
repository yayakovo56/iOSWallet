//
//  CCWNHAssetOrderModel.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCWAssetsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWNHAssetOrderModel : NSObject

@property (nonatomic, copy) NSString *seller;
@property (nonatomic, copy) NSString *asset_qualifier;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSDictionary *price;
@property (nonatomic, copy) NSString *world_view;
@property (nonatomic, copy) NSString *base_describe;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *nh_asset_id;
@property (nonatomic, copy) NSString *otcaccount;
@property (nonatomic, copy) NSString *nh_hash;
@property (nonatomic, copy) NSString *expiration;

//////////////// 辅助 ////////////////
@property (nonatomic, copy) NSString *sellername;

@property (nonatomic, strong) CCWAssetsModel *priceModel;
@end

NS_ASSUME_NONNULL_END
