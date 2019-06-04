//
//  CCWTransferDetailViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWTransferDetailViewController.h"
#import "CCWAssetsModel.h"

@interface CCWTransferDetailViewController ()
// 渐变层
@property (weak, nonatomic) IBOutlet UIView *gradientView;


@property (weak, nonatomic) IBOutlet UIImageView *transferTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *transferTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *outAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *inAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@property (weak, nonatomic) IBOutlet UILabel *transferFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferHashLabel;
@property (weak, nonatomic) IBOutlet UILabel *blockHeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferTimeLabel;

@end

@implementation CCWTransferDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"交易详情");
    [self ccw_setNavBackgroundColor:[UIColor getColor:@"D2D9F3"]];
    self.gradientView.backgroundColor = [UIColor gradientColorFromColors:@[[UIColor getColor:@"D2D9F3"],[UIColor getColor:@"F6F7F8"]] gradientType:CCWGradientTypeTopToBottom colorSize:CGSizeMake(CCWScreenW, 200)];
    if ([self.transRecordModel.from isEqualToString:CCWAccountName]) {
        self.transferAccountLabel.text = [NSString stringWithFormat:@"-%@ %@",self.transRecordModel.operation.amount.amount,self.transRecordModel.operation.amount.symbol];
    }else{
        self.transferAccountLabel.text = [NSString stringWithFormat:@"+%@ %@",self.transRecordModel.operation.amount.amount,self.transRecordModel.operation.amount.symbol];
    }
    self.outAccountLabel.text = self.transRecordModel.from;
    self.inAccountLabel.text = self.transRecordModel.to;
    self.blockHeightLabel.text = [NSString stringWithFormat:@"%@",self.transRecordModel.block_num];
    self.transferTimeLabel.text = self.transRecordModel.timestamp;
    self.transferHashLabel.text = self.transRecordModel.ID;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(decodeMemoTap:)];
    [self.remarkLabel addGestureRecognizer:tapGes];
    CCWWeakSelf;
    [CCWSDKRequest CCW_QueryAssetInfo:self.transRecordModel.operation.fee.asset_id Success:^(CCWAssetsModel *assetsModel) {
         NSNumber *amount = [[CCWDecimalTool CCW_decimalNumberWithString:[NSString stringWithFormat:@"%@",weakSelf.transRecordModel.operation.fee.amount]] decimalNumberByMultiplyingByPowerOf10:-[assetsModel.precision integerValue]];
        weakSelf.transferFeeLabel.text = [NSString stringWithFormat:@"%@ %@",amount,assetsModel.symbol];;
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
    }];
    if (self.transRecordModel.operation.memo) {
        self.remarkLabel.text = CCWLocalizable(@"使用密码解锁备注");
        weakSelf.remarkLabel.textColor = [UIColor getColor:@"4868DC"];
    }
}

- (void)decodeMemoTap:(UITapGestureRecognizer *)tapGesRecognizer
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:CCWLocalizable(@"提示") message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 添加输入框 (注意:在UIAlertControllerStyleActionSheet样式下是不能添加下面这行代码的)
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = CCWLocalizable(@"请输入密码");
    }];
    CCWWeakSelf
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:CCWLocalizable(@"确认") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 通过数组拿到textTF的值
        NSString *password = [[alertVc textFields] objectAtIndex:0].text;
        [CCWSDKRequest CCW_DecodeMemo:[self.transRecordModel.operation.memo mj_keyValues] Password:password Success:^(id  _Nonnull responseObject) {
            weakSelf.remarkLabel.userInteractionEnabled = NO;
            weakSelf.remarkLabel.text = responseObject;
            weakSelf.remarkLabel.textColor = [UIColor getColor:@"262A33"];
        } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
            [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        }];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:CCWLocalizable(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 添加行为
    [alertVc addAction:action2];
    [alertVc addAction:action1];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

- (IBAction)makeAddress:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (sender.tag == 1) {
        [pasteboard setString:self.inAccountLabel.text];
    }else{
        [pasteboard setString:self.outAccountLabel.text];
    }
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}

@end
