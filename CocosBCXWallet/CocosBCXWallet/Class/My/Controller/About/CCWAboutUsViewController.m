//
//  CCWAboutUsViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/21.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWAboutUsViewController.h"

@interface CCWAboutUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation CCWAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.versionLabel.text = [NSString stringWithFormat:@"%@ V %@",CCWLocalizable(@"当前版本"),AppVersionNumber];
}

- (IBAction)aboutUsdidSelectIndexPath:(UIButton *)button
{
    NSInteger tagInteger = button.tag;
    switch (tagInteger) {
        case 0: // 使用协议
            [self.navigationController pushViewController:[NSClassFromString(@"CCWTermsViewController") new] animated:YES];
            break;
        case 1: // 隐私协议
            [self.navigationController pushViewController:[NSClassFromString(@"CCWPrivacyViewController") new] animated:YES];
            break;
        case 2: // 版本日志
            [self.navigationController pushViewController:[NSClassFromString(@"CCWVersionViewController") new] animated:YES];
            break;
        case 3: // 加入社群
            [self.navigationController pushViewController:[NSClassFromString(@"CCWJoinUsViewController") new] animated:YES];
            break;
        default:
            break;
    }
}

@end
