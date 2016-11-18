//
//  CODetailInfoViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/10.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CODetailInfoViewController.h"
#import "COBMHeaderView.h"

@interface CODetailInfoViewController()

@property (nonatomic, strong)COBMHeaderView *headView;
@property (nonatomic, strong)WKWebView  *webView;

@end

@implementation CODetailInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.webView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addUIConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

#pragma mark ui layout

- (void)addUIConstraints
{
    
    
}

#pragma mark lazy load

- (COBMHeaderView *)headView
{
    if(_headView == nil)
    {
        
    }
    
    return _headView;
}

- (WKWebView *)webView
{
    if(_webView == nil)
    {
        
    }
    return _webView;
}


@end
