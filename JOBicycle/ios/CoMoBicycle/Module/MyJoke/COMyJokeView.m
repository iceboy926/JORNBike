//
//  COMyJokeViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/16.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyJokeView.h"
#import "COMyJokeViewModel.h"

@interface COMyJokeView()<UITableViewDataSource, UITableViewDelegate>
{
    FCXRefreshHeaderView *headerRefreshView;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) COMyJokeViewModel *myJokeViewModel;

@end

@implementation COMyJokeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.myTableView];
        
        [self addHeadRefreshView];
        
        [SVProgressHUD ShowWaitMsg:@"正在加载"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WEAK_SELF(weakself)
            
            [weakself fetchJokeData];
        });
    }
    
    return self;
}


#pragma mark lazy load

- (UITableView *)myTableView
{
    if(_myTableView == nil)
    {
        CGRect rect = self.bounds;
        
        _myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.backgroundColor = [UIColor grayColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (COMyJokeViewModel *)myJokeViewModel
{
    if(_myJokeViewModel == nil)
    {
        _myJokeViewModel = [[COMyJokeViewModel alloc] initWithJokeType:@"joke"];
        
    }
    
    return _myJokeViewModel;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myJokeViewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.myJokeViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.myJokeViewModel heightForRowAtIndexPath:indexPath];
}

- (void)addHeadRefreshView
{
    WEAK_SELF(weakself)

    headerRefreshView = [self.myTableView addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        
        //refresh action
        
        [weakself fetchJokeData];
        
    }];
    
    [headerRefreshView setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
}

- (void)fetchJokeData
{
    WEAK_SELF(weakself)
    
    [self.myJokeViewModel requestDataModelWithCompletion:^(BOOL blfinished) {
        
        __weak FCXRefreshHeaderView *weakHeaderView = headerRefreshView;
        [weakHeaderView endRefresh];
        
        [SVProgressHUD hideWait];
        if(blfinished)
        {
            [weakself.myTableView reloadData];
        }

        
    }];

}



@end
