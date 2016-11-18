//
//  COBaseNavigationBar.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COLRBaseNavigationBar.h"

@interface COLRBaseNavigationBar()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation COLRBaseNavigationBar

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = navigaterBarColor;
        
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLabel];
        
        [self addUIConstraints];
        
    }
    
    return self;
}


#pragma mark UI layout

- (void)addUIConstraints
{
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(20, 0, 0, 0));
        make.width.mas_equalTo(44);
        
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(_backBtn.mas_top);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
        make.bottom.equalTo(self.mas_bottom);
    }];

}


#pragma mark lazy load

- (UIButton *)backBtn
{
    if(_backBtn == nil)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = customButtonColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    return _titleLabel;
}

#pragma mark button-action

- (void)backBtnClicked:(id)sender
{
    if(self.backBtnClickedBlock)
    {
        self.backBtnClickedBlock();
    }
}

#pragma mark member fun

- (void)setTitleStr:(NSString *)strTitle
{
    _titleLabel.text = strTitle;
}

@end
