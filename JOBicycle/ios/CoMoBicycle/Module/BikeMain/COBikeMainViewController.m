//
//  COBikeMainViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COBikeMainViewController.h"
#import "COBMCustomView.h"
#import "COBMViewModel.h"
#import "AppDelegate.h"

@interface COBikeMainViewController()

@property (nonatomic, strong) COBMCustomView   *customView;
@property (nonatomic, strong) COBMViewModel     *viewModel;

@end

@implementation COBikeMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.customView];
    [self setupNavigationView];
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
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.bottom.equalTo(self.view);
    
    }];
}

#pragma mark 

- (void)setupNavigationView
{
    [self setTitle:@"CoBicycle"];
    
    UIBarButtonItem *seperatorBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    seperatorBarItem.width = -10;
    
    
    UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    NSData *dataImage = [self.viewModel getLocalUserImage];
    
    UIImage *image = [UIImage imageWithData:dataImage];
    
    headBtn.layer.cornerRadius = 20;
    headBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    headBtn.layer.masksToBounds = YES;
    [headBtn setBackgroundImage:image forState:UIControlStateNormal];
    [headBtn addTarget:self action:@selector(headbtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:headBtn];

    
    if(ISIOS7)
    {
        self.navigationItem.leftBarButtonItems = @[seperatorBarItem, leftBarItem];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
    
}

#pragma mark lazy load

- (COBMCustomView *)customView
{
    if(_customView == nil)
    {
        
        WEAK_SELF(weakself)
        _customView = [[COBMCustomView alloc] init];
        
        _customView.startSearchBlock = ^{
        
            [weakself gotoSearchNavigationViewController];
        
        };
    }
    
    return _customView;
}

- (COBMViewModel *)viewModel
{
    if(_viewModel == nil)
    {
        _viewModel = [COBMViewModel sharedInstance];
    }
    
    return _viewModel;
}

#pragma mark headBtn-action

- (void)headbtnClicked:(id)sender
{
    [self.customView hideResultListView];
    
    [[AppDelegate globalDelegate] openDrawleft];
    
}


#pragma mark goto SearchVC

- (void)gotoSearchNavigationViewController
{
    NSArray *hotkeyArray = @[@"美食", @"酒店", @"银行", @"超市", @"商场", @"景点", @"医院", @"公交站", @"地铁站", @"卫生间"];
    
    WEAK_SELF(weakself)
    PYSearchViewController *searchVC = [PYSearchViewController searchViewControllerWithHotSearches:hotkeyArray searchBarPlaceholder:@"附近的商场、美食" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        
    [searchViewController.navigationController dismissViewControllerAnimated:YES completion:^{
        
        [weakself.customView startPoiSearchWithKeyword:searchText];
    }];
        
    }];
    
    searchVC.view.backgroundColor = backGroundColor;
    searchVC.hotSearchStyle = PYHotSearchStyleBorderTag;
    searchVC.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchVC];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}



@end
