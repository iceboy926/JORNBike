//
//  COMyZoneViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/11.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyZoneViewController.h"
#import "COMyZoneView.h"

@interface COMyZoneViewController()

@property (nonatomic, strong)COMyZoneView *myzoneView;

@end

@implementation COMyZoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:backGroundColor];
    
    [self setNavigationBar];
    
    [self.view addSubview:self.myzoneView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addUIConstraints];
}


#pragma mark navigationBar color

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
    
    [self setTitle:@"MyZone"];
}

#pragma mark btn-action

- (void)backBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ui layout

- (void)addUIConstraints
{
    [self.myzoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    
}



- (COMyZoneView *)myzoneView
{
    if(_myzoneView == nil)
    {
        _myzoneView = [[COMyZoneView alloc] init];
    }
    
    return _myzoneView;
}



@end
