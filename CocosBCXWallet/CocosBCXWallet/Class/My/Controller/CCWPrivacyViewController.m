//
//  CCWPrivacyViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/5/20.
//  Copyright © 2019年 邵银岭. All rights reserved.

#import "CCWPrivacyViewController.h"

@interface CCWPrivacyViewController ()

@end

@implementation CCWPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = CCWLocalizable(@"隐私协议");
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *bundleStr = [[NSBundle mainBundle] pathForResource:@"PRIVACY POLICY" ofType:@"html"];
    NSURL *TermsUrl = [NSURL fileURLWithPath:bundleStr];
    [webView loadRequest:[NSURLRequest requestWithURL:TermsUrl]];
    [self.view addSubview:webView];
}

@end
