//
//  ViewController.m
//  LVWebLoadingProgress
//
//  Created by Virtue on 2018/12/18.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"
#import "LVWebViewController.h"
#import "LVWKWebViewController.h"
#import "SDAutoLayout.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *centerButton = [UIButton new];
    centerButton.backgroundColor = [UIColor redColor];
    [centerButton setTitle:@"点击跳转到Web" forState:UIControlStateNormal];
    centerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [centerButton addTarget:self action:@selector(didTapWebViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerButton];
    
    centerButton.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 150)
    .widthRatioToView(self.view, 0.5)
    .heightIs(120);

    UIButton *centerButton1 = [UIButton new];
    centerButton1.backgroundColor = [UIColor orangeColor];
    [centerButton1 setTitle:@"点击跳转到WK" forState:UIControlStateNormal];
    centerButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [centerButton1 addTarget:self action:@selector(didTapWKWebViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerButton1];
    
    centerButton1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(centerButton, 150)
    .widthRatioToView(self.view, 0.5)
    .heightIs(120);
}

// UIWebView由于没有WKWebView那么可以精准，省资源，性能优越。然后在本demo主要用的加载进度，WKWebView也提供了一个准确的加载进度值属性。estimatedProgress
// 所以UIWebView只能使用一些巧用的方法进行进度的监听，然后进行展示，具体请看两个webView的控制器里的代码

- (void)didTapWebViewAction {
    LVWebViewController *webVC = [[LVWebViewController alloc] initWithUrl:@"http://www.baidu.com"];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didTapWKWebViewAction {
    LVWKWebViewController *WkWebVC = [[LVWKWebViewController alloc] initWithUrl:@"http://www.baidu.com"];
    [self.navigationController pushViewController:WkWebVC animated:YES];

}
@end
