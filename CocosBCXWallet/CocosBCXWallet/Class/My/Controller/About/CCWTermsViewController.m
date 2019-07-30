//
//  CCWTermsViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/5/20.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWTermsViewController.h"

@interface CCWTermsViewController ()<UIWebViewDelegate>
/** <#视图#> */
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation CCWTermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = CCWLocalizable(@"服务条款");
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    NSString *bundleStr = [[NSBundle mainBundle] pathForResource:@"Terms of Service" ofType:@"html"];
    NSURL *TermsUrl = [NSURL fileURLWithPath:bundleStr];
    [webView loadRequest:[NSURLRequest requestWithURL:TermsUrl]];
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error.code==NSURLErrorCancelled) {
        return;
    }
}
//声明3个变量
NSURLConnection *_urlConnection;
NSURLRequest *_request;
BOOL _authenticated;

//UIWebView代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = [NSString stringWithFormat:@"%@",request.URL];
    //这里判断url地址是哪个
    if (!_authenticated && [urlString isEqualToString:@"https://www.cocosbcx.io/"]) {
        _authenticated =NO;
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        _request = request;//request赋值
        [_urlConnection start];
        return NO;
    }
    return YES;
}


//NSURLConnectionDelegate 方法
#pragma mark - NURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    [self.webView loadRequest:_request]; //  self.webView替换成自己的webview
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
@end
