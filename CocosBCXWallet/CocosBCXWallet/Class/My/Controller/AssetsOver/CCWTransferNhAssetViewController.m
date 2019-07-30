//
//  CCWTransferNhAssetViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/26.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWTransferNhAssetViewController.h"
#import "CCWAssetsModel.h"
#import "CCWBuyNHInfoView.h"

@interface CCWTransferNhAssetViewController ()<CCWBuyNHInfoViewDelegate>
{
    NSString *password_;
}
@property (weak, nonatomic) IBOutlet UITextField *receiveTextField;
@property (weak, nonatomic) IBOutlet UITextField *nhAssetIDTextField;

/** 转账信息 */
@property (nonatomic, strong) CCWBuyNHInfoView *transferInfoView;

@end

@implementation CCWTransferNhAssetViewController

- (CCWBuyNHInfoView *)transferInfoView
{
    if (!_transferInfoView) {
        _transferInfoView = [CCWBuyNHInfoView new];
        _transferInfoView.delegate = self;
    }
    return _transferInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = CCWLocalizable(@"非同质资产转移");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scanQRCode"] style:UIBarButtonItemStylePlain target:self action:@selector(CCW_ScanQRCode)];
    self.nhAssetIDTextField.text = self.nhAssetModel.ID;
}

// 扫码二维码
- (void)CCW_ScanQRCode
{
    if ([CCWPrivacyPermissionsManager fxwIsOpenCamera]) {
        // 扫描二维码
        id<CCWMyModuleProtocol> myModule = [[CCWMediator sharedInstance] moduleForProtocol:@protocol(CCWMyModuleProtocol)];
        CCWWeakSelf
        UIViewController *scanQRCodeVC = [myModule CCW_ScanQRCodeToTransferWithBlock:^(NSDictionary *qrData) {
            weakSelf.receiveTextField.text = qrData[@"address"];
        }];
        [self.navigationController pushViewController:scanQRCodeVC animated:YES];
    }else{
        [self.view makeToast:CCWLocalizable(@"请允许访问相机")];
    }
}

// 通讯录点击
- (IBAction)addressListClick:(UIButton *)sender {
    id<CCWMyModuleProtocol> myModuleProtocol = [[CCWMediator sharedInstance] moduleForProtocol:@protocol(CCWMyModuleProtocol)];
    CCWWeakSelf;
    UIViewController *viewController = [myModuleProtocol CCW_MyContactViewControllerWithBlock:^(NSString *address) {
        weakSelf.receiveTextField.text = address;
    }];
    [self.navigationController pushViewController:viewController animated:YES];
}

// 点击转账
- (IBAction)nextTransferClick:(UIButton *)sender {
    NSString *receiveAddress = self.receiveTextField.text;
    if (IsStrEmpty(receiveAddress)) {
        [self.view makeToast:CCWLocalizable(@"请输入资产接收方")];
        return;
    }
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
        [weakSelf showTransferFee:password];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:CCWLocalizable(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 添加行为
    [alertVc addAction:action2];
    [alertVc addAction:action1];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

- (void)showTransferFee:(NSString *)password
{
    NSString *receiveAddress = self.receiveTextField.text;
    CCWWeakSelf;
    [CCWSDKRequest CCW_TransferNHAssetToAccount:receiveAddress NHAssetID:self.nhAssetModel.ID Password:password OnlyGetFee:YES Success:^(CCWAssetsModel *feesymbol) {
        password_ = password;
        NSArray *transferINfoArray = @[@{
                                           @"title":CCWLocalizable(@"订单信息"),
                                           @"info":CCWLocalizable(@"转移资产"),
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"转出账号"),
                                           @"info":CCWAccountName,
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"转入账号"),
                                           @"info":receiveAddress,
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"NH资产ID"),
                                           @"info":weakSelf.nhAssetModel.ID,
                                           },
                                       @{
                                           @"title":CCWLocalizable(@"旷工费"),
                                           @"info":[NSString stringWithFormat:@"%@%@",feesymbol.amount,feesymbol.symbol],
                                           }];
        [weakSelf CCW_TransferInfoViewShowWithArray:transferINfoArray];
    } Error:^(NSString * _Nonnull errorAlert, NSError *error) {
        if (error.code == 104) {
            [weakSelf.view makeToast:CCWLocalizable(@"资产接收方不存在")];
        }else if (error.code == 116) {
            [weakSelf.view makeToast:CCWLocalizable(@"资产接收方不存在")];
        }else if (error.code == 105){
            [self.view makeToast:CCWLocalizable(@"密码错误，请重新输入")];
        }else if (error.code == 107){
            [weakSelf.view makeToast:CCWLocalizable(@"owner key不能进行转账，请导入active key")];
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
- (void)CCW_BuyInfoViewNextButtonClick:(CCWBuyNHInfoView *)transferInfoView
{
    CCWWeakSelf
    [CCWSDKRequest CCW_TransferNHAssetToAccount:self.receiveTextField.text NHAssetID:self.nhAssetModel.ID Password:password_ OnlyGetFee:NO Success:^(id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"转移成功")];
        // 改变Nav的栈
        NSArray *array = @[weakSelf.navigationController.viewControllers[0],weakSelf.navigationController.viewControllers[1], weakSelf];
        weakSelf.navigationController.viewControllers = array;
        [weakSelf.navigationController popViewControllerAnimated:YES];
        !weakSelf.transferNHAssetComplete?:weakSelf.transferNHAssetComplete();
    } Error:^(NSString * _Nonnull errorAlert, NSError *error) {
        if (error.code == 104) {
            [weakSelf.view makeToast:CCWLocalizable(@"资产接收方不存在")];
        }else if (error.code == 116) {
            [weakSelf.view makeToast:CCWLocalizable(@"资产接收方不存在")];
        }else if (error.code == 107){
            [weakSelf.view makeToast:CCWLocalizable(@"owner key不能进行转账，请导入active key")];
        }else if (error.code == 105){
            [self.view makeToast:CCWLocalizable(@"密码错误，请重新输入")];
        }else{
            [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        }
    }];
}
@end
