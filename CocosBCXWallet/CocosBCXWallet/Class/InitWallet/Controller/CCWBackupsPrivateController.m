//
//  CCWBackupsPrivateController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/15.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWBackupsPrivateController.h"

@interface CCWBackupsPrivateController ()

@property (weak, nonatomic) IBOutlet UILabel *active_prikey_lab;
@property (weak, nonatomic) IBOutlet UILabel *owner_prikey_lab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBottomConstraint;

@end

@implementation CCWBackupsPrivateController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"备份私钥");
    
    if (iPhone5) {
        self.keyTopConstraint.constant = 12;
        self.keyBottomConstraint.constant = 22;
    }
    self.active_prikey_lab.attributedText = [self textset2AttrbuteString:self.account[@"active_pri_key"]];
    self.owner_prikey_lab.attributedText = [self textset2AttrbuteString:self.account[@"owner_pri_key"]];
    
    UITapGestureRecognizer *activetapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeActivePriKey)];
    [self.active_prikey_lab addGestureRecognizer:activetapGes];
    UITapGestureRecognizer *ownertapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeOwnerPriKey)];
    [self.owner_prikey_lab addGestureRecognizer:ownertapGes];
}

- (void)makeActivePriKey
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.account[@"active_pri_key"]];
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}

- (void)makeOwnerPriKey
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.account[@"owner_pri_key"]];
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}

- (NSMutableAttributedString *)textset2AttrbuteString:(NSString *)text{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    return attributedString;
}

- (IBAction)nextButtonClick:(UIButton *)nextButton
{
    // 归档
    CCWKeyWindow.rootViewController = [NSClassFromString(@"CCWTabViewController") new];
}

@end
