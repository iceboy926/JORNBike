//
//  COLoginViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COLoginViewController.h"
#import "COLoginViewModel.h"
#import "COLoginView.h"

#import "COMediator+COBikeMainComponet.h"
#import "CORegisterStartViewController.h"
#import "COForgetPSDStartViewController.h"
#import "AppDelegate.h"
#import "COBaseNavigationController.h"

@interface COLoginViewController()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) COLoginView *loginView;
@property (nonatomic, strong) COLoginViewModel *loginViewModel;

@end

@implementation COLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addUIConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self viewModeKVOHandle];
}


#pragma mark UI Initialize

- (void)setupUI
{
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.loginView];
}

- (void)addUIConstraints
{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
}



#pragma mark View lazy load

- (COLoginView *)loginView
{
    if(_loginView == nil)
    {
        WEAK_SELF(weakself);
        _loginView = [[COLoginView alloc] init];
        _loginView.loginBtnClickedBlock = ^(NSString *userName, NSString *password){
        
           [weakself showWaitStatus:@"正在登录..."];
           weakself.loginViewModel.username = userName;
           weakself.loginViewModel.password = password;
           [weakself.loginViewModel login];
        };
        
        
        _loginView.newuserBtnClickedBlock = ^{
        
            [weakself gotoRegisterViewController];
        };
        
        _loginView.forgotPsdBtnClickedBlock = ^{
        
            [weakself gotoForgetPSDViewController];
        };
        
        
        _loginView.loginByBIOBtnClickedBlock = ^(NSString *userName){
        
        
        };
    }
    
    return _loginView;
}

- (UIImageView *)bgView
{
    if(_bgView == nil)
    {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_background.jpg"]];
    }
    
    return _bgView;
}


#pragma mark  View Model lazy load

- (COLoginViewModel *)loginViewModel
{
    if(_loginViewModel == nil)
    {
        _loginViewModel = [[COLoginViewModel alloc] init];
    }
    
    return _loginViewModel;
}

#pragma ViewModel KVO 

- (void)viewModeKVOHandle
{
    [self.KVOController observe:self.loginViewModel keyPath:@"invalid" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
        
        //[self hideWait];
        if([self.loginViewModel.invalid boolValue])
        {
            [self showInfoStatus:self.loginViewModel.invalidMsg];
        }
    }];
    
    [self.KVOController observe:self.loginViewModel keyPath:@"netStatus" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        
        //[self hideWait];
        if([self.loginViewModel.netStatus boolValue])
        {
            [self showInfoStatus:self.loginViewModel.invalidMsg];
        }

    }];
    
    [self.KVOController observe:self.loginViewModel keyPath:@"loginStatus" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
    
        [self hideWait];
        if([self.loginViewModel.loginStatus boolValue])
        {
            [self gotoMainViewController];
        }
        else
        {
            [self showInfoStatus:self.loginViewModel.invalidMsg];
        }
    }];
}

#pragma mark custom fun

- (void)gotoRegisterViewController
{
    CORegisterStartViewController *registVC = [[CORegisterStartViewController alloc] init];
    
    [self presentNewViewAnimation];
    
    [self presentViewController:registVC animated:NO completion:nil];
}

- (void)gotoForgetPSDViewController
{
    COForgetPSDStartViewController *forgetVC = [[COForgetPSDStartViewController alloc] init];
    
    [self presentNewViewAnimation];
    
    [self presentViewController:forgetVC animated:NO completion:nil];
}

- (void)gotoMainViewController
{
    UIViewController *mainVC = [[COMediator shareInstance] COBikeComponet_ViewController];
    
    [AppDelegate globalDelegate].rootNavigationController = [[COBaseNavigationController alloc] initWithRootViewController:mainVC];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
    
        [[AppDelegate globalDelegate] showMainPage];
    
    }];
}



@end
