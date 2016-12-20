//
//  COMyFunnyViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/16.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyFunnyView.h"
#import "COMyJokeViewModel.h"

@interface COMyFunnyView() <UITableViewDataSource, UITableViewDelegate>
{
    FCXRefreshHeaderView *headerRefreshView;
}

@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)COMyJokeViewModel *myFunnyViewModel;

@end

@implementation COMyFunnyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.myTableView];
        
        [self addHeadRefreshView];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WEAK_SELF(weakself)
            
            [weakself fetchFunnyData];
        });

    }
    
    return self;
}


#pragma mark lazy load

- (UITableView *)myTableView
{
    if(_myTableView == nil)
    {
        _myTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor grayColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    
    return _myTableView;
}

- (COMyJokeViewModel *)myFunnyViewModel
{
    if(_myFunnyViewModel == nil)
    {
        _myFunnyViewModel = [[COMyJokeViewModel alloc] initWithJokeType:@"funny"];
    }
    
    return _myFunnyViewModel;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myFunnyViewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.myFunnyViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.myFunnyViewModel heightForRowAtIndexPath:indexPath];
}


#pragma mark 


- (void)addHeadRefreshView
{
    WEAK_SELF(weakself)
    
    headerRefreshView = [self.myTableView addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        
        //refresh action
        
        [weakself fetchFunnyData];
        
    }];
    
    [headerRefreshView setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
}


- (void)fetchFunnyData
{
    WEAK_SELF(weakself)
    [self.myFunnyViewModel requestDataModelWithCompletion:^(BOOL blfinished) {
    
        __weak FCXRefreshHeaderView *weakHeaderView = headerRefreshView;
        [weakHeaderView endRefresh];
        
        if(blfinished)
        {
            [weakself.myTableView reloadData];
        }
    }];
}

@end
