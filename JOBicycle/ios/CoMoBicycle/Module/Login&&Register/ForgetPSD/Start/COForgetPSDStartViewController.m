//
//  COForgetPSDViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COForgetPSDStartViewController.h"
#import "COForgetStartView.h"
#import "COForgetNavigationBar.h"
#import "COForgetViewModel.h"
#import "COForgetPSDNextViewController.h"

@interface COForgetPSDStartViewController()

@property (nonatomic, strong) COForgetNavigationBar *navigationBar;
@property (nonatomic, strong) COForgetStartView   *forgetStartView;
@property (nonatomic, strong) COForgetViewModel   *forgetViewModel;

@end

@implementation COForgetPSDStartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.forgetStartView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addUIConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addVMKVOHandle];
}

#pragma mark UI layout

- (void)addUIConstraints
{
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(NavBarHeight);
        
    }];
    
    [self.forgetStartView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_navigationBar.mas_bottom);
    }];
}

#pragma mark VM KVO
- (void)addVMKVOHandle
{
    [self.KVOController observe:self.forgetViewModel keyPath:@"invalid" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
        
        if([self.forgetViewModel.invalid boolValue])
        {
            [self gotoNextViewController];
        }
        else
        {
            [self showInfoStatus:self.forgetViewModel.invalidMsg];
        }
        
    }];
}



#pragma mark lazy load

- (COForgetNavigationBar *) navigationBar
{
    if(_navigationBar == nil)
    {
        WEAK_SELF(weakself)
        _navigationBar = [[COForgetNavigationBar alloc] initWithTitle:@"找回密码(1/3)"];
        
        _navigationBar.backBtnClickedBlock = ^{
            
            [weakself gotoBackViewController];
        };
    }
    
    return _navigationBar;
}

- (COForgetStartView *)forgetStartView
{
    if(_forgetStartView == nil)
    {
        WEAK_SELF(weakself)
        _forgetStartView = [[COForgetStartView alloc] init];
        
        _forgetStartView.forgetStartClickedBlock = ^(BOOL blAuth){
        
            weakself.forgetViewModel.username = weakself.forgetStartView.usernameTextField.text;
            weakself.forgetViewModel.authStatus = [NSNumber numberWithBool:blAuth];
        
            [weakself.forgetViewModel forgetStart];
            
        };
        
    }
    
    return _forgetStartView;
}

- (COForgetViewModel *)forgetViewModel
{
    if(_forgetViewModel == nil)
    {
        _forgetViewModel = [COForgetViewModel shareInstance];
    }
    
    return _forgetViewModel;
}



#pragma mark custom fun

- (void)gotoBackViewController
{
    [self dismissOldViewAnimation];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)gotoNextViewController
{
    COForgetPSDNextViewController *nextVC = [[COForgetPSDNextViewController alloc] init];
    
    [self presentNewViewAnimation];
    
    [self presentViewController:nextVC animated:NO completion:nil];
}

@end
