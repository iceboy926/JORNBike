//
//  COLoginView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COLoginView.h"

@interface COLoginView() <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *psdTextField;
@property (nonatomic, strong) UIView      *bgView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIButton    *loginBtn;
@property (nonatomic, strong) UIButton    *newUserBtn;
@property (nonatomic, strong) UIButton    *forgotPsdBtn;
@property (nonatomic, strong) UIButton    *fingerPressLoginBtn;

@end

@implementation COLoginView


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        //self.backgroundColor = [UIColor clearColor];
    
        [self addSubview:self.logoImageView];
        [self.bgView addSubview:self.userTextField];
        [self.bgView addSubview:self.psdTextField];
        [self addSubview:self.bgView];
        [self addSubview:self.loginBtn];
        [self addSubview:self.newUserBtn];
        [self addSubview:self.forgotPsdBtn];
        [self addSubview:self.fingerPressLoginBtn];
        
        [self addSubViewConstraints];
        
        [self addViewGesture];
    }
    
    return self;
}


#pragma mark Control layout

- (void)addSubViewConstraints
{
    int padding = 10;
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(44);
        make.width.and.height.mas_equalTo(60);
    }];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(_logoImageView.mas_bottom).with.offset(padding);
        make.left.equalTo(self).with.offset(padding);
        make.right.equalTo(self).with.offset(-padding);
        make.height.mas_equalTo(110);
    }];
    
    
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(_bgView).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
        make.height.equalTo(_bgView.mas_height).multipliedBy(0.4);
        
    }];
    
    [self.psdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(_bgView).insets(UIEdgeInsetsMake(0, padding, padding, padding));
        make.height.equalTo(_userTextField.mas_height);
    }];
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(_bgView.mas_bottom).with.offset(padding);
        make.left.equalTo(self).with.offset(padding*2);
        make.right.equalTo(self).with.offset(-padding*2);
        make.height.mas_equalTo(44);
    }];
    
    [self.newUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_loginBtn.mas_left);
        make.top.equalTo(_loginBtn.mas_bottom).with.offset(padding/2.0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(35);
    }];
    
    
    [self.forgotPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_loginBtn.mas_right);
        make.top.equalTo(_newUserBtn.mas_top);
        make.width.and.height.equalTo(_newUserBtn);
    }];
    

    [self.fingerPressLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.left.equalTo(self).with.offset(padding*4);
        make.right.equalTo(self).with.offset(-padding*4);
        make.bottom.equalTo(self).offset(-padding*2);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark View TapGestureRecognizer

- (void)addViewGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewAction:)];
    
    [self addGestureRecognizer:tapGesture];
}


#pragma mark  control lazy load
/**
 *  lazy loading
 */

- (UIImageView *)logoImageView
{
    if(_logoImageView == nil)
    {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"icon_logo"];
        
    }
    
    return _logoImageView;
}


- (UIView *)bgView
{
    if(_bgView == nil)
    {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 3.0;
        _bgView.alpha = 0.7;
    }
    
    return _bgView;
}

- (UITextField *)userTextField
{
    if(_userTextField == nil)
    {
        _userTextField = [[UITextField alloc] init];
        
        _userTextField.delegate = self;
        _userTextField.font = [UIFont systemFontOfSize:16.0];
        _userTextField.layer.borderWidth = 0.3f;
        _userTextField.layer.borderColor = UIColorFromRGB(0xEFEFEF).CGColor;
        _userTextField.placeholder = @"请输入您的手机号码";
        
        UIImageView *userLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_name"]];
        userLeftView.frame = CGRectMake(0, 0, 30, 20);
        userLeftView.contentMode = UIViewContentModeScaleAspectFit;
        
        _userTextField.leftViewMode = UITextFieldViewModeAlways;
        _userTextField.leftView = userLeftView;
        _userTextField.keyboardType = UIKeyboardTypeNumberPad;
        _userTextField.returnKeyType = UIReturnKeyNext;
        _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        
    }
    
    return _userTextField;
}

- (UITextField *)psdTextField
{
    if(_psdTextField == nil)
    {
        _psdTextField = [[UITextField alloc] init];
        
        _psdTextField.delegate = self;
        _psdTextField.font = [UIFont systemFontOfSize:16.0];
        _psdTextField.layer.borderWidth = 0.3f;
        _psdTextField.layer.borderColor = UIColorFromRGB(0xEFEFEF).CGColor;
        _psdTextField.placeholder = @"密码";
        
        UIImageView *psdLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
        psdLeftView.frame = CGRectMake(0, 0, 30, 20);
        psdLeftView.contentMode = UIViewContentModeScaleAspectFit;
        
        _psdTextField.leftViewMode = UITextFieldViewModeAlways;
        _psdTextField.leftView = psdLeftView;
        _psdTextField.secureTextEntry = YES;
        _psdTextField.returnKeyType = UIReturnKeyDone;
        
    }
    
    return _psdTextField;
}

- (UIButton *)loginBtn
{
    if(_loginBtn == nil)
    {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _loginBtn.titleLabel.textColor = [UIColor whiteColor];
        _loginBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        [_loginBtn setBackgroundColor:customButtonColor];
        _loginBtn.layer.cornerRadius = 0.5;
        
        [_loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _loginBtn;
}

- (UIButton *)newUserBtn
{
    if(_newUserBtn == nil)
    {
        _newUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _newUserBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _newUserBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [_newUserBtn setTitle:@"快速注册" forState:UIControlStateNormal];
        [_newUserBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_newUserBtn addTarget:self action:@selector(newUserClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _newUserBtn;
}

- (UIButton *)forgotPsdBtn
{
    if(_forgotPsdBtn == nil)
    {
        _forgotPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _forgotPsdBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _forgotPsdBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [_forgotPsdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgotPsdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_forgotPsdBtn addTarget:self action:@selector(forgotPsdClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _forgotPsdBtn;
}

- (UIButton *)fingerPressLoginBtn
{
    if(_fingerPressLoginBtn == nil)
    {
        _fingerPressLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fingerPressLoginBtn.layer.borderWidth = 3.0;
        _fingerPressLoginBtn.layer.borderColor = UIColorFromRGB(0xFFFFFF).CGColor;
        _fingerPressLoginBtn.layer.cornerRadius = 0.5f;

        _fingerPressLoginBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _fingerPressLoginBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [_fingerPressLoginBtn setTitle:@"切换登录方式" forState:UIControlStateNormal];
        [_fingerPressLoginBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_fingerPressLoginBtn addTarget:self action:@selector(fingerPressLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _fingerPressLoginBtn;
}



#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self loginClicked:nil];
    
    return YES;
}



#pragma mark Button-Action

- (void)loginClicked:(id)sender
{
    [self resignResponse];
    
    if(self.loginBtnClickedBlock)
    {
        self.loginBtnClickedBlock(_userTextField.text, _psdTextField.text);
    }
}

- (void)newUserClicked:(id)sender
{
    [self resignResponse];
    
    if(self.newuserBtnClickedBlock)
    {
        self.newuserBtnClickedBlock();
    }
}

- (void)forgotPsdClicked:(id)sender
{
    [self resignResponse];
    if(self.forgotPsdBtnClickedBlock)
    {
        self.forgotPsdBtnClickedBlock();
    }
}

- (void)fingerPressLoginBtnClicked:(id)sender
{
    [self resignResponse];
    
    if(self.loginByBIOBtnClickedBlock)
    {
        self.loginByBIOBtnClickedBlock(_userTextField.text);
    }
}

#pragma mark View TapGesture - Action

- (void)touchViewAction:(UITapGestureRecognizer *)gesture
{
    [self resignResponse];
}


- (void)resignResponse
{
    [_userTextField resignFirstResponder];
    [_psdTextField resignFirstResponder];
}


@end
