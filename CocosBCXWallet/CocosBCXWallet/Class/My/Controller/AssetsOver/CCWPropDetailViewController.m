//
//  CCWPropDetailViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/22.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWPropDetailViewController.h"
#import "CCWDeleteNHInfoView.h"
#import "CCWAssetsModel.h"

@interface CCWPropDetailViewController ()<CCWDeleteNHInfoViewDelegate>
{
    NSString *password_;
}
// 渐变层
@property (weak, nonatomic) IBOutlet UIView *gradientView;

// 转账成功title
@property (weak, nonatomic) IBOutlet UILabel *transferTypeLabel;
// nhAssetid
@property (weak, nonatomic) IBOutlet UILabel *transferAccountLabel;

@property (weak, nonatomic) IBOutlet UILabel *creater;
@property (weak, nonatomic) IBOutlet UILabel *seller;
@property (weak, nonatomic) IBOutlet UILabel *passAssets;
@property (weak, nonatomic) IBOutlet UILabel *worldviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UITextView *baseDataLabel;

/** 转账信息 */
@property (nonatomic, strong) CCWDeleteNHInfoView *deleteInfoView;

@end

@implementation CCWPropDetailViewController

- (CCWDeleteNHInfoView *)deleteInfoView
{
    if (!_deleteInfoView) {
        _deleteInfoView = [CCWDeleteNHInfoView new];
        _deleteInfoView.delegate = self;
    }
    return _deleteInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"资产详情");
    [self ccw_setNavBackgroundColor:[UIColor getColor:@"D2D9F3"]];
    self.gradientView.backgroundColor = [UIColor gradientColorFromColors:@[[UIColor getColor:@"D2D9F3"],[UIColor getColor:@"F6F7F8"]] gradientType:CCWGradientTypeTopToBottom colorSize:CGSizeMake(CCWScreenW, 280)];
    
    self.transferAccountLabel.text = self.nhAssetModel.ID;
    self.passAssets.text = self.nhAssetModel.asset_qualifier;
    self.worldviewLabel.text = self.nhAssetModel.world_view;
    self.createTime.text = self.nhAssetModel.create_time;
    self.baseDataLabel.text = [NSString stringWithFormat:@"%@",[self.nhAssetModel.base_describe dictionaryValue]];
    self.seller.text = self.nhAssetModel.nh_asset_owner;
    self.creater.text = self.nhAssetModel.nh_asset_creator;
    CCWWeakSelf;
    [CCWSDKRequest CCW_QueryAccountInfo:self.nhAssetModel.nh_asset_owner Success:^(id  _Nonnull responseObject) {
        weakSelf.seller.text = responseObject[@"name"];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        
    }];
    [CCWSDKRequest CCW_QueryAccountInfo:self.nhAssetModel.nh_asset_creator Success:^(id  _Nonnull responseObject) {
        weakSelf.creater.text = responseObject[@"name"];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        
    }];
}

// 删除
- (IBAction)deleteAsset:(UIButton *)sender {
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
        [weakSelf showDeleteNHAssetFee:password];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:CCWLocalizable(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 添加行为
    [alertVc addAction:action2];
    [alertVc addAction:action1];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)showDeleteNHAssetFee:(NSString *)password
{
    CCWWeakSelf;
    [CCWSDKRequest CCW_DeleteNHAssetId:self.nhAssetModel.ID Password:password OnlyGetFee:YES Success:^(CCWAssetsModel *feesymbol) {
        self->password_ = password;
        NSArray *transferINfoArray = @[@{
                                           @"title":CCWLocalizable(@"订单信息"),
                                           @"info":CCWLocalizable(@"删除资产"),
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"NH资产ID"),
                                           @"info":weakSelf.nhAssetModel.ID,
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"世界观"),
                                           @"info":weakSelf.nhAssetModel.world_view,
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"旷工费"),
                                           @"info":[NSString stringWithFormat:@"%@%@",feesymbol.amount,feesymbol.symbol],
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
    self.deleteInfoView.dataSource = array;
    if (self.deleteInfoView.isShow) {
        [self.deleteInfoView CCW_Close];
    }else{
        [self.deleteInfoView CCW_Show];
    }
}

- (void)CCW_DeleteInfoViewNextButtonClick:(nonnull CCWDeleteNHInfoView *)transferInfoView {
    CCWWeakSelf;
    [CCWSDKRequest CCW_DeleteNHAssetId:self.nhAssetModel.ID Password:password_ OnlyGetFee:NO Success:^(id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"删除成功")];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        !weakSelf.deleteNHAssetComplete?:weakSelf.deleteNHAssetComplete();
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

- (IBAction)transferAsset:(UIButton *)sender {
    CCWTransferNhAssetViewController *transferNhAssetVC = [[CCWTransferNhAssetViewController alloc] init];
    transferNhAssetVC.nhAssetModel = self.nhAssetModel;
    CCWWeakSelf;
    transferNhAssetVC.transferNHAssetComplete = weakSelf.deleteNHAssetComplete;
    [self.navigationController pushViewController:transferNhAssetVC animated:YES];
}

- (IBAction)makeAccountCopy:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (sender.tag == 1) {
        [pasteboard setString:self.creater.text];
    }else{
        [pasteboard setString:self.seller.text];
    }
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}

@end
