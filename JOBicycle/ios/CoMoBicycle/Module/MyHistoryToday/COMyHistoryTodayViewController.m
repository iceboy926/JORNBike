//
//  COMyCardViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/13.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyHistoryTodayViewController.h"

@interface COMyHistoryTodayViewController ()

@end

@implementation COMyHistoryTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = backGroundColor;
    
    [self setNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
    
    [self setTitle:@"历史今日"];
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
