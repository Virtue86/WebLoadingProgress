//
//  LVWKWebViewController.m
//  LVWebLoadingProgress
//
//  Created by Virtue on 2018/12/18.
//  Copyright © 2018年 none. All rights reserved.
//

#import "LVWKWebViewController.h"
#import <WebKit/WebKit.h>
#import "SDAutoLayout.h"

@interface LVWKWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation LVWKWebViewController

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
    
    [self initProgressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)initProgressView
{

    UIProgressView *progressView = [[UIProgressView alloc] init];
    [self.view addSubview:progressView];
    
    //由于这里iphoneX导航栏高度g和它之前手机高度不一致，请核对手机型号测试 64，这里是iphoneX
    progressView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 88)
    .widthRatioToView(self.view, 1)
    .heightIs(2);
    
    progressView.tintColor = [UIColor redColor];
    progressView.trackTintColor = [UIColor lightGrayColor];
    self.progressView = progressView;
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
#pragma mark - KVO
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - WKNavigationDelegate


#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.UIDelegate = self;
    }
    return _webView;
}
@end
