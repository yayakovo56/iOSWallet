//
//  CCWTransRecordModel.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/20.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface CCWAmountFee : NSObject

@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, copy) NSString *asset_id;

// 辅助 //
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, strong) NSNumber *precision;

@end
@interface CCWMemo : NSObject

@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *nonce;
@property (nonatomic, copy) NSString *message;

@end

@interface CCWOperation : NSObject

@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, strong) CCWMemo *memo;
@property (nonatomic, strong) CCWAmountFee *fee;
@property (nonatomic, strong) CCWAmountFee *amount;

@end

@interface CCWTransRecordModel : NSObject

@property (nonatomic, strong) NSNumber *block_num;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSArray *op;

/// 辅助 ///
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, assign) BOOL opTypeTransfer;
@property (nonatomic, strong) CCWOperation *operation;
@property (nonatomic, copy) NSString *timestamp;
@end

NS_ASSUME_NONNULL_END
