//
//  COForgetPSDNextViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COForgetPSDNextViewController.h"
#import "COForgetPSDEndViewController.h"

#import "COForgetNextView.h"
#import "COForgetNavigationBar.h"
#import "COForgetViewModel.h"

@interface COForgetPSDNextViewController()

@property (nonatomic, strong) COForgetNextView *nextView;
@property (nonatomic, strong) COForgetNavigationBar *navigationBar;
@property (nonatomic, strong) COForgetViewModel *viewModel;

@end

@implementation COForgetPSDNextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.navigationBar];
    
    [self.view addSubview:self.nextView];
    
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

#pragma mark UI layout

- (void)addUIConstriants
{
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.left.right.equalTo(self.view);
    
        make.height.mas_equalTo(NavBarHeight);
        
    }];
    
    [self.nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navigationBar.mas_bottom);
    }];
    
}

#pragma mark VM KVOHandle

- (void)addVMKVOHandle
{
    [self.KVOController observe:self.viewModel keyPath:@"invalid" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
    
        if([self.viewModel.invalid boolValue])
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

- (COForgetNavigationBar *)navigationBar
{
    if(_navigationBar == nil)
    {
        _navigationBar = [[COForgetNavigationBar alloc] initWithTitle:@"找回密码(2/3)"];
        
    }
    
    return _navigationBar;
}

- (COForgetNextView *)nextView
{
    if(_nextView == nil)
    {
        WEAK_SELF(weakself)
        _nextView = [[COForgetNextView alloc] init];
        
        _nextView.nextBtnClickedBlock = ^{
            
            weakself.viewModel.username = weakself.nextView.usernameTextField.text;
            weakself.viewModel.smsCode = weakself.nextView.checknumTextField.text;
        
            [weakself.viewModel forgetNext];
        };
        
        
    }
    
    return _nextView;
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
    COForgetPSDEndViewController *endVC = [[COForgetPSDEndViewController alloc] init];
    
    [self presentNewViewAnimation];
    
    [self presentViewController:endVC animated:NO completion:nil];
}



@end
