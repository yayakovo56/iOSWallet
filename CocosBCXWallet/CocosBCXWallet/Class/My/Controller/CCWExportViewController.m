//
//  CCWExportViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/21.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWExportViewController.h"

@interface CCWExportViewController ()
@property (weak, nonatomic) IBOutlet UIButton *makeAssetsBtn;
@property (weak, nonatomic) IBOutlet UIButton *makeAccountBtn;
@property (weak, nonatomic) IBOutlet UILabel *assetsPrivateKey;
@property (weak, nonatomic) IBOutlet UILabel *accountPrivateKey;

@end

@implementation CCWExportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"导出私钥");
    self.makeAssetsBtn.backgroundColor = CCWButtonBgColor;
    self.makeAccountBtn.backgroundColor = CCWButtonBgColor;
    
    self.assetsPrivateKey.text = _keys[@"active_key"];
    self.accountPrivateKey.text = _keys[@"owner_key"];
}

- (IBAction)makeActivePrivateKey:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.assetsPrivateKey.text];
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}

- (IBAction)makeOwnerPrivateKey:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.accountPrivateKey.text];
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}
@end
