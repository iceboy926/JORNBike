//
//  COUserSettingFooterView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/4.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingFooterView.h"
#import "COUserSettingFootModel.h"

@interface COUserSettingFooterView()

@property (nonatomic, strong) UIImageView *mySettingImage;
@property (nonatomic, strong) UIButton *mySettingBtn;

@property (nonatomic, strong) UIImageView *myQuitImage;
@property (nonatomic, strong) UIButton *myQuitBtn;

@end

@implementation COUserSettingFooterView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mySettingImage];
        [self addSubview:self.mySettingBtn];
        [self addSubview:self.myQuitImage];
        [self addSubview:self.myQuitBtn];
        
        [self addUIConstraints];
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstraints
{
    NSInteger imageSize = 25;
    NSInteger leftpadding = 20;
    
    [self.mySettingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(leftpadding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.and.height.mas_equalTo(imageSize);
    }];
    
    
    [self.mySettingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_mySettingImage.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.mas_centerX);
    }];
    
    
    [self.myQuitImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_mySettingBtn.mas_right).offset(leftpadding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.and.height.mas_equalTo(imageSize);
    }];
    
    
    [self.myQuitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_myQuitImage.mas_right);
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
        
    }];
}

#pragma mark lazy load

- (UIImageView *)mySettingImage
{
    if(_mySettingImage == nil)
    {
        _mySettingImage = [[UIImageView alloc] init];
        
    }
    
    return _mySettingImage;
}

- (UIButton *)mySettingBtn
{
    if(_mySettingBtn == nil)
    {
        _mySettingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mySettingBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _mySettingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [_mySettingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_mySettingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_mySettingBtn setBackgroundColor:[UIColor clearColor]];
        
        [_mySettingBtn addTarget:self action:@selector(mysettingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _mySettingBtn;
}

- (UIImageView *)myQuitImage
{
    if(_myQuitImage == nil)
    {
        _myQuitImage = [[UIImageView alloc] init];
    }
    
    return _myQuitImage;
}

- (UIButton *)myQuitBtn
{
    if(_myQuitBtn == nil)
    {
        _myQuitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _myQuitBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _myQuitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [_myQuitBtn setTitle:@"退出" forState:UIControlStateNormal];
        [_myQuitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_myQuitBtn setBackgroundColor:[UIColor clearColor]];
        [_myQuitBtn addTarget:self action:@selector(myquitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _myQuitBtn;
}

#pragma mark target-action

- (void)mysettingBtnClicked:(UIButton *)sender
{
    if(self.didsettingBtnClicked)
    {
        self.didsettingBtnClicked();
    }
}

- (void)myquitBtnClicked:(UIButton *)sender
{
    
    if(self.didquitBtnClicked)
    {
        self.didquitBtnClicked();
    }
    
}

#pragma mark member function

- (void)setFootModel:(COUserSettingFootModel *)footModel
{
    _footModel = footModel;
    
    NSURL *settingURL = [NSURL URLWithString:footModel.settingImageUrl];
    
    [self.mySettingImage sd_setImageWithURL:settingURL placeholderImage:[UIImage imageNamed:@"Setting"]];
    
    [self.mySettingBtn setTitle:footModel.settingTitleStr forState:UIControlStateNormal];
    
    NSURL *quitURL = [NSURL URLWithString:footModel.quitImageUrl];
    
    [self.myQuitImage sd_setImageWithURL:quitURL placeholderImage:[UIImage imageNamed:@"logout-night"]];
    
    [self.myQuitBtn setTitle:footModel.quitTitleStr forState:UIControlStateNormal];
    
}

@end
