//
//  CCWVersionViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/5/20.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWVersionViewController.h"

@interface CCWVersionViewController ()

@end

@implementation CCWVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = CCWLocalizable(@"版本日志");
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *bundleStr = [[NSBundle mainBundle] pathForResource:@"VersionLog" ofType:@"html"];
    NSURL *TermsUrl = [NSURL fileURLWithPath:bundleStr];
    [webView loadRequest:[NSURLRequest requestWithURL:TermsUrl]];
    [self.view addSubview:webView];

}

@end
