//
//  UserSettingViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/3.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingViewController.h"
#import "COUserSettingTableViewModel.h"
#import "COUserSettingHeaderView.h"
#import "COUserSettingHeadViewModel.h"
#import "COUserSettingHeadModel.h"

#import "COUserSettingFooterView.h"
#import "COUserSettingFootModel.h"
#import "COUserSettingFootViewModel.h"

#import "AppDelegate.h"
#import "COMediator+COMyZoneComponet.h"
#import "COMediator+COMyFavorComponet.h"
#import "COMediator+COMyAlbumComponet.h"
#import "COMediator+COMyFolderComponet.h"


@interface COUserSettingViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) COUserSettingHeaderView *settingHeaderView;
@property (nonatomic, strong) UITableView *settingTableView;
@property (nonatomic, strong) COUserSettingFooterView *settingFooterView;

@property (nonatomic, strong) COUserSettingTableViewModel *settingViewModel;
@property (nonatomic, strong) COUserSettingHeadViewModel *headViewModel;

@property (nonatomic, strong) COUserSettingFootViewModel *footViewModel;

@end

@implementation COUserSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.settingHeaderView];
    [self.view addSubview:self.settingTableView];
    [self.view addSubview:self.settingFooterView];
    
    
    [self setNavigationBar];
}

- (void)setNavigationBar
{
    [self.navigationController.navigationBar setTranslucent:YES];
    
    UIColor *color = [UIColor clearColor];
    
    CGRect rect = CGRectMake(0, 0, MAX_WIDTH, 64);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addUIConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self requestData];
    
    WEAK_SELF(weakself)
    [self.settingViewModel requestUserSettingModelWithCallBack:^(BOOL blfinished) {
        
        if(blfinished)
        {
            [weakself.settingTableView reloadData];
        }
    }];
}


#pragma mark ui layout

- (void)addUIConstraints
{
    [self.settingHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.3);
        
    }];
    
    [self.settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(_settingHeaderView.mas_bottom);
        make.bottom.equalTo(_settingFooterView.mas_top);
    }];
    
    [self.settingFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.1);
        
    }];
}

#pragma mark lazy load

- (COUserSettingHeaderView *)settingHeaderView
{
    if(_settingHeaderView == nil)
    {
        _settingHeaderView = [[COUserSettingHeaderView alloc] init];
    }

    return _settingHeaderView;
}

- (UITableView *)settingTableView
{
    if(_settingTableView == nil)
    {
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _settingTableView.backgroundColor = [UIColor whiteColor];
        
        if([_settingTableView respondsToSelector:@selector(setEstimatedRowHeight:)])
        {
            [_settingTableView setEstimatedRowHeight:64.0];
        }
    
    }
    
    return _settingTableView;
}

- (COUserSettingFooterView *)settingFooterView
{
    if(_settingFooterView == nil)
    {
        _settingFooterView = [[COUserSettingFooterView alloc] init];
    }
    
    return _settingFooterView;
}

- (COUserSettingTableViewModel *)settingViewModel
{
    if(_settingViewModel == nil)
    {
        _settingViewModel = [[COUserSettingTableViewModel alloc] init];
    }
    
    return _settingViewModel;
}

- (COUserSettingHeadViewModel *)headViewModel
{
    if(_headViewModel == nil)
    {
        _headViewModel = [[COUserSettingHeadViewModel alloc] init];
        
    }
    
    return _headViewModel;
}

- (COUserSettingFootViewModel *)footViewModel
{
    if(_footViewModel == nil)
    {
        _footViewModel = [[COUserSettingFootViewModel alloc] init];
        
    }
    return _footViewModel;
}


#pragma mark custom function

- (void)requestData
{
    WEAK_SELF(weakself)
    [self.headViewModel fetchUserSettingHeadDataWithCallBack:^(id response) {
       
        COUserSettingHeadModel *headModel = [[COUserSettingHeadModel alloc] initWithDictionary:response];
        
        [weakself.settingHeaderView setHeadModel:headModel];
        
    }];
    
    [self.footViewModel fetchUserSettingFootDataWithCallBack:^(id response) {
       
        COUserSettingFootModel *footModel = [[COUserSettingFootModel alloc] initWithDictionary:response];
        
        [weakself.settingFooterView setFootModel:footModel];
    }];
}


#pragma mark UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.settingViewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (UITableViewCell *)[self.settingViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.settingViewModel tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeSlideMenu:[indexPath row]];
}

#pragma mark function

- (void)closeSlideMenu:(NSInteger) index
{
    [[AppDelegate globalDelegate] closeDrawleft];
    
    UIViewController *viewcontroller = nil;
    
    switch (index) {
        case 0:
            
           viewcontroller = [[COMediator shareInstance] COMyZoneComponet_ViewController];
            
            break;
        case 1:
            
            viewcontroller = [[COMediator shareInstance] COMyFavorComponet_ViewController];
                    

            break;
        case 2:
            
            viewcontroller = [[COMediator shareInstance] COMyAlbumComponet_ViewController];
            
            break;
            
        case 3:
            
            viewcontroller = [[COMediator shareInstance] COMyFolderComponet_ViewController];
            
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }

     [[AppDelegate globalDelegate].rootNavigationController pushViewController:viewcontroller animated:YES];
}




@end
