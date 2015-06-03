//
//  OAuthViewController.m
//  LoversOnline
//
//  Created by 吴金林 on 15/6/3.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import "OAuthViewController.h"

@interface OAuthViewController ()

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建一个webview
    UIWebView *webView=[[UIWebView alloc]init];
    webView.frame=self.view.bounds;
    [self.view addSubview:webView];
    
    //2.用webView加载登陆页面（新浪提供）
    //请求地址：https://api.weibo.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI
    //请求参数
    NSURL *url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1455551500&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
