//
//  CCWSearchDAppViewController.m
//  CocosBCXWallet
//
//  Created by SYLing on 2018/8/16.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWSearchDAppViewController.h"

@interface CCWSearchDAppViewController ()

//@property (nonatomic, weak) UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation CCWSearchDAppViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = CCWLocalizable(@"搜索Dapp");
    
}

- (void)dissmissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textFieldAction
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    [self pushFindLoadWebViewWithURLString:textField.text title:@"DApp"];
    return YES;
}

/** 跳转搜索加载WebView */
- (void)pushFindLoadWebViewWithURLString:(NSString *)urlString title:(NSString *)title {
    if ([urlString isEqualToString:@""]) {
        return;
    }
}

@end
