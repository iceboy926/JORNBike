//
//  COForgetPSDEndViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/1.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COForgetPSDEndViewController.h"

#import "COForgetEndView.h"
#import "COForgetNavigationBar.h"
#import "COForgetViewModel.h"

#import "COLoginViewController.h"

@interface COForgetPSDEndViewController()

@property (nonatomic, strong)COForgetEndView *endView;
@property (nonatomic, strong)COForgetNavigationBar *navigationBar;
@property (nonatomic, strong)COForgetViewModel *viewModel;

@end

@implementation COForgetPSDEndViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.endView];
    [self.view addSubview:self.navigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addUIConstriants];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addVMKVOHandle];
}

#pragma mark ui layout

- (void)addUIConstriants
{
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(NavBarHeight);
        
    }];
    
    [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navigationBar.mas_bottom);
    }];
}

#pragma mark KVO

- (void)addVMKVOHandle
{
    [self.KVOController observe:self.viewModel keyPath:@"invalid" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
    
        if([self.viewModel.invalid boolValue])
        {
            [self showInfoStatus:self.viewModel.invalidMsg];
        }
    }];
    
    [self.KVOController observe:self.viewModel keyPath:@"netStatus" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
        
        if([self.viewModel.netStatus boolValue])
        {
            [self showInfoStatus:self.viewModel.invalidMsg];
        }
    
    }];
    
    [self.KVOController observe:self.viewModel keyPath:@"finishedStatus" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
    
        if([self.viewModel.finishedStatus boolValue])
        {
            [self gotoNextViewController];
        }
        else
        {
            [self showInfoStatus:self.viewModel.invalidMsg];
        }
        
    }];
}

#pragma mark lazy load

- (COForgetEndView *)endView
{
    if(_endView == nil)
    {
        WEAK_SELF(weakself)
        _endView = [[COForgetEndView alloc] init];
        
        _endView.finishBtnClickedBlock = ^{
            
            weakself.viewModel.password = weakself.endView.userpsdoldTextField.text;
            weakself.viewModel.repeatPSD = weakself.endView.userpsdnewTextField.text;
            
            [weakself.viewModel forgetEnd];
        };
    }
    
    return _endView;
}

- (COForgetNavigationBar *)navigationBar
{
    if(_navigationBar == nil)
    {
        _navigationBar = [[COForgetNavigationBar alloc] initWithTitle:@"找回密码(3/3)"];
        
    }
    
    return _navigationBar;
}

- (COForgetViewModel *)viewModel
{
    if(_viewModel == nil)
    {
        _viewModel = [COForgetViewModel shareInstance];
    }
    
    return _viewModel;
}

#pragma mark custom function

- (void)gotoNextViewController
{
    COLoginViewController *loginVC = [[COLoginViewController alloc] init];
    
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end
