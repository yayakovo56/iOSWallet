//
//  CCWTransRecordModel.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/20.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// -----------------------------------------------------------------------------
typedef NS_ENUM(NSInteger, CCWOpType) {
    CCWOpTypeTransition = 0,          // 转账
    CCWOpTypeCallContract = 44,        // 合约
};

@interface CCWContractInfo : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *creation_date;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *current_version;
@property (nonatomic, copy) NSString *contract_authority;
@property (nonatomic, copy) NSString *check_contract_authority;
@property (nonatomic, strong) NSArray *contract_data;
@property (nonatomic, strong) NSArray *contract_ABI;
@property (nonatomic, copy) NSString *lua_code_b_id;

@end

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

// 转账的操作
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, strong) CCWMemo *memo;
@property (nonatomic, strong) CCWAmountFee *fee;
@property (nonatomic, strong) CCWAmountFee *amount;

// 合约交易
@property (nonatomic, copy) NSString *caller;
@property (nonatomic, copy) NSString *contract_id;
@property (nonatomic, copy) NSString *function_name;
@property (nonatomic, strong) NSArray *value_list;
@end

@interface CCWTransRecordModel : NSObject

@property (nonatomic, strong) NSNumber *block_num;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSArray *op;

/// 辅助 ///转账
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;

/// 辅助 ///合约交易
@property (nonatomic, copy) NSString *caller;

// 合约信息
@property (nonatomic, strong) CCWContractInfo *contractInfo;

// 交易方式
@property (nonatomic, assign) CCWOpType oprationType;
@property (nonatomic, strong) CCWOperation *operation;
@property (nonatomic, copy) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
