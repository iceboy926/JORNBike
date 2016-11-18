//
//  CORegisterStartView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/26.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COForgetNextView.h"

@interface COForgetNextView() <UITextFieldDelegate>
{
    NSTimer *checkTimer;
    NSInteger checkCount;
}

@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UIView *usernameView;
@property (nonatomic, strong) UILabel *checknumLabel;
@property (nonatomic, strong) UIView *checkView;
@property (nonatomic, strong) UIButton *fetchChecknumBtn;
@property (nonatomic, strong) UIButton *nextBtn;


@end

@implementation COForgetNextView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        //self.backgroundColor = UIColorFromRGB(0xFFFFFF);
        
        [self.usernameView addSubview:self.usernameLabel];
        [self.usernameView addSubview:self.usernameTextField];
        [self addSubview:self.usernameView];
        
        [self.checkView addSubview:self.checknumLabel];
        [self.checkView addSubview:self.checknumTextField];
        [self addSubview:self.checkView];
        [self addSubview:self.fetchChecknumBtn];
        [self addSubview:self.nextBtn];
        
        [self addUIContraints];
        
        [self addTouchViewGesture];
        
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIContraints
{
    [self.usernameView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self).insets(UIEdgeInsetsMake(30, 20, 0, 20));
        make.height.mas_equalTo(50);
        
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_usernameView);
        make.left.top.bottom.equalTo(_usernameView).insets(UIEdgeInsetsMake(0, 10, 0, 0));
        make.width.equalTo(_usernameView.mas_width).multipliedBy(0.25);
        
    }];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_usernameView);
        make.left.equalTo(_usernameLabel.mas_right);
        make.top.bottom.equalTo(_usernameView);
        make.right.equalTo(_usernameView.mas_right).offset(-10);
    }];
    
    
    [self.checkView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_usernameView.mas_left);
        make.top.equalTo(_usernameView.mas_bottom).offset(10);
        make.height.equalTo(_usernameView.mas_height);
        make.width.equalTo(self.mas_width).multipliedBy(0.55);
    }];
    
    [self.checknumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_checkView);
        make.top.left.bottom.equalTo(_checkView).insets(UIEdgeInsetsMake(0, 10, 0, 0));
        make.width.equalTo(_usernameLabel.mas_width);
        
    }];
    
    [self.checknumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_checkView);
        make.left.equalTo(_checknumLabel.mas_right);
        make.height.equalTo(_checkView.mas_height);
        make.right.equalTo(_checkView.mas_right);
    }];
    
    [self.fetchChecknumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_usernameView.mas_right);
        make.top.bottom.equalTo(_checkView);
        make.left.equalTo(_checkView.mas_right).offset(5);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_checkView.mas_left);
        make.right.equalTo(_fetchChecknumBtn.mas_right);
        make.top.equalTo(_checkView.mas_bottom).offset(20);
        make.height.mas_equalTo(44);
    }];
    
}

#pragma mark add touch gesture

- (void)addTouchViewGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewAction:)];
    
    [self addGestureRecognizer:tapGesture];
}


#pragma mark lazy load

- (UILabel *)usernameLabel
{
    if(_usernameLabel == nil)
    {
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.text = @"手机号";
        _usernameLabel.font = [UIFont systemFontOfSize:16.0];
        _usernameLabel.textColor = [UIColor blackColor];
        _usernameLabel.backgroundColor = [UIColor clearColor];
        
    }
    
    return _usernameLabel;
}

- (UITextField *)usernameTextField
{
    if(_usernameTextField == nil)
    {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.textColor = [UIColor blackColor];
        _usernameTextField.font = [UIFont systemFontOfSize:16.0];
        _usernameTextField.backgroundColor = [UIColor clearColor];
        _usernameTextField.placeholder = @"11位手机号码";
        _usernameTextField.borderStyle = UITextBorderStyleNone;
        _usernameTextField.delegate = self;
        _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _usernameTextField.returnKeyType = UIReturnKeyNext;
    }
    
    return _usernameTextField;
}

- (UIView *)usernameView
{
    if(_usernameView == nil)
    {
        _usernameView = [[UIView alloc] init];
        _usernameView.backgroundColor = shadowViewColor;
        
    }
    
    return _usernameView;
}

- (UILabel *)checknumLabel
{
    if(_checknumLabel == nil)
    {
        _checknumLabel = [[UILabel alloc] init];
        _checknumLabel.text = @"短信验证码";
        _checknumLabel.font = [UIFont systemFontOfSize:16.0];
        _checknumLabel.textColor = [UIColor blackColor];
        _checknumLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _checknumLabel;
}

- (UITextField *)checknumTextField
{
    if(_checknumTextField == nil)
    {
        _checknumTextField = [[UITextField alloc] init];
        _checknumTextField.font = [UIFont systemFontOfSize:16.0];
        _checknumTextField.textColor = [UIColor blackColor];
        _checknumTextField.backgroundColor = [UIColor clearColor];
        _checknumTextField.placeholder = @"输入验证码";
        _checknumTextField.borderStyle = UITextBorderStyleNone;
        _checknumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _checknumTextField.returnKeyType = UIReturnKeyDone;
        _checknumTextField.delegate = self;
    }
    
    return _checknumTextField;
}

- (UIView *)checkView
{
    if(_checkView == nil)
    {
        _checkView = [[UIView alloc] init];
        _checkView.backgroundColor = shadowViewColor;
    }
    
    return _checkView;
}

- (UIButton *)fetchChecknumBtn
{
    if(_fetchChecknumBtn == nil)
    {
        _fetchChecknumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fetchChecknumBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _fetchChecknumBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [_fetchChecknumBtn setTitle:@"验证码" forState:UIControlStateNormal];
        [_fetchChecknumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fetchChecknumBtn setBackgroundColor:shadowViewColor];
        [_fetchChecknumBtn addTarget:self action:@selector(fetchChecknumBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _fetchChecknumBtn;
}

- (UIButton *)nextBtn
{
    if(_nextBtn == nil)
    {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:orangeViewColor];
        [_nextBtn addTarget:self action:@selector(nextbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _nextBtn;
}


#pragma mark Button-Action

- (void)fetchChecknumBtnClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    button.userInteractionEnabled = YES;
    
    checkCount = 60;
    checkTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:button repeats:YES];
    
    
}

- (void)nextbtnClicked:(UIButton *)sender
{
    [self resignKeyboard];
    
    if(self.nextBtnClickedBlock)
    {
        self.nextBtnClickedBlock();
    }
}


- (void)reduceTime:(NSTimer *)timer
{
    checkCount--;
    if(checkCount == 0)
    {
        [self.fetchChecknumBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [checkTimer invalidate];
        [self.fetchChecknumBtn setUserInteractionEnabled:YES];
        [self.fetchChecknumBtn setEnabled:YES];
    }
    else
    {
        NSString *strMsg = [NSString stringWithFormat:@"%lu秒后重新获取", checkCount];
        [self.fetchChecknumBtn setTitle:strMsg forState:UIControlStateNormal];
        [self.fetchChecknumBtn setUserInteractionEnabled:NO];
        [self.fetchChecknumBtn setEnabled:NO];
    }
}

#pragma mark touch-action

- (void)touchViewAction:(UITapGestureRecognizer *)gesture
{
    [self resignKeyboard];
}

#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignKeyboard];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    NSLog(@"usernameTextField text is %@", self.usernameTextField.text);
    if(self.usernameTextField.text.length > 9)
    {
        [self.fetchChecknumBtn setBackgroundColor:orangeViewColor];
        [self.fetchChecknumBtn setEnabled:YES];
    }
    else
    {
        [_fetchChecknumBtn setBackgroundColor:shadowViewColor];
        [self.fetchChecknumBtn setEnabled:NO];
    }
    
    return YES;
}

#pragma mark custom function

- (void)resignKeyboard
{
    [_usernameTextField resignFirstResponder];
    [_checknumTextField resignFirstResponder];
}

@end
