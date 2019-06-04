//
//  CCWTipScreenShotViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/15.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWTipScreenShotViewController.h"
#import "CCWBackupsPrivateController.h"

@interface CCWTipScreenShotViewController ()

@end

@implementation CCWTipScreenShotViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"备份钱包");
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (IBAction)confirmButtonClick:(UIButton *)confirmButton
{
    CCWBackupsPrivateController *backVC = [[CCWBackupsPrivateController alloc] init];
    backVC.account = self.account;
    [self.navigationController pushViewController:backVC animated:YES];
}

@end
