//
//  CORegisterNextView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/27.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COForgetEndView.h"

@interface COForgetEndView() <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *userpsdoldLabel;

@property (nonatomic, strong) UIView    *userpsdoldView;
@property (nonatomic, strong) UILabel *userpsdnewLabel;

@property (nonatomic, strong) UIView    *userpsdnewView;
@property (nonatomic, strong) UIButton  *finishBtn;


@end

@implementation COForgetEndView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
        [self addSubview:self.userpsdoldView];
        
        [self.userpsdoldView addSubview:self.userpsdoldLabel];
        [self.userpsdoldView addSubview:self.userpsdoldTextField];
        
        [self addSubview:self.userpsdnewView];
        
        [self.userpsdnewView addSubview:self.userpsdnewLabel];
        [self.userpsdnewView addSubview:self.userpsdnewTextField];
        
        [self addSubview:self.finishBtn];
        
        [self addUIConstraints];
        
        [self addTouchViewGesture];
    }
    
    return self;
}

#pragma  mark  ui layput

- (void)addUIConstraints
{
    [self.userpsdoldView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self).insets(UIEdgeInsetsMake(30, 20, 0, 20));
        make.height.mas_equalTo(50);
        
    }];
    
    [self.userpsdoldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(_userpsdoldView);
        make.left.equalTo(_userpsdoldView.mas_left).offset(10);
        make.width.equalTo(_userpsdoldView.mas_width).multipliedBy(0.25);
        make.height.equalTo(_userpsdoldView.mas_height);
    }];
    
    
    [self.userpsdoldTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_userpsdoldView);
        make.left.equalTo(_userpsdoldLabel.mas_right);
        make.right.equalTo(_userpsdoldView.mas_right).offset(-10);
        make.height.equalTo(_userpsdoldView.mas_height);
    }];
    

    [self.userpsdnewView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_userpsdoldView.mas_left);
        make.width.equalTo(_userpsdoldView.mas_width);
        make.top.equalTo(_userpsdoldView.mas_bottom).offset(10);
        make.height.equalTo(_userpsdoldView.mas_height);
        
    }];
    
    [self.userpsdnewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_userpsdnewView);
        make.left.equalTo(_userpsdnewView.mas_left).offset(10);
        make.width.equalTo(_userpsdoldLabel.mas_width);
        make.height.equalTo(_userpsdnewView.mas_height);
    }];
    
    [self.userpsdnewTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_userpsdnewLabel.mas_right);
        make.top.right.bottom.equalTo(_userpsdnewView);
        
    }];
    
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_userpsdnewView.mas_left);
        make.right.equalTo(_userpsdnewView.mas_right);
        make.top.equalTo(_userpsdnewView.mas_bottom).offset(20);
        make.height.mas_equalTo(ButtonHeight);
    }];
    
}

#pragma mark touch action

- (void)addTouchViewGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewAction:)];
    
    [self addGestureRecognizer:tapGesture];
}

- (void)touchViewAction:(UITapGestureRecognizer *)gesture
{
    [self resignKeyboard];
}

#pragma mark ui lazy load

- (UILabel *)userpsdoldLabel
{
    if(_userpsdoldLabel == nil)
    {
        _userpsdoldLabel = [[UILabel alloc] init];
        _userpsdoldLabel.font = [UIFont systemFontOfSize:16.0];
        _userpsdoldLabel.text = @"新密码";
        _userpsdoldLabel.textColor = [UIColor blackColor];
        _userpsdoldLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _userpsdoldLabel;
}

- (UITextField *)userpsdTextField
{
    if(_userpsdoldTextField == nil)
    {
        _userpsdoldTextField = [[UITextField alloc] init];
        _userpsdoldTextField.font = [UIFont systemFontOfSize:16.0];
        _userpsdoldTextField.textColor = [UIColor blackColor];
        _userpsdoldTextField.placeholder = @"输入6-12位密码";
        _userpsdoldTextField.backgroundColor = [UIColor clearColor];
        _userpsdoldTextField.borderStyle = UITextBorderStyleNone;
        _userpsdoldTextField.returnKeyType = UIReturnKeyNext;
        _userpsdoldTextField.clearButtonMode = UITextFieldViewModeAlways;
        _userpsdoldTextField.delegate = self;
        
    }
    
    return _userpsdoldTextField;
}


- (UIView *)userpsdoldView
{
    if(_userpsdoldView == nil)
    {
        _userpsdoldView = [[UIView alloc] init];
        _userpsdoldView.backgroundColor = shadowViewColor;
    }
    
    return _userpsdoldView;
}

- (UILabel *)userpsdnewLabel
{
    if(_userpsdnewLabel == nil)
    {
        _userpsdnewLabel = [[UILabel alloc] init];
        _userpsdnewLabel.font = [UIFont systemFontOfSize:16.0];
        _userpsdnewLabel.text = @"重复新密码";
        _userpsdnewLabel.textColor = [UIColor blackColor];
        _userpsdnewLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _userpsdnewLabel;
}

- (UITextField *)userpsdnewTextField
{
    if(_userpsdnewTextField == nil)
    {
        _userpsdnewTextField = [[UITextField alloc] init];
        _userpsdnewTextField.font = [UIFont systemFontOfSize:16.0];
        _userpsdnewTextField.textColor = [UIColor blackColor];
        _userpsdnewTextField.placeholder = @"输入6-12位密码";
        _userpsdnewTextField.backgroundColor = [UIColor clearColor];
        _userpsdnewTextField.borderStyle = UITextBorderStyleNone;
        _userpsdnewTextField.returnKeyType = UIReturnKeyDone;
        _userpsdnewTextField.clearButtonMode = UITextFieldViewModeAlways;
        _userpsdnewTextField.delegate = self;
        
    }
    
    return _userpsdnewTextField;
}

- (UIView *)userpsdnewView
{
    if(_userpsdnewView == nil)
    {
        _userpsdnewView = [[UIView alloc] init];
        _userpsdnewView.backgroundColor = shadowViewColor;
    }
    
    return _userpsdnewView;
}

- (UIButton *)finishBtn
{
    if(_finishBtn == nil)
    {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_finishBtn setBackgroundColor:orangeViewColor];
        [_finishBtn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _finishBtn;
}

#pragma mark button -action

- (void)finishBtnClicked:(UIButton *)sender
{
    [self resignKeyboard];
    
    if(self.finishBtnClickedBlock)
    {
        self.finishBtnClickedBlock();
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignKeyboard];
    
    return YES;
}


#pragma mark custom function

- (void)resignKeyboard
{
    [_userpsdnewTextField resignFirstResponder];
    [_userpsdnewTextField resignFirstResponder];
}

@end
