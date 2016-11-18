//
//  COBaseNavigationBar.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COBMHeaderView.h"

@interface COBMHeaderView()
{
    NSString *strTitle;
    NSData *headImageData;
}

@property (nonatomic, strong) UIButton *leftSliderBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation COBMHeaderView

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = navigaterBarColor;
        
        strTitle = title;
        
        [self addSubview:self.leftSliderBtn];
        [self addSubview:self.titleLabel];
        
        [self addUIConstraints];
        
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title HeaderImage:(NSData *)headData
{
    self = [super init];
    if(self)
    {
        strTitle = title;
        
        headImageData = headData;
        
        self.backgroundColor = navigaterBarColor;
        
        [self addSubview:self.leftSliderBtn];
        [self addSubview:self.titleLabel];
        
        [self addUIConstraints];
    }
    
    return self;
}


#pragma mark UI layout

- (void)addUIConstraints
{
    [self.leftSliderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(_leftSliderBtn.mas_top);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
        make.bottom.equalTo(self.mas_bottom);
    }];

}


#pragma mark lazy load

- (UIButton *)leftSliderBtn
{
    if(_leftSliderBtn == nil)
    {
        _leftSliderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _leftSliderBtn.layer.borderColor = navigaterBarColor.CGColor;
        _leftSliderBtn.layer.borderWidth = 1.0;
        _leftSliderBtn.layer.cornerRadius = 20;
        _leftSliderBtn.layer.masksToBounds = YES;
        
        [_leftSliderBtn setImage:[UIImage imageWithData:headImageData] forState:UIControlStateNormal];
        
        [_leftSliderBtn addTarget:self action:@selector(leftSlideBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftSliderBtn;
}

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.text = strTitle;
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = customButtonColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    return _titleLabel;
}

#pragma mark button-action

- (void)leftSlideBtnClicked:(id)sender
{
    if(self.leftbtnClickBlock)
    {
        self.leftbtnClickBlock();
    }
}


@end
