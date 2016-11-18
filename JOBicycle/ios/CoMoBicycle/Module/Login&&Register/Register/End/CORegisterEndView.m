//
//  CORegisterEndView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/27.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CORegisterEndView.h"

@interface CORegisterEndView() <UITextFieldDelegate>

@property (nonatomic, strong) UIView        *backgroundView;
@property (nonatomic ,strong) UIButton      *headerImageBtn;
@property (nonatomic, strong) UILabel       *setheaderImageLabel;
@property (nonatomic, strong) UIButton      *finishedBtn;

@end

@implementation CORegisterEndView


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
        [self addSubview:self.backgroundView];
        
        [self.backgroundView addSubview:self.headerImageBtn];
        [self.backgroundView addSubview:self.setheaderImageLabel];
        
        [self addSubview:self.nickNameTextFiled];
        [self addSubview:self.finishedBtn];
        
        [self addUIConstraints];
        
        [self addViewGesture];
        
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstraints
{
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.4);
        
    }];
    
    [self.headerImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerX.equalTo(_backgroundView.mas_centerX);
        make.bottom.equalTo(_setheaderImageLabel.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    [self.setheaderImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_backgroundView.mas_centerX);
        make.bottom.equalTo(_backgroundView.mas_bottom).offset(-10);
        make.height.mas_equalTo(35);
        make.width.equalTo(_backgroundView.mas_width);
    }];
    
    [self.nickNameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(_backgroundView.mas_bottom).offset(30);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(35);
        
    }];
    
    [self.finishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 20, 0, 20));
        make.top.equalTo(_nickNameTextFiled.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
}

- (void)addViewGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewClicked:)];
    
    [self addGestureRecognizer:tapGesture];
}


- (void)touchViewClicked:(UITapGestureRecognizer *)gesture
{
    [_nickNameTextFiled resignFirstResponder];
}


#pragma mark ui lazy load

- (UIView *)backgroundView
{
    if(_backgroundView == nil)
    {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = navigaterBarColor;
    }
    
    return _backgroundView;
}

- (UIButton *)headerImageBtn
{
    if(_headerImageBtn == nil)
    {
        _headerImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _headerImageBtn.layer.borderWidth = 1.0;
        _headerImageBtn.layer.borderColor = UIColorFromRGB(0xFFFFFF).CGColor;
        _headerImageBtn.layer.cornerRadius = 40.0;
        _headerImageBtn.clipsToBounds = YES;
        
        [_headerImageBtn addTarget:self action:@selector(setHeaderImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_headerImageBtn setImage:[UIImage imageNamed:@"login_name"] forState:UIControlStateNormal];
        [_headerImageBtn setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
        
    }
    
    return _headerImageBtn;
}

- (UILabel *)setheaderImageLabel
{
    if(_setheaderImageLabel == nil)
    {
        _setheaderImageLabel = [[UILabel alloc] init];
        
        _setheaderImageLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _setheaderImageLabel.backgroundColor = [UIColor clearColor];
        _setheaderImageLabel.text = @"点击设置头像";
        _setheaderImageLabel.font = [UIFont systemFontOfSize:15.0];
        _setheaderImageLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return _setheaderImageLabel;
}

- (UITextField *)nickNameTextFiled
{
    if(_nickNameTextFiled == nil)
    {
        _nickNameTextFiled = [[UITextField alloc] init];
        
        _nickNameTextFiled.font = [UIFont systemFontOfSize:16.0];
        _nickNameTextFiled.textColor = [UIColor grayColor];
        _nickNameTextFiled.backgroundColor = [UIColor whiteColor];
        _nickNameTextFiled.returnKeyType = UIReturnKeyDone;
        _nickNameTextFiled.delegate = self;
        _nickNameTextFiled.placeholder = @" 请输入用户昵称";
        
    }
    
    return _nickNameTextFiled;
}

- (UIButton *)finishedBtn
{
    if(_finishedBtn == nil)
    {
        _finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _finishedBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _finishedBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [_finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishedBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_finishedBtn setBackgroundColor:customButtonColor];
        
        [_finishedBtn addTarget:self action:@selector(fininshedBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _finishedBtn;
}


#pragma mark button action

- (void)setHeaderImageBtnClicked:(id)sender
{
    if(self.headImageBtnClickedBlock)
    {
        self.headImageBtnClickedBlock();
    }
}

- (void)fininshedBtnClicked:(id)sender
{
    if(self.finishedBtnClickedBlock)
    {
        self.finishedBtnClickedBlock();
    }
}

#pragma mark UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
    
        [_nickNameTextFiled resignFirstResponder];
        
    } completion:^(BOOL finished){
    
        [_finishedBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    }];
    
    return YES;
}

#pragma mark custom function

- (void)setHeadImage:(UIImage *)image
{
    [_headerImageBtn setImage:image forState:UIControlStateNormal];
}


@end
