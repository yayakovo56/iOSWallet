//
//  CCWRegisterViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWLoginViewController.h"
#import "CCWCheckVisionAlert.h"

@interface CCWLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
// 登录控件
@property (weak, nonatomic) IBOutlet UITextField *loginAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPwdTextField;

@end

@implementation CCWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.backgroundColor = CCWButtonBgColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:CCWLocalizable(@"注册") style:UIBarButtonItemStylePlain target:self action:@selector(registerClick)];
    
    [self CCW_RequestAPPVersionInfo];
}

// 获取版本信息
- (void)CCW_RequestAPPVersionInfo
{
    [CCWSDKRequest CCW_QueryVersionInfoSuccess:^(id  _Nonnull responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSString *version = dataDic[@"version"];
        NSString *current = AppVersionNumber;
        //        TWLog(@"线上版本：%@----本地版本：%@",version,current);
        // 判断 version > current ？
        int result = [version compare:current options:NSCaseInsensitiveSearch | NSNumericSearch];
        if (result == 1){ // 有更新
            CCWIsHaveUpdate = YES;
            CCWIsForceUpdate = [dataDic[@"is_force"] boolValue];
            CCWAppNewVersion = version;
            CCWNewAppDownloadurl = dataDic[@"download_url"];
            CCWNewAppUpdateNotes = dataDic[@"info"];
            // 更新
            [[CCWCheckVisionAlert new] alertWithRootViewController];
        }
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        NSLog(@"----errorAlert----%@",errorAlert);
    }];
}

// 注册
- (void)registerClick
{
    [self.navigationController pushViewController:[NSClassFromString(@"CCWRegisterViewController") new] animated:YES];
}

// 登录
- (IBAction)loginButtonClick:(UIButton *)sender {
    
    NSString *accountStr = self.loginAccountTextField.text;
    NSString *pwdStr = self.loginPwdTextField.text;
    if (IsStrEmpty(accountStr) || IsStrEmpty(pwdStr)) {
        [self.view makeToast:CCWLocalizable(@"请输入账户信息")];
        return;
    }
    
    [MBProgressHUD showLoadingMessage:nil];
    CCWWeakSelf
    [CCWSDKRequest CCW_PasswordLogin:accountStr password:pwdStr Success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideHUD];
        CCWSETAccountName(responseObject[@"account"]);
        CCWSETAccountId(responseObject[@"id"]);
        
        CCWKeyWindow.rootViewController = [NSClassFromString(@"CCWTabViewController") new];
    } Error:^(NSString * _Nonnull errorAlert, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        if (error.code == 108 || error.code == 105) {
            [weakSelf.view makeToast:CCWLocalizable(@"请输入正确的账户名称或者密码")];
        }else{
            [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        }
    }];
}

- (IBAction)importButtonClick:(UIButton *)sender {
    
    [self.navigationController pushViewController:[NSClassFromString(@"CCWImportViewController") new] animated:YES];
}
    
@end
