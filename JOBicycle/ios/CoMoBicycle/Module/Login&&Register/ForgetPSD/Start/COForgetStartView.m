//
//  COForgetStartView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COForgetStartView.h"
#import "COAuthCodeView.h"

@interface COForgetStartView() <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *authcodeLabel;
@property (nonatomic, strong) UIView      *usernamebgView;
@property (nonatomic, strong) UIView      *authcodebgView;
@property (nonatomic, strong) UIButton    *forgetStartBtn;

@end


@implementation COForgetStartView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self addSubview:self.usernamebgView];
        [self.usernamebgView addSubview:self.usernameLabel];
        [self.usernamebgView addSubview:self.usernameTextField];
        
        [self addSubview:self.authcodebgView];
        [self.authcodebgView addSubview:self.authcodeLabel];
        [self.authcodebgView addSubview:self.authCodeTextField];
        
        [self addSubview:self.authCodeView];
        
        [self addSubview:self.forgetStartBtn];
        
        [self addUIConstraints];
        
        [self addTouchView];
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstraints
{
    [self.usernamebgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(30, 20, 0, 20));
        make.height.mas_equalTo(50);
        
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_usernamebgView);
        make.top.left.bottom.equalTo(_usernamebgView).insets(UIEdgeInsetsMake(0, 10, 0, 0));
        make.width.equalTo(_usernamebgView).multipliedBy(0.3);
    }];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_usernamebgView);
        make.right.top.bottom.equalTo(_usernamebgView).insets(UIEdgeInsetsMake(0, 0, 0, 10));
        make.left.equalTo(_usernameLabel.mas_right);
    }];
    
    [self.authcodebgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_usernamebgView.mas_bottom).offset(10);
        make.left.equalTo(_usernamebgView.mas_left);
        make.width.equalTo(_usernamebgView.mas_width).multipliedBy(0.6);
        make.height.equalTo(_usernamebgView.mas_height);
        
    }];
    
    [self.authcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_authcodebgView);
        make.top.left.bottom.equalTo(_authcodebgView).insets(UIEdgeInsetsMake(0, 10, 0, 0));
        make.width.equalTo(_usernameLabel.mas_width);
        
    }];
    
    [self.authCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_authcodebgView);
        make.left.equalTo(_authcodeLabel.mas_right);
        make.top.right.bottom.equalTo(_authcodebgView);
        
    }];
    
    [self.authCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_authcodebgView.mas_top);
        make.left.equalTo(_authcodebgView.mas_right).offset(10);
        make.right.equalTo(_usernamebgView.mas_right);
        make.height.equalTo(_authcodebgView.mas_height);
    }];
    
    [self.forgetStartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_authcodebgView.mas_left);
        make.right.equalTo(_authCodeView.mas_right);
        make.top.equalTo(_authcodebgView.mas_bottom).offset(20);
        make.height.mas_equalTo(44);
    }];
}


#pragma mark touch-action

- (void)addTouchView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewAction:)];
    
    [self addGestureRecognizer:tapGesture];
}

#pragma mark ui lazy load

- (UILabel *)usernameLabel
{
    if(_usernameLabel == nil)
    {
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.text = @"手机号";
        _usernameLabel.font = [UIFont systemFontOfSize:16.0];
        _usernameLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _usernameLabel;
}



- (UITextField *)usernameTextField
{
    if(_usernameTextField == nil)
    {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.font = [UIFont systemFontOfSize:16.0];
        _usernameTextField.textColor = [UIColor blackColor];
        _usernameTextField.backgroundColor = [UIColor clearColor];
        _usernameTextField.placeholder = @"11位手机号码";
        _usernameTextField.borderStyle = UITextBorderStyleNone;
        _usernameTextField.delegate = self;
        _usernameTextField.keyboardType = UIKeyboardTypePhonePad;
        _usernameTextField.returnKeyType = UIReturnKeyNext;
        
    }
    
    return _usernameTextField;
}

- (UIView *)usernamebgView
{
    if(_usernamebgView == nil)
    {
        _usernamebgView = [[UIView alloc] init];
        _usernamebgView.backgroundColor = shadowViewColor;
        
    }
    
    return _usernamebgView;
}

- (UILabel *)authcodeLabel
{
    if(_authcodeLabel == nil)
    {
        _authcodeLabel = [[UILabel alloc] init];
        _authcodeLabel.font = [UIFont systemFontOfSize:16.0];
        _authcodeLabel.text = @"校验码";
        _authcodeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _authcodeLabel;
}

- (UITextField *)authCodeTextField
{
    if(_authCodeTextField == nil)
    {
        _authCodeTextField = [[UITextField alloc] init];
        _authCodeTextField.backgroundColor = [UIColor clearColor];
        _authCodeTextField.placeholder = @"";
        _authCodeTextField.borderStyle = UITextBorderStyleNone;
        _authCodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _authCodeTextField.delegate = self;
        _authCodeTextField.returnKeyType = UIReturnKeyDone;
    }
    
    return _authCodeTextField;
}

- (UIView *)authcodebgView
{
    if(_authcodebgView == nil)
    {
        _authcodebgView = [[UIView alloc] init];
        _authcodebgView.backgroundColor = shadowViewColor;
    }
    
    return _authcodebgView;
}

- (COAuthCodeView *)authCodeView
{
    if(_authCodeView == nil)
    {
        _authCodeView = [[COAuthCodeView alloc] init];
    }
    
    return _authCodeView;
}

- (UIButton *)forgetStartBtn
{
    if(_forgetStartBtn == nil)
    {
        _forgetStartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _forgetStartBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        
        [_forgetStartBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_forgetStartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forgetStartBtn setBackgroundColor:customButtonColor];
        [_forgetStartBtn addTarget:self action:@selector(forgetStartBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _forgetStartBtn;
}

#pragma mark UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignKeyboard];
    
    return YES;
}

#pragma mark touch view

- (void)touchViewAction:(UITapGestureRecognizer *)gesture
{
    [self resignKeyboard];
}

#pragma mark button action

- (void)forgetStartBtnClicked:(UIButton *)sender
{
    NSString *strInput = [_authCodeTextField.text lowercaseString];

    BOOL blAuth = [strInput isEqualToString:[_authCodeView.getCode lowercaseString]];
    
    if(self.forgetStartClickedBlock)
    {
        self.forgetStartClickedBlock(blAuth);
    }
}


#pragma mark custom fun

- (void)resignKeyboard
{
    [_usernameTextField resignFirstResponder];
    [_authCodeTextField resignFirstResponder];
}


@end
