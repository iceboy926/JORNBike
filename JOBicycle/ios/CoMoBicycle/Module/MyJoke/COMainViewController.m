//
//  COMainViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/16.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMainViewController.h"
#import "COMyJokeViewController.h"
#import "COMyFunnyViewController.h"

@interface COMainViewController() <UIScrollViewDelegate>

@property (nonatomic, strong)UISegmentedControl *segmentView;
@property (nonatomic, strong)UIScrollView  *scrollView;
@property (nonatomic, strong)COMyJokeViewController *myJokeVC;
@property (nonatomic, strong)COMyFunnyViewController *myFunnyVC;

@end

@implementation COMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
    self.view.backgroundColor = backGroundColor;
    
    self.navigationItem.titleView = self.segmentView;
    
    [self setNavigationBar];
    
    [self.scrollView addSubview:self.myJokeVC];
    [self.scrollView addSubview:self.myFunnyVC];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ui layout

#pragma mark lazy load

- (UIScrollView *)scrollView
{
    if(_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
    
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.directionalLockEnabled = YES;
        
        _scrollView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
        _scrollView.contentSize = CGSizeMake(2 *self.view.bounds.size.width, self.view.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    
    return _scrollView;
}

- (UISegmentedControl *)segmentView
{
    if(_segmentView == nil)
    {
        _segmentView = [[UISegmentedControl alloc] initWithItems:@[@"笑话", @"趣图"]];
    
        _segmentView.selectedSegmentIndex = 0;
    
        [_segmentView addTarget:self action:@selector(segmentBtnClicked:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _segmentView;
}

- (void)segmentBtnClicked:(id)sender
{
    self.scrollView.contentOffset = CGPointMake(self.segmentView.selectedSegmentIndex * self.view.bounds.size.width, 0);
}

- (COMyJokeViewController *)myJokeVC
{
    if(_myJokeVC == nil)
    {
        _myJokeVC = [[COMyJokeViewController alloc] initWithFrame:self.view.bounds];
    }
    
    return _myJokeVC;
}

- (COMyFunnyViewController *)myFunnyVC
{
    if(_myFunnyVC == nil)
    {
        _myFunnyVC = [[COMyFunnyViewController alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    
    return _myFunnyVC;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    self.segmentView.selectedSegmentIndex = offset/self.view.bounds.size.width;
}

@end
