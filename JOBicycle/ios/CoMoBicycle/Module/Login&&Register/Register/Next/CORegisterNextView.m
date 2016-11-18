//
//  CORegisterNextView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/27.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CORegisterNextView.h"

@interface CORegisterNextView() <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *userpsdLabel;

@property (nonatomic, strong) UIView    *userpsdView;

@end

@implementation CORegisterNextView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
        [self addSubview:self.userpsdView];
        
        [self.userpsdView addSubview:self.userpsdLabel];
        
        [self.userpsdView addSubview:self.userpsdTextField];
        
        [self addUIConstraints];
        
        [self addTouchViewGesture];
    }
    
    return self;
}

#pragma  mark  ui layput

- (void)addUIConstraints
{
    [self.userpsdView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self).insets(UIEdgeInsetsMake(30, 20, 0, 20));
        make.height.mas_equalTo(50);
        
    }];
    
    [self.userpsdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(_userpsdView);
        make.left.equalTo(_userpsdView.mas_left).offset(10);
        make.width.equalTo(_userpsdView.mas_width).multipliedBy(0.25);
        make.height.equalTo(_userpsdView.mas_height);
    }];
    
    
    [self.userpsdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_userpsdView);
        make.left.equalTo(_userpsdLabel.mas_right);
        make.right.equalTo(_userpsdView.mas_right).offset(-10);
        make.height.equalTo(_userpsdView.mas_height);
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
    [_userpsdTextField resignFirstResponder];
}

#pragma mark ui lazy load

- (UILabel *)userpsdLabel
{
    if(_userpsdLabel == nil)
    {
        _userpsdLabel = [[UILabel alloc] init];
        _userpsdLabel.font = [UIFont systemFontOfSize:16.0];
        _userpsdLabel.text = @"设置密码";
        _userpsdLabel.textColor = [UIColor blackColor];
        _userpsdLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _userpsdLabel;
}

- (UITextField *)userpsdTextField
{
    if(_userpsdTextField == nil)
    {
        _userpsdTextField = [[UITextField alloc] init];
        _userpsdTextField.font = [UIFont systemFontOfSize:16.0];
        _userpsdTextField.textColor = [UIColor blackColor];
        _userpsdTextField.placeholder = @"输入6-12位密码";
        _userpsdTextField.backgroundColor = [UIColor clearColor];
        _userpsdTextField.borderStyle = UITextBorderStyleNone;
        _userpsdTextField.returnKeyType = UIReturnKeyDone;
        _userpsdTextField.clearButtonMode = UITextFieldViewModeAlways;
        _userpsdTextField.delegate = self;
        
    }
    
    return _userpsdTextField;
}

- (UIView *)userpsdView
{
    if(_userpsdView == nil)
    {
        _userpsdView = [[UIView alloc] init];
        _userpsdView.backgroundColor = shadowViewColor;
    }
    
    return _userpsdView;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userpsdTextField resignFirstResponder];
    
    return YES;
}


@end
