//
//  CCWJoinUsViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/22.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWJoinUsViewController.h"

@interface CCWJoinUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *officeWeChatLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicWeChatLabel;
@property (weak, nonatomic) IBOutlet UILabel *developLabel;
@property (weak, nonatomic) IBOutlet UIImageView *joinUsBannerImage;

@end

@implementation CCWJoinUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = CCWLocalizable(@"加入社群");
    if ([[CCWLocalizableTool userLanguageString] isEqualToString:@"English"]) {
        self.joinUsBannerImage.image = [UIImage imageNamed:@"ourBanner_us"];
    }
    
}

- (IBAction)makeLabelCopy:(UIButton *)sender {
    NSString *makeStr = @"";
    switch (sender.tag) {
        case 0:
            makeStr = self.officeWeChatLabel.text;
            break;
        case 1:
            makeStr = self.publicWeChatLabel.text;
            break;
        case 2:
            makeStr = self.developLabel.text;
            break;
            
        default:
            break;
    }
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:makeStr];
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}

@end
