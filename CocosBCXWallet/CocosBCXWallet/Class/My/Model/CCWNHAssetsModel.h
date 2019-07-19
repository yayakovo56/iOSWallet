//
//  CCWNHAssetsModel.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCWNHAssetsModel : NSObject
/** 通行资产 */
@property (nonatomic, copy) NSString *asset_qualifier;
@property (nonatomic, copy) NSString *base_describe;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *dealership;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *limit_type;
@property (nonatomic, copy) NSString *nh_asset_active;
@property (nonatomic, copy) NSString *nh_asset_creator;
@property (nonatomic, copy) NSString *nh_asset_owner;
@property (nonatomic, copy) NSString *nh_hash;
@property (nonatomic, copy) NSString *world_view;
@end

NS_ASSUME_NONNULL_END
