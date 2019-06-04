//
//  CCWReceiveViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/15.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWReceiveViewController.h"
#import <SGQRCode/SGQRCodeGenerateManager.h>

@interface CCWReceiveViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *coinTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UITextField *receiveNumTextField;

@property (weak, nonatomic) IBOutlet UILabel *receiveCoinLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *makeAddressButton;


@end

@implementation CCWReceiveViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = CCWLocalizable(@"收款");
    [self ccw_setNavBackgroundColor:[UIColor getColor:@"6368D0"]];
    [self ccw_setNavBarTintColor:[UIColor whiteColor]];
    [self ccw_setNavBarTitleColor:[UIColor whiteColor]];
    [self ccw_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.coinTitleLabel.text = self.assetsModel.symbol;
    self.receiveCoinLabel.text = self.assetsModel.symbol;
    self.accountAddressLabel.text = CCWAccountName;
    
    self.view.backgroundColor = [UIColor gradientColorFromColors:@[[UIColor getColor:@"6368D0"],[UIColor getColor:@"516ADB"]] gradientType:CCWGradientTypeTopToBottom colorSize:CGSizeMake(CCWScreenW, CCWScreenH)];
    
    NSMutableDictionary *qrDic = [NSMutableDictionary dictionary];
    qrDic[@"address"] = CCWAccountName;
    qrDic[@"symbol"] = self.assetsModel.symbol;
    qrDic[@"amount"] = @"0";
    self.qrCodeImageView.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:[qrDic mj_JSONString] logoImageName:@"cocosIcon" logoScaleToSuperView:0.3];
    
    [self.receiveNumTextField addTarget:self action:@selector(textEditingChange:) forControlEvents:UIControlEventEditingChanged];
}


#pragma mark - target
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@".0123456789\n"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [string isEqualToString:filtered];
    if (canChange) {
        //如果最先输入.，则在前面添加0
        if(textField.text.length == 0 && [string isEqualToString:@"."]){
            textField.text = @"0.";
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
            NSInteger iFive =  textField.text.length - rangeTemp.location - rangeTemp.length - 4;
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

- (void)textEditingChange:(UITextField *)textField
{
    NSMutableDictionary *qrDic = [NSMutableDictionary dictionary];
    qrDic[@"address"] = CCWAccountName;
    qrDic[@"symbol"] = self.assetsModel.symbol;
    qrDic[@"amount"] = textField.text;
    self.qrCodeImageView.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:[qrDic mj_JSONString] logoImageName:@"cocosIcon" logoScaleToSuperView:0.3];
}

- (IBAction)makeAccountClick:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:CCWAccountName];
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}

@end
