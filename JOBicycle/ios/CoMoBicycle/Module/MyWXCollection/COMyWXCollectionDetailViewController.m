//
//  COMyWXCollectionDetailViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyWXCollectionDetailViewController.h"

@interface COMyWXCollectionDetailViewController()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong)NSURL *requestURL;
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, strong)NSString *firstImage;

@end

@implementation COMyWXCollectionDetailViewController


- (instancetype)initWithURL:(NSURL *)requestURL firstImage:(NSString *)firstImage
{
    self = [super init];
    if(self)
    {
        self.requestURL = requestURL;
        self.firstImage = firstImage;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.webView];
    
    
    [self setNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.requestURL]];
    
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)setNavigationBar
{
    UIBarButtonItem *navigativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navigativeSeperator.width = -10;//此处修改到边界的距离，请自行测试
    
    UIBarButtonItem *iconItem = [[UIBarButtonItem alloc] initWithNormalIcon:@"goback" highlightedIcon:nil target:self action:@selector(backBtnClicked:)];
    
    if(ISIOS7)
    {
        self.navigationItem.leftBarButtonItems = @[navigativeSeperator, iconItem];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = iconItem;
    }
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithNormalIcon:@"cancel" highlightedIcon:nil target:self action:@selector(shareItemBtnClicked:)];
//    
//    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareItemBtnClicked:(id)sender
{
    //share sdk share
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[self.firstImage];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"内容"
                                         images:imageArray
                                            url:self.requestURL
                                          title:@"分享"
                                           type:SSDKContentTypeWebPage];
        
        [shareParams SSDKEnableUseClientShare];
        
        
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
           
            
            switch (state) {
                case SSDKResponseStateBegin: {
                    
                    break;
                }
                case SSDKResponseStateSuccess: {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail: {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    
                    break;
                }
                case SSDKResponseStateCancel: {
                    
                    break;
                }
            }
            
        }];
    }

}




#pragma mark lazy load
- (WKWebView *)webView
{
    if(_webView == nil)
    {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    
    return _webView;
}

- (UIProgressView *)progressView
{
    if(_progressView == nil)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:self.view.bounds];
    }
    
    return _progressView;
}


#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        NSLog(@"progress is %f", self.webView.estimatedProgress);
        self.progressView.progress = self.webView.estimatedProgress;
    }
}



#pragma mark- WKNavigationDelegate
// 在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"%s", __FUNCTION__);
    decisionHandler(WKNavigationActionPolicyAllow);
}

//在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%s", __FUNCTION__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
    
    if (webView.title.length > 0) {
        self.title = webView.title;
    }
    
}


@end
