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
    }
    
    return self;
}


#pragma mark lazy load

- (UITableView *)myTableView
{
    if(_myTableView == nil)
    {
        _myTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.backgroundColor = [UIColor grayColor];
        
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
}

- (void)fetchJokeData
{
    WEAK_SELF(weakself)
    
    [self.myJokeViewModel requestDataModelWithCompletion:^(BOOL blfinished) {
        
        __weak FCXRefreshHeaderView *weakHeaderView = headerRefreshView;
        [weakHeaderView endRefresh];
        
        if(blfinished)
        {
            [weakself.myTableView reloadData];
        }

        
    }];

}



@end
