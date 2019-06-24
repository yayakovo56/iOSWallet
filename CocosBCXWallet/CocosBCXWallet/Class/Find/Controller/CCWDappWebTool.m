//
//  CCWDappWebTool.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/5/13.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWDappWebTool.h"
#import "CCWAssetsModel.h"

@implementation CCWDappWebTool

+ (void)JSHandle_ReceiveMessageName:(NSString *)name messageBody:(NSDictionary *)body response:(CallbackBlock)block
{
    if ([name isEqualToString:JS_PUSHMESSAGE]) {
        if ([body[@"methodName"] isEqualToString:JS_METHOD_getCocosAccount]) {
            [self js_getCocosAccount:body response:block];
        }else if ([body[@"methodName"] isEqualToString:JS_METHOD_getAccountBalances]){
            [self JS_getAccountBalances:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_transfer]) {
            [self JS_transfer:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_callContract]) {
            [self JS_callContract:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_queryContra]) {
//            [self JS_queryContra:body response:block];
            // 暂无
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_queryContraD]) {
            // 暂无
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_queryAccoInfo]) {
            [self JS_queryAccoInfo:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_queryNHAsset]) {
            [self JS_QueryNHAssets:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_queryAccoNHOrders]) {
            [self JS_QueryAccountNHAssetOrders:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_queryNHOrders]) {
            [self JS_QuerytNHAssetOrders:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_queryAccoNH]) {
            [self JS_QueryAccountNHAssets:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_decodeMemo]) {
            [self JS_DecodeMemo:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_transferNH]) {
            [self JS_TransferNHAsset:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_transferNH]) {
            [self JS_TransferNHAsset:body response:block];
        }else if([body[@"methodName"] isEqualToString:JS_METHOD_fillNHAssetOrder]) {
            [self JS_fillNHAssetOrder:body response:block];
        }
    }
    
}

#pragma mark - Action
// 获取账号信息
+ (void)js_getCocosAccount:(NSDictionary *)param response:(CallbackBlock)block{
    NSDictionary *jsMessage = @{
                                @"account_id":CCWAccountId,
                                @"account_name":CCWAccountName
                                };
    !block?:block(param[@"serialNumber"],[jsMessage mj_JSONString]);
}

//获取账户余额
+ (void)JS_getAccountBalances:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *js_params = param[@"params"];
    NSString *account = js_params[@"account"];
    NSString *asset = js_params[@"assetId"];
    [CCWSDKRequest CCW_QueryAccountInfo:account Success:^(id  _Nonnull responseObject) {
        NSString *accountId = responseObject[@"id"];
        [CCWSDKRequest CCW_QueryAssetInfo:asset Success:^(CCWAssetsModel *assetsModel) {
            [CCWSDKRequest CCW_QueryAccountBalances:accountId assetId:assetsModel.asset_id?assetsModel.asset_id:assetsModel.ID Success:^(CCWAssetsModel *resassets) {
                !block?:block(param[@"serialNumber"],[@{@"data":@{resassets.symbol:resassets.amount},@"code":@1} mj_JSONString]);
            } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
                !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
            }];
        } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
            !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
        }];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
    }];
}

// 转账
+ (void)JS_transfer:(NSDictionary *)param response:(CallbackBlock)block
{   
    NSDictionary *transferParam = param[@"params"];
    NSString *from = transferParam[@"fromAccount"];
    NSString *to = transferParam[@"toAccount"];
    NSString *amount = transferParam[@"amount"];
    NSString *assetId = transferParam[@"assetId"];
    NSString *feeAssetId = transferParam[@"feeAssetId"];
    NSString *memo = transferParam[@"memo"];

    [self alertInputPwdBlock:^(NSString *password) {
        if ([transferParam[@"onlyGetFee"] boolValue]) {
            [CCWSDKRequest CCW_TransferFeeAsset:from toAccount:to password:password assetId:assetId feeAssetId:feeAssetId amount:amount memo:memo Success:^(CCWAssetsModel *assetsModel) {
                NSDictionary *jsMessage = @{
                                            @"fee_amount":assetsModel.amount,
                                            @"fee_symbol":assetsModel.symbol,
                                            };
                !block?:block(param[@"serialNumber"],[@{@"data":jsMessage,@"code":@1} mj_JSONString]);
            } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
                !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
            }];
        }else{
            [CCWSDKRequest CCW_TransferAsset:from toAccount:to password:password assetId:assetId feeAssetId:feeAssetId amount:amount memo:memo Success:^(id  _Nonnull responseObject) {
                NSDictionary *jsMessage = @{
                                            @"trx_id":responseObject,
                                            };
                !block?:block(param[@"serialNumber"],[@{@"data":@[],@"code":@1,@"trx_data":jsMessage} mj_JSONString]);
            } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
                !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
            }];
        }
    } serialNumber:param[@"serialNumber"] cancel:block];
}

// 调用合约
+ (void)JS_callContract:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *callContractParam = param[@"params"];
    NSString *nameOrId = callContractParam[@"nameOrId"];
    NSString *functionName = callContractParam[@"functionName"];
    NSArray *valueList = callContractParam[@"valueList"];
    
    [self alertInputPwdBlock:^(NSString *password) {
        if ([callContractParam[@"onlyGetFee"] boolValue]) {
            [CCWSDKRequest CCW_CallContractFee:nameOrId ContractMethodParam:valueList ContractMethod:functionName CallerAccount:CCWAccountId feePayingAsset:@"1.3.0" Password:password CallContractSuccess:^(CCWAssetsModel *assetsModel) {
                NSDictionary *jsMessage = @{
                                            @"fee_amount":assetsModel.amount,
                                            @"fee_symbol":assetsModel.symbol,
                                            };
                !block?:block(param[@"serialNumber"],[@{@"data":jsMessage,@"code":@1} mj_JSONString]);
            } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
                !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
            }];
        }else{
            [CCWSDKRequest CCW_CallContract:nameOrId ContractMethodParam:valueList ContractMethod:functionName CallerAccount:CCWAccountId feePayingAsset:@"1.3.0" Password:password CallContractSuccess:^(id  _Nonnull responseObject) {
                NSString *jsString = [responseObject mj_JSONString];
                jsString = [jsString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
                !block?:block(param[@"serialNumber"],jsString);
            } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
                !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
            }];
        }
    } serialNumber:param[@"serialNumber"] cancel:block];
}

// 查询合约
+ (void)JS_queryContra:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *contractParam = param[@"params"];
    [CCWSDKRequest CCW_queryContra:contractParam[@"nameOrId"] Success:^(id  _Nonnull responseObject) {
        !block?:block(param[@"serialNumber"],[@{@"data":responseObject,@"code":@1} mj_JSONString]);
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
    }];
}

// 查询用户信息
+ (void)JS_queryAccoInfo:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *accountParam = param[@"params"];
    [CCWSDKRequest CCW_queryFullAccountInfo:accountParam[@"account"] Success:^(id  _Nonnull responseObject) {
        NSDictionary *data = [[responseObject lastObject] lastObject];
        !block?:block(param[@"serialNumber"],[@{@"data":data,@"code":@1} mj_JSONString]);
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
    }];
}

// 查询NH资产
+ (void)JS_QueryNHAssets:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *accountParam = param[@"params"];
    [CCWSDKRequest CCW_queryNHAssets:accountParam[@"NHAssetIds"] Success:^(id  _Nonnull responseObject) {
        NSString *jsString = [@{@"data":responseObject,@"code":@1} mj_JSONString];
        jsString = [jsString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
        !block?:block(param[@"serialNumber"],jsString);
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
    }];
}

// 查询账户下所拥有的NH资产售卖订单
+ (void)JS_QueryAccountNHAssetOrders:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *nhorderParam = param[@"params"];
    NSString *accountNameOrId = nhorderParam[@"account"];
    NSInteger pageSize = [nhorderParam[@"pageSize"] integerValue];
    NSInteger page = [nhorderParam[@"page"] integerValue];
    
    [CCWSDKRequest CCW_QueryAccountInfo:accountNameOrId Success:^(id  _Nonnull responseObject) {
        NSString *accountId = responseObject[@"id"];
        [CCWSDKRequest CCW_ListAccountNHAssetOrder:accountId PageSize:pageSize Page:page Success:^(id  _Nonnull responseObject) {
            NSString *jsString = [@{@"data":[responseObject firstObject],@"total":[responseObject  lastObject],@"code":@1} mj_JSONString];
            jsString = [jsString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
            !block?:block(param[@"serialNumber"],jsString);
        } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
            !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
        }];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
    }];
}

// 查询全网NH资产售卖单
+ (void)JS_QuerytNHAssetOrders:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *nhParam = param[@"params"];
    NSString *assetIds = nhParam[@"assetIds"];
    NSString *worldViews = nhParam[@"worldViews"];
    NSString *baseDescribe = nhParam[@"baseDescribe"];
    NSInteger pageSize = [nhParam[@"pageSize"] integerValue];
    NSInteger page = [nhParam[@"page"] integerValue];
    [CCWSDKRequest CCW_QueryAllNHAssetOrder:assetIds WorldView:worldViews BaseDescribe:baseDescribe PageSize:pageSize Page:page Success:^(id  _Nonnull responseObject) {
        NSString *jsString = [@{@"data":[responseObject firstObject],@"total":[responseObject  lastObject],@"code":@1} mj_JSONString];
        jsString = [jsString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
        !block?:block(param[@"serialNumber"],jsString);
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
    }];
}

// 查询账户下所拥有的道具NH资产
+ (void)JS_QueryAccountNHAssets:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *nhParam = param[@"params"];
    NSString *accountNameOrId = nhParam[@"account"];
    NSArray *wordViewNameOrId = nhParam[@"worldViews"];
    NSInteger pageSize = [nhParam[@"pageSize"] integerValue];
    NSInteger page = [nhParam[@"page"] integerValue];
    [CCWSDKRequest CCW_QueryAccountInfo:accountNameOrId Success:^(id  _Nonnull responseObject) {
        NSString *accountId = responseObject[@"id"];
        [CCWSDKRequest CCW_QueryAccountNHAsset:accountId WorldView:wordViewNameOrId PageSize:pageSize Page:page Success:^(id  _Nonnull responseObject) {
            NSString *jsString = [@{@"data":[responseObject firstObject],@"total":[responseObject  lastObject],@"code":@1} mj_JSONString];
            jsString = [jsString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
            !block?:block(param[@"serialNumber"],jsString);
        } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
            !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
        }];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
    }];
}
// 解密备注
+ (void)JS_DecodeMemo:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *memoParam = param[@"params"];
    NSDictionary *memoDic = memoParam;
    [self alertInputPwdBlock:^(NSString *password) {
        [CCWSDKRequest CCW_DecodeMemo:memoDic Password:password Success:^(id  _Nonnull responseObject) {
            !block?:block(param[@"serialNumber"],[@{@"data":@{@"text":responseObject},@"code":@1} mj_JSONString]);
        } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
            !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
        }];
    } serialNumber:param[@"serialNumber"] cancel:block];
}
// 转移资产
+ (void)JS_TransferNHAsset:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *trnhParam = param[@"params"];
    NSString *toAccount = trnhParam[@"toAccount"];
    NSArray *NHAssetIds = trnhParam[@"NHAssetIds"];
    [self alertInputPwdBlock:^(NSString *password) {
        [CCWSDKRequest CCW_TransferNHAsset:CCWAccountId ToAccount:toAccount NHAssetID:[NHAssetIds firstObject] Password:password FeePayingAsset:@"1.3.0" Success:^(id  _Nonnull responseObject) {
            NSDictionary *jsMessage = @{
                                        @"trx_id":responseObject,
                                        };
            !block?:block(param[@"serialNumber"],[@{@"data":@[],@"code":@1,@"trx_data":jsMessage} mj_JSONString]);
        } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
            !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
        }];
    } serialNumber:param[@"serialNumber"] cancel:block];
}

//  购买NH资产
+ (void)JS_fillNHAssetOrder:(NSDictionary *)param response:(CallbackBlock)block
{
    NSDictionary *nhassetParam = param[@"params"];
    NSString *orderId = nhassetParam[@"orderId"];
    
    [self alertInputPwdBlock:^(NSString *password) {
        if ([nhassetParam[@"onlyGetFee"] boolValue]) {
            [CCWSDKRequest CCW_BuyNHAssetFeeID:orderId Account:CCWAccountId FeePayingAsset:@"1.3.0" Success:^(CCWAssetsModel *assetsModel) {
                NSDictionary *jsMessage = @{
                                            @"fee_amount":assetsModel.amount,
                                            @"fee_symbol":assetsModel.symbol,
                                            };
                !block?:block(param[@"serialNumber"],[@{@"data":jsMessage,@"code":@1} mj_JSONString]);
            } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
                !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
            }];
        }else{
            [CCWSDKRequest CCW_BuyNHAssetOrderID:orderId Account:CCWAccountId Password:password FeePayingAsset:@"1.3.0" Success:^(id  _Nonnull responseObject) {
                NSDictionary *jsMessage = @{
                                            @"trx_id":responseObject,
                                            };
                !block?:block(param[@"serialNumber"],[@{@"data":@[],@"code":@1,@"trx_data":jsMessage} mj_JSONString]);
            } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
               !block?:block(param[@"serialNumber"],@"ERROR:ERROR");
            }];
        }
    } serialNumber:param[@"serialNumber"] cancel:block];

}
// 输入密码
+ (void)alertInputPwdBlock:(void(^)(NSString * password))sureClick serialNumber:(NSString *)serialNumber cancel:(CallbackBlock)cancel{
    // 输入密码
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:CCWLocalizable(@"提示") message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 添加输入框 (注意:在UIAlertControllerStyleActionSheet样式下是不能添加下面这行代码的)
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = YES;
        textField.placeholder = CCWLocalizable(@"请输入密码");
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:CCWLocalizable(@"确认") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 通过数组拿到textTF的值
        NSString *password = [[alertVc textFields] objectAtIndex:0].text;
        !sureClick?:sureClick(password);
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:CCWLocalizable(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *message = @{
                                  @"type":@"signature_rejected",
                                  @"message":@"User rejected the signature request",
                                  @"code":@"402",
                                  @"isError":@1
                                  };
        !cancel?:cancel(serialNumber,[message mj_JSONString]);
    }];
    // 添加行为
    [alertVc addAction:action2];
    [alertVc addAction:action1];
    [[UIViewController topViewController] presentViewController:alertVc animated:YES completion:nil];
}
@end
