//
//  COMyAlbumViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyWXCollectionViewController.h"
#import "COMyWXCollectionTableViewModel.h"

@interface COMyWXCollectionViewController() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *mytableView;
@property (nonatomic, strong)COMyWXCollectionTableViewModel *collectionTableViewModel;

@end

@implementation COMyWXCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:backGroundColor];
    
    [self.view addSubview:self.mytableView];
    
    [self setNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addUIConstriants];
    
    [self fetchCollectionData];
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
    
    [self setTitle:@"我的精选"];
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UI layout

- (void)addUIConstriants
{
    
    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.edges.equalTo(self.view);
        
    }];
    
}

#pragma mark lazy load

- (UITableView *)mytableView
{
    if(_mytableView == nil)
    {
        _mytableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
    }
    
    return _mytableView;
}

- (COMyWXCollectionTableViewModel *)collectionTableViewModel
{
    if(_collectionTableViewModel == nil)
    {
        _collectionTableViewModel = [[COMyWXCollectionTableViewModel alloc] init];
    }
    
    return _collectionTableViewModel;
}

#pragma mark function

- (void)fetchCollectionData
{
    [SVProgressHUD ShowWaitMsg:@"正在加载"];
    
    [self.collectionTableViewModel requestWXCollectionModelWithCompletion:^(BOOL blfinished) {
       
        [SVProgressHUD hideWait];
        if(blfinished)
        {
            [self.mytableView reloadData];
        }
        
    }];
}


#pragma mark tableViewdatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.collectionTableViewModel numbersOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionTableViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}


#pragma mark uitableviewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionTableViewModel heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [self.collectionTableViewModel tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSLog(@"url is %@", url);
}



@end
