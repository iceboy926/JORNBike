//
//  COMyCardViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/13.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyHistoryTodayViewController.h"
#import "COMyHistoryTodayTableViewModel.h"

@interface COMyHistoryTodayViewController () <UITableViewDelegate, UITableViewDataSource>
{
    FCXRefreshHeaderView *headerRefreshView;
}

@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)COMyHistoryTodayTableViewModel *myTableViewModel;

@end

@implementation COMyHistoryTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationBar];
    
    [self.view addSubview:self.myTableView];
    
    //[self addHeaderRefreshView];
    
    [self fetchHistoryToday];
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

#pragma mark lazy load

- (UITableView *)myTableView
{
    if(_myTableView == nil)
    {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    
    return _myTableView;
}

- (COMyHistoryTodayTableViewModel *)myTableViewModel
{
    if(_myTableViewModel == nil)
    {
        _myTableViewModel = [[COMyHistoryTodayTableViewModel alloc] init];
    }
    
    return _myTableViewModel;
}

- (void)addHeaderRefreshView
{
    WEAK_SELF(weakself)
    headerRefreshView = [self.myTableView addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
       
        [weakself fetchHistoryToday];
        
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myTableViewModel numbersOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.myTableViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.myTableViewModel heightForRowAtIndexPath:indexPath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idStr = [self.myTableViewModel didSelectRowAtIndexPath:indexPath];
    
    NSLog(@"didSelectRowAtIndexPath is %@", idStr);
    
}


#pragma mark function


- (void)fetchHistoryToday
{
    WEAK_SELF(weakself)
    [self.myTableViewModel requestHistoryDataModelWithCompletion:^(BOOL blfinished) {
    
        if(blfinished)
        {
            [weakself.myTableView reloadData];
        }
    
    }];
}


@end
