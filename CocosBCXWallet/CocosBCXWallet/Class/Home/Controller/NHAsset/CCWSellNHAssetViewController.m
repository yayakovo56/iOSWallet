//
//  CCWSellNHAssetViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWSellNHAssetViewController.h"
#import "CCWSelectSellCoinViewController.h"
#import "CCWTransferInfoView.h"

@interface CCWSellNHAssetViewController ()<UITextFieldDelegate,UIScrollViewDelegate,CCWTransferInfoViewDelegate>
{
    NSString *password_;
}
@property (nonatomic, weak) IBOutlet UITextField *nhAssetIDTF;
@property (nonatomic, weak) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UIButton *coinButton;
@property (nonatomic, weak) IBOutlet UITextField *validTimeTF;
@property (nonatomic, weak) IBOutlet UITextField *noteTF;

@property (nonatomic, strong) CCWAssetsModel *priceModel;

/** 转账信息 */
@property (nonatomic, strong) CCWTransferInfoView *transferInfoView;
@end

@implementation CCWSellNHAssetViewController

- (CCWTransferInfoView *)transferInfoView
{
    if (!_transferInfoView) {
        _transferInfoView = [CCWTransferInfoView new];
        _transferInfoView.delegate = self;
    }
    return _transferInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"道具出售");
    self.nhAssetIDTF.text = self.nhAssetModel.ID;
    self.priceModel = [[CCWAssetsModel alloc] init];
    self.priceModel.symbol = @"COCOS";
    self.priceModel.ID = @"1.3.0";
    [self.coinButton setTitle:self.priceModel.symbol forState:UIControlStateNormal];
}

// 选择币种
- (IBAction)selectCoinClick:(UIButton *)sender {
    CCWSelectSellCoinViewController *selectCoinVC = [[CCWSelectSellCoinViewController alloc] init];
    selectCoinVC.selectAssetModel = self.priceModel;
    CCWWeakSelf;
    selectCoinVC.selectBlock = ^(CCWAssetsModel * _Nonnull selectAssetModel) {
        weakSelf.priceModel = selectAssetModel;
        [weakSelf.coinButton setTitle:weakSelf.priceModel.symbol forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:selectCoinVC animated:YES];
}

- (IBAction)sellNHAssetClick
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
        [weakSelf showSellNHAssetFee:password];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:CCWLocalizable(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 添加行为
    [alertVc addAction:action2];
    [alertVc addAction:action1];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)showSellNHAssetFee:(NSString *)password
{
    NSString *price = self.priceTF.text;
    NSString *validTime = self.validTimeTF.text;
    if (IsStrEmpty(price)) {
        [self.view makeToast:CCWLocalizable(@"请输入价格")];
        return;
    }
    if (IsStrEmpty(validTime)) {
        [self.view makeToast:CCWLocalizable(@"请输入有效时间")];
        return;
    }
    CCWWeakSelf;
    [CCWSDKRequest CCW_SellNHAssetNHAssetId:self.nhAssetModel.ID Password:password Memo:self.noteTF.text SellPriceAmount:price SellAsset:self.priceModel.ID Expiration:validTime OnlyGetFee:YES Success:^(CCWAssetsModel *feesymbol) {
        password_ = password;
        NSArray *transferINfoArray = @[@{
                                           @"title":CCWLocalizable(@"订单信息"),
                                           @"info":CCWLocalizable(@"出售资产"),
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"NH资产ID"),
                                           @"info":weakSelf.nhAssetModel.ID,
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"价格"),
                                           @"info":[NSString stringWithFormat:@"%@ %@",price,weakSelf.priceModel.symbol],
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"有效时间"),
                                           @"info":[NSString stringWithFormat:@"%@ s",validTime],
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"旷工费"),
                                           @"info":[NSString stringWithFormat:@"%@%@",feesymbol.amount,feesymbol.symbol],
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"备注"),
                                           @"info":self.noteTF.text,
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

- (void)CCW_TransferInfoViewNextButtonClick:(CCWTransferInfoView *)transferInfoView
{
    NSString *price = self.priceTF.text;
    NSString *validTime = self.validTimeTF.text;
    CCWWeakSelf
    [CCWSDKRequest CCW_SellNHAssetNHAssetId:self.nhAssetModel.ID Password:password_ Memo:self.noteTF.text SellPriceAmount:price SellAsset:self.priceModel.ID Expiration:validTime OnlyGetFee:NO Success:^(id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"出售成功")];
        [weakSelf.navigationController popViewControllerAnimated:YES];
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

#pragma mark - UITextField
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@".0123456789\n"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [string isEqualToString:filtered];
    if (canChange) {
        //如果最先输入.，则在前面添加0
        if(self.priceTF.text.length == 0 && [string isEqualToString:@"."]){
            self.priceTF.text = @"0.";
            return NO;
        }
        NSRange rangeTemp = [textField.text rangeOfString:@"."];
        if ([string isEqualToString:@"."]) {
            //不允许重复输入.
            if (rangeTemp.length > 0 ) {
                return NO;
            }
        }
        
        //小数点后保持后5位
        if (rangeTemp.length > 0) {
            NSInteger iFive =  self.priceTF.text.length - rangeTemp.location - rangeTemp.length - 4;
            if (iFive > 0 ) {
                if ([string isEqualToString:@""]) {
                    return YES;
                }else
                    return NO;
            }
        }
    }
    return canChange;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
