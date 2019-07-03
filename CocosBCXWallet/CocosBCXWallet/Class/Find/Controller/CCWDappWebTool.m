//
//  CCWDappWebTool.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/5/13.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWDappWebTool.h"
#import "CCWAssetsModel.h"
#import "CCWPwdAlertView.h"

@implementation CCWDappWebTool


+ (void)JSHandle_ReceiveMessageBody:(NSDictionary *)body
                           password:(NSString *)password
                           response:(CallbackBlock)block
{
    if ([body[@"methodName"] isEqualToString:JS_METHOD_getCocosAccount]) {
        [self js_getCocosAccount:body response:block];
    }else if([body[@"methodName"] isEqualToString:JS_METHOD_transfer]) {
        [self JS_transfer:body addPassword:password response:block];
    }else if([body[@"methodName"] isEqualToString:JS_METHOD_callContract]) {
        [self JS_callContract:body addPassword:password response:block];
    }else if([body[@"methodName"] isEqualToString:JS_METHOD_decodeMemo]) {
        [self JS_DecodeMemo:body addPassword:password response:block];
    }else if([body[@"methodName"] isEqualToString:JS_METHOD_transferNH]) {
        [self JS_TransferNHAsset:body addPassword:password response:block];
    }else if([body[@"methodName"] isEqualToString:JS_METHOD_fillNHAssetOrder]) {
        [self JS_fillNHAssetOrder:body addPassword:password response:block];
    }
}

#pragma mark - Action
// 获取账号信息
+ (void)js_getCocosAccount:(NSDictionary *)param response:(CallbackBlock)block{
    NSDictionary *jsMessage = @{
                                @"account_id":CCWAccountId,
                                @"account_name":CCWAccountName
                                };
    !block?:block(jsMessage);
}


// 转账
+ (void)JS_transfer:(NSDictionary *)param addPassword:(NSString *)password response:(CallbackBlock)block
{   
    NSDictionary *transferParam = param[@"params"];
    NSString *from = transferParam[@"fromAccount"];
    NSString *to = transferParam[@"toAccount"];
    NSString *amount = transferParam[@"amount"];
    NSString *assetId = transferParam[@"assetId"];
    NSString *feeAssetId = transferParam[@"feeAssetId"];
    NSString *memo = transferParam[@"memo"];

    if ([transferParam[@"onlyGetFee"] boolValue]) {
        [CCWSDKRequest CCW_TransferFeeAsset:from toAccount:to password:password assetId:assetId feeAssetId:feeAssetId amount:amount memo:memo Success:^(CCWAssetsModel *assetsModel) {
            NSDictionary *jsMessage = @{
                                        @"fee_amount":assetsModel.amount,
                                        @"fee_symbol":assetsModel.symbol,
                                        };
            !block?:block(@{@"data":jsMessage,@"code":@1});
        } Error:^(NSString * _Nonnull errorAlert, NSError *error)  {
            !block?:block([self errorBlockWithError:errorAlert ResponseObject:error]);
        }];
    }else{
        [CCWSDKRequest CCW_TransferAsset:from toAccount:to password:password assetId:assetId feeAssetId:feeAssetId amount:amount memo:memo Success:^(id  _Nonnull responseObject) {
            NSDictionary *jsMessage = @{
                                        @"trx_id":responseObject,
                                        };
            !block?:block(@{@"data":@[],@"code":@1,@"trx_data":jsMessage} );
        } Error:^(NSString * _Nonnull errorAlert, NSError *error)  {
            !block?:block([self errorBlockWithError:errorAlert ResponseObject:error]);
        }];
    }
}

// 调用合约
+ (void)JS_callContract:(NSDictionary *)param addPassword:(NSString *)password response:(CallbackBlock)block
{
    NSDictionary *callContractParam = param[@"params"];
    NSString *nameOrId = callContractParam[@"nameOrId"];
    NSString *functionName = callContractParam[@"functionName"];
    NSArray *valueList = callContractParam[@"valueList"];
    
    if ([callContractParam[@"onlyGetFee"] boolValue]) {
        [CCWSDKRequest CCW_CallContractFee:nameOrId ContractMethodParam:valueList ContractMethod:functionName CallerAccount:CCWAccountId feePayingAsset:@"1.3.0" Password:password CallContractSuccess:^(CCWAssetsModel *assetsModel) {
            NSDictionary *jsMessage = @{
                                        @"fee_amount":assetsModel.amount,
                                        @"fee_symbol":assetsModel.symbol,
                                        };
            !block?:block(@{@"data":jsMessage,@"code":@1});
        } Error:^(NSString * _Nonnull errorAlert, NSError *error)  {
            !block?:block([self errorBlockWithError:errorAlert ResponseObject:error]);
        }];
    }else{
        [CCWSDKRequest CCW_CallContract:nameOrId ContractMethodParam:valueList ContractMethod:functionName CallerAccount:CCWAccountId feePayingAsset:@"1.3.0" Password:password CallContractSuccess:^(id  _Nonnull responseObject) {
            !block?:block(responseObject);
        } Error:^(NSString * _Nonnull errorAlert, NSError *error) {
            !block?:block([self errorBlockWithError:errorAlert ResponseObject:error]);
        }];
    }
}

// 解密备注
+ (void)JS_DecodeMemo:(NSDictionary *)param addPassword:(NSString *)password response:(CallbackBlock)block
{
    NSDictionary *memoParam = param[@"params"];
    NSDictionary *memoDic = memoParam;
    [CCWSDKRequest CCW_DecodeMemo:memoDic Password:password Success:^(id  _Nonnull responseObject) {
        !block?:block(@{@"data":@{@"text":responseObject},@"code":@1});
    } Error:^(NSString * _Nonnull errorAlert, NSError *error)  {
        !block?:block([self errorBlockWithError:errorAlert ResponseObject:error]);
    }];
}
// 转移资产
+ (void)JS_TransferNHAsset:(NSDictionary *)param addPassword:(NSString *)password response:(CallbackBlock)block
{
    NSDictionary *trnhParam = param[@"params"];
    NSString *toAccount = trnhParam[@"toAccount"];
    NSArray *NHAssetIds = trnhParam[@"NHAssetIds"];
    [CCWSDKRequest CCW_TransferNHAsset:CCWAccountId ToAccount:toAccount NHAssetID:[NHAssetIds firstObject] Password:password FeePayingAsset:@"1.3.0" Success:^(id  _Nonnull responseObject) {
        NSDictionary *jsMessage = @{
                                    @"trx_id":responseObject,
                                    };
        !block?:block(@{@"data":@[],@"code":@1,@"trx_data":jsMessage});
    } Error:^(NSString * _Nonnull errorAlert, NSError *error)  {
        !block?:block([self errorBlockWithError:errorAlert ResponseObject:error]);
    }];
}

//  购买NH资产
+ (void)JS_fillNHAssetOrder:(NSDictionary *)param addPassword:(NSString *)password response:(CallbackBlock)block
{
    NSDictionary *nhassetParam = param[@"params"];
    NSString *orderId = nhassetParam[@"orderId"];
    
    if ([nhassetParam[@"onlyGetFee"] boolValue]) {
        [CCWSDKRequest CCW_BuyNHAssetFeeID:orderId Account:CCWAccountId FeePayingAsset:@"1.3.0" Success:^(CCWAssetsModel *assetsModel) {
            NSDictionary *jsMessage = @{
                                        @"fee_amount":assetsModel.amount,
                                        @"fee_symbol":assetsModel.symbol,
                                        };
            !block?:block(@{@"data":jsMessage,@"code":@1});
        } Error:^(NSString * _Nonnull errorAlert, NSError *error)  {
            !block?:block([self errorBlockWithError:errorAlert ResponseObject:error]);
        }];
    }else{
        [CCWSDKRequest CCW_BuyNHAssetOrderID:orderId Account:CCWAccountId Password:password FeePayingAsset:@"1.3.0" Success:^(id  _Nonnull responseObject) {
            NSDictionary *jsMessage = @{
                                        @"trx_id":responseObject,
                                        };
            !block?:block(@{@"data":@[],@"code":@1,@"trx_data":jsMessage});
        } Error:^(NSString * _Nonnull errorAlert, NSError *error)  {
            !block?:block([self errorBlockWithError:errorAlert ResponseObject:error]);
        }];
    }
}

// 所有错误处理
+ (NSDictionary *)errorBlockWithError:(NSString *)error ResponseObject:(NSError *)errorObj
{
    return @{
             @"message":errorObj.domain.description,
             @"code":@(errorObj.code)
             };
}
@end
