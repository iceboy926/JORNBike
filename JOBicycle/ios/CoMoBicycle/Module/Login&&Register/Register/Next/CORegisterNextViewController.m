//
//  CORegisterViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CORegisterNextViewController.h"
#import "CORegisterStartViewController.h"
#import "CORegisterEndViewController.h"

#import "CORegistNavigationBar.h"
#import "CORegisterNextView.h"

#import "CORegisterViewModel.h"


@interface CORegisterNextViewController()

@property (nonatomic, strong) CORegistNavigationBar       *navigaterBar;
@property (nonatomic, strong) CORegisterNextView    *nextView;
@property (nonatomic, strong) CORegisterViewModel   *registerViewModel;


@end

@implementation CORegisterNextViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.navigaterBar];
    [self.view addSubview:self.nextView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addUIContraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addVMKVOHandle];
}

#pragma mark ui layout

- (void)addUIContraints
{
    [self.navigaterBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(64);
        
    }];
    
    [self.nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navigaterBar.mas_bottom);
    }];
}

- (void)addVMKVOHandle
{
    [self.KVOController observe:self.registerViewModel keyPath:@"invalidNext" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
        
        if([self.registerViewModel.invalidNext boolValue])
        {
            [self showInfoStatus:self.registerViewModel.invalidMsg];
        }
        else
        {
            [self gotoNextViewController];
        }
    
    }];
}


#pragma mark ui lazy load

- (CORegistNavigationBar *)navigaterBar
{
    if(_navigaterBar == nil)
    {
        WEAK_SELF(weakself)
        _navigaterBar = [[CORegistNavigationBar alloc] initWithTitle:@"注册(2/3)"];
        
        _navigaterBar.backBtnClickedBlock = ^{
            
            [weakself dismissOldViewAnimation];
            [weakself dismissViewControllerAnimated:NO completion:nil];
        };
        
        _navigaterBar.nextBtnClickedBlock = ^{
        
            weakself.registerViewModel.password = weakself.nextView.userpsdTextField.text;
        
            [weakself.registerViewModel nextRegister];
            
        };
    }
    
    return _navigaterBar;
}


- (CORegisterNextView *)nextView
{
    if(_nextView == nil)
    {
        _nextView = [[CORegisterNextView alloc] init];
    }
    
    return _nextView;
}

- (CORegisterViewModel *)registerViewModel
{
    if(_registerViewModel == nil)
    {
        _registerViewModel = [CORegisterViewModel shareInstance];
    }
    
    return _registerViewModel;
}

#pragma mark custom function

- (void)gotoNextViewController
{
    CORegisterEndViewController *endVC = [[CORegisterEndViewController alloc] init];
    
    [self presentNewViewAnimation];
    
    [self presentViewController:endVC animated:NO completion:nil];
}


@end
