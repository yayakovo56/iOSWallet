//
//  CCWCreateViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/15.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWCreateViewController.h"

@interface CCWCreateViewController ()

@end

@implementation CCWCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = CCWLocalizable(@"创建账号");
    
}
- (IBAction)CCW_ImportClick:(UITapGestureRecognizer *)sender {
    
    [self.navigationController pushViewController:[NSClassFromString(@"CCWImportViewController") new] animated:YES];
}

- (IBAction)CCW_CreateClick:(UITapGestureRecognizer *)sender {
    
    [self.navigationController pushViewController:[NSClassFromString(@"CCWRegisterViewController") new] animated:YES];
}


@end
