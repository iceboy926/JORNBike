//
//  CORegisterStartViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CORegisterStartViewController.h"
#import "CORegisterNextViewController.h"

#import "CORegistNavigationBar.h"
#import "CORegisterStartView.h"
#import "CORegisterViewModel.h"

@interface CORegisterStartViewController()

@property (nonatomic, strong) CORegistNavigationBar *navigaterBarView;
@property (nonatomic, strong) CORegisterStartView *registerStartView;
@property (nonatomic, strong) CORegisterViewModel *registerViewModel;


@end

@implementation CORegisterStartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.navigaterBarView];
    [self.view addSubview:self.registerStartView];
    
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

#pragma mark subview layout

- (void)addUIConstraints
{
    [self.navigaterBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(64);
        
    }];
    
    [self.registerStartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navigaterBarView.mas_bottom);
    }];
}

- (void)addVMKVOHandle
{
    [self.KVOController observe:self.registerViewModel keyPath:@"invalidStart" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
    
        if([self.registerViewModel.invalidStart boolValue])
        {
            [self showInfoStatus:self.registerViewModel.invalidMsg];
        }
    
    }];
    
    [self.KVOController observe:self.registerViewModel keyPath:@"smsCheck" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
    
        if([self.registerViewModel.smsCheck boolValue])
        {
            [self gotoNextViewController];
        }
        else
        {
            [self showInfoStatus:self.registerViewModel.invalidMsg];
        }
    
    }];

}

#pragma mark subview lazy load

- (CORegistNavigationBar *)navigaterBarView
{
    if(_navigaterBarView == nil)
    {
        WEAK_SELF(weakself)
        _navigaterBarView = [[CORegistNavigationBar alloc] initWithTitle:@"注册(1/3)"];
        
        _navigaterBarView.backBtnClickedBlock = ^{
        
            [weakself dismissOldViewAnimation];
            
            [weakself dismissViewControllerAnimated:NO completion:nil];
            
        };
        
        _navigaterBarView.nextBtnClickedBlock = ^{
        
            weakself.registerViewModel.username = weakself.registerStartView.usernameTextField.text;
            weakself.registerViewModel.checkSMS = weakself.registerStartView.checknumTextField.text;
            
            [weakself.registerViewModel startRegister];
            
        };
    }
    
    return _navigaterBarView;
}

- (CORegisterStartView *)registerStartView
{
    if(_registerStartView == nil)
    {
        _registerStartView = [[CORegisterStartView alloc] init];
     
    }
    
    return _registerStartView;
}

- (CORegisterViewModel *)registerViewModel
{
    if(_registerViewModel == nil)
    {
        _registerViewModel = [CORegisterViewModel shareInstance];
    }
    
    return _registerViewModel;
}

#pragma mark custom fuction

- (void)gotoNextViewController
{
    CORegisterNextViewController *nextVC = [[CORegisterNextViewController alloc] init];
    
    [self presentNewViewAnimation];
    
    [self presentViewController:nextVC animated:NO completion:nil];
}

@end
