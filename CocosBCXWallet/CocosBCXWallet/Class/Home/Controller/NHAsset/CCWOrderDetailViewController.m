//
//  CCWOrderDetailViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWOrderDetailViewController.h"
#import "CCWCancelSellNHInfoView.h"

@interface CCWOrderDetailViewController ()
{
    NSString *password_;
}
// 渐变层
@property (weak, nonatomic) IBOutlet UIView *gradientView;

// 订单id
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *assetIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerLabel;
@property (weak, nonatomic) IBOutlet UILabel *passAssetLabel;
@property (weak, nonatomic) IBOutlet UILabel *worldViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiratTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *baseDataLabel;

@property (weak, nonatomic) IBOutlet UIButton *optionButton;

/** 转账信息 */
@property (nonatomic, strong) CCWCancelSellNHInfoView *transferInfoView;
@end

@implementation CCWOrderDetailViewController

- (CCWCancelSellNHInfoView *)transferInfoView
{
    if (!_transferInfoView) {
        _transferInfoView = [CCWCancelSellNHInfoView new];
        _transferInfoView.delegate = self;
    }
    return _transferInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CCWLocalizable(@"详情");
    [self ccw_setNavBackgroundColor:[UIColor getColor:@"D2D9F3"]];
    self.gradientView.backgroundColor = [UIColor gradientColorFromColors:@[[UIColor getColor:@"D2D9F3"],[UIColor getColor:@"F6F7F8"]] gradientType:CCWGradientTypeTopToBottom colorSize:CGSizeMake(CCWScreenW, 280)];
    self.orderIDLabel.text = self.orderModel.ID;
    self.assetIDLabel.text = self.orderModel.nh_asset_id;
    self.worldViewLabel.text = self.orderModel.world_view;
    self.passAssetLabel.text = self.orderModel.asset_qualifier;
    self.noteLabel.text = self.orderModel.memo;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@",self.orderModel.priceModel.amount,self.orderModel.priceModel.symbol];
    self.expiratTimeLabel.text = self.orderModel.expiration;
    self.baseDataLabel.text = [NSString stringWithFormat:@"%@",[self.orderModel.base_describe dictionaryValue]];
    self.sellerLabel.text = self.orderModel.seller;
    CCWWeakSelf
    [CCWSDKRequest CCW_QueryAccountInfo:self.orderModel.seller Success:^(id  _Nonnull responseObject) {
        weakSelf.sellerLabel.text = responseObject[@"name"];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        
    }];
    if (self.orderType == CCWNHAssetOrderTypeMy) {
        [self.optionButton setTitle:CCWLocalizable(@"取消") forState:UIControlStateNormal];
    }else{
        [self.optionButton setTitle:CCWLocalizable(@"购买") forState:UIControlStateNormal];
    }
}

- (IBAction)oprationClick:(UIButton *)sender {
    if (self.orderType == CCWNHAssetOrderTypeMy) {
        [self cancelNHAssetClick];
    }else{
        NSLog(@"购买");
    }
}

#pragma mark - 取消订单
- (void)cancelNHAssetClick
{
    // 输入密码
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:CCWLocalizable(@"提示") message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 添加输入框 (注意:在UIAlertControllerStyleActionSheet样式下是不能添加下面这行代码的)
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = YES;
        textField.placeholder = CCWLocalizable(@"请输入密码");
    }];
    CCWWeakSelf
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:CCWLocalizable(@"确认") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 通过数组拿到textTF的值
        NSString *password = [[alertVc textFields] objectAtIndex:0].text;
        [weakSelf showCancelSellNHAssetFee:password];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:CCWLocalizable(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 添加行为
    [alertVc addAction:action2];
    [alertVc addAction:action1];
    [self presentViewController:alertVc animated:YES completion:nil];
}


- (void)showCancelSellNHAssetFee:(NSString *)password
{
    CCWWeakSelf;
    [CCWSDKRequest CCW_CancelSellNHAssetOrderId:self.orderModel.ID Password:password OnlyGetFee:YES Success:^(CCWAssetsModel *feesymbol) {
        self->password_ = password;
        NSArray *transferINfoArray = @[@{
                                           @"title":CCWLocalizable(@"订单信息"),
                                           @"info":CCWLocalizable(@"取消订单"),
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"订单ID"),
                                           @"info":weakSelf.orderModel.ID,
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"NH资产ID"),
                                           @"info":weakSelf.orderModel.nh_asset_id,
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"旷工费"),
                                           @"info":[NSString stringWithFormat:@"%@ %@",feesymbol.amount,feesymbol.symbol],
                                           }];
        [weakSelf CCW_TransferInfoViewShowWithArray:transferINfoArray];
        
    } Error:^(NSString * _Nonnull errorAlert, NSError *error) {
        if (error.code == 107){
            [weakSelf.view makeToast:CCWLocalizable(@"owner key不能进行转账，请导入active key")];
        }if (error.code == 105){
            [self.view makeToast:CCWLocalizable(@"密码错误，请重新输入")];
        }else{
            [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        }
    }];
}

- (void)CCW_TransferInfoViewShowWithArray:(NSArray *)array
{
    self.transferInfoView.dataSource = array;
    if (self.transferInfoView.isShow) {
        [self.transferInfoView CCW_Close];
    }else{
        [self.transferInfoView CCW_Show];
    }
}

- (void)CCW_TransferInfoViewNextButtonClick:(CCWCancelSellNHInfoView *)transferInfoView
{
    CCWWeakSelf
    [CCWSDKRequest CCW_CancelSellNHAssetOrderId:self.orderModel.ID Password:password_ OnlyGetFee:NO Success:^(id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"取消成功")];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        !weakSelf.deleteComplete?:weakSelf.deleteComplete();
    } Error:^(NSString * _Nonnull errorAlert, NSError *error) {
        if (error.code == 107){
            [weakSelf.view makeToast:CCWLocalizable(@"owner key不能进行转账，请导入active key")];
        }if (error.code == 105){
            [self.view makeToast:CCWLocalizable(@"密码错误，请重新输入")];
        }else{
            [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        }
    }];
}

@end
