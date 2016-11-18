//
//  COUserSettingHeaderView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/3.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingHeaderView.h"
#import "COUserSettingHeadModel.h"

@interface COUserSettingHeaderView()

@property (nonatomic, strong)UIImageView *headImage;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *descriptLabel;

@end

@implementation COUserSettingHeaderView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blurred_background"]];
        
        [self addSubview:self.headImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.descriptLabel];
        
        [self addUIConstriants];
        
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstriants
{
    NSInteger leftPadding = 10;
    NSInteger ImageSize = 60;
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(leftPadding);
        make.width.height.mas_equalTo(ImageSize);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headImage.mas_right).offset(10);
        make.top.equalTo(_headImage.mas_top).offset(10);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headImage.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.top.equalTo(_headImage.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
}

#pragma mark lazy load

- (UIImageView *)headImage
{
    if(_headImage == nil)
    {
        _headImage = [[UIImageView alloc] init];
        _headImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _headImage.layer.borderWidth = 1.0;
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = 30;
        
    }
    return _headImage;
}

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        
    }
    
    return _titleLabel;
}

- (UILabel *)descriptLabel
{
    if(_descriptLabel == nil)
    {
        _descriptLabel = [[UILabel alloc] init];
        _descriptLabel.textColor = [UIColor whiteColor];
        _descriptLabel.font = [UIFont systemFontOfSize:13.0];
        _descriptLabel.numberOfLines = 0;
    }
    
    return _descriptLabel;
}


#pragma mark member function

- (void)setHeadModel:(COUserSettingHeadModel *)headModel
{
    _headModel = headModel;
    
    NSURL *imageUrl = [NSURL URLWithString:headModel.headImageUrl];
    [_headImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholderimage"]];
    
    _titleLabel.text = headModel.titleStr;
    
    _descriptLabel.text = headModel.descriptionStr;
    
}

@end
