//
//  CCWAssetsModel.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/20.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCWAssetsModel : NSObject
/** <#视图#> */
@property (nonatomic, strong) NSNumber *amount;
/** <#视图#> */
@property (nonatomic, strong) NSNumber *eq_precision;
/** <#视图#> */
@property (nonatomic, strong) NSNumber *eq_value;
/** <#视图#> */
@property (nonatomic, copy) NSString *eq_unit;
/** 锁仓总量 */
@property (nonatomic, strong) NSNumber *locked_total;
/** 资产ID */
@property (nonatomic, copy) NSString *asset_id;
/** 小数位 */
@property (nonatomic, strong) NSNumber *precision;
/** 名字 */
@property (nonatomic, copy) NSString *symbol;
/** ID */
@property (nonatomic, copy) NSString *ID;

/************************** 卖出资产辅助 ************************/
/** 是否选择 */
@property (nonatomic, assign) BOOL selectAsset;
@end

NS_ASSUME_NONNULL_END
