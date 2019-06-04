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
/** <#视图#> */
@property (nonatomic, strong) NSNumber *locked_total;
/** <#视图#> */
@property (nonatomic, copy) NSString *asset_id;
/** <#视图#> */
@property (nonatomic, strong) NSNumber *precision;
/** <#视图#> */
@property (nonatomic, copy) NSString *symbol;
/** ID */
@property (nonatomic, copy) NSString *ID;
@end

NS_ASSUME_NONNULL_END
