//
//  COMyFolderViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyNewsTopViewController.h"

@interface COMyNewsTopViewController()

@end

@implementation COMyNewsTopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:backGroundColor];
    
    [self setNavigationBar];
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
    
    [self setTitle:@"我的头条"];
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
