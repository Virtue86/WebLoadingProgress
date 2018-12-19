//
//  LVWebViewController.m
//  LVWebLoadingProgress
//
//  Created by Virtue on 2018/12/18.
//  Copyright © 2018年 none. All rights reserved.
//

#import "LVWebViewController.h"
#import "EPWebProgressLayer.h"
#import "SDAutoLayout.h"

#define kProgressHeight 2

@interface LVWebViewController ()<UIWebViewDelegate> {
     EPWebProgressLayer *_progressLayer; ///< 网页加载进度条
}
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSURL *url;
@end

@implementation LVWebViewController

- (instancetype)initWithUrl:(NSString *)urlString {
    if (self = [super init]) {
        self.url = [NSURL URLWithString:urlString];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.webView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.url];
    
    [self.webView loadRequest:request];
    [self setLoadProgress];
}

- (void)dealloc {
    
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
}

//顶部的加载的线条
- (void)setLoadProgress {
    _progressLayer = [EPWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, 42, self.view.frame.size.width, kProgressHeight);
    
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_progressLayer startLoad];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressLayer finishedLoad];
    
    if (self.title == nil) {
        
        self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

@end
