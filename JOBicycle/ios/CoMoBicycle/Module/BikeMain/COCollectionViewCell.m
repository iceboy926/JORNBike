//
//  COCollectionViewCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/9.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COCollectionViewCell.h"
#import "COResultInfo.h"

@interface COCollectionViewCell()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *detailLabel;
@property (nonatomic, strong)UIView *lineView;


@end

@implementation COCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.lineView];
        
        [self addUIConstriants];
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstriants
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 20, 0, 10));
        make.height.equalTo(self.contentView).multipliedBy(0.3);
    }];
    
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(_lineView.mas_top).offset(-2);
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 3, 0));
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark lazy load

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if(_detailLabel == nil)
    {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = [UIFont systemFontOfSize:13.0];
        _detailLabel.numberOfLines = 0;
        _detailLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _detailLabel;
}

- (UIView *)lineView
{
    if(_lineView == nil)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
        
    }
    
    
    return _lineView;
}

- (void)configWithDataModel:(COResultInfo *)resultInfo
{
    _titleLabel.text = resultInfo.name;
    _detailLabel.text = resultInfo.detail;
}

@end
