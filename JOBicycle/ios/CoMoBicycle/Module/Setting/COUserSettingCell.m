//
//  COSettingCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/4.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingCell.h"

@interface COUserSettingCell()

@property (nonatomic, strong)UIImageView *headImage;
@property (nonatomic, strong)UILabel    *headLabel;
@property (nonatomic, strong)UIImageView *subImage;

@end

@implementation COUserSettingCell


+(instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *strcell = @"settingCell";
    
    COUserSettingCell *userCell = [tableview dequeueReusableCellWithIdentifier:strcell];
    if(userCell == nil)
    {
        userCell = [[COUserSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    
    return userCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.headLabel];
        //[self.contentView addSubview:self.subImage];
        self.backgroundColor = [UIColor clearColor];
        
        [self addUIConstraints];
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstraints
{
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.height.width.mas_equalTo(40);
        
    }];
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_height);
    }];
}

#pragma mark lazy load

- (UIImageView *)headImage
{
    if(_headImage == nil)
    {
        _headImage = [[UIImageView alloc] init];
        
    }
    
    return _headImage;
}

- (UILabel *)headLabel
{
    if(_headLabel == nil)
    {
        _headLabel = [[UILabel alloc] init];
        
        _headLabel.textColor = [UIColor blackColor];
        _headLabel.font = [UIFont systemFontOfSize:16.0];
        _headLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _headLabel;
}

- (UIImageView *)subImage
{
    if(_subImage == nil)
    {
        _subImage = [[UIImageView alloc] init];
    }
    
    return _subImage;
}

#pragma mark member function

- (void)setCellModel:(COUserSettingCellModel *)cellModel
{
    [_headImage sd_setImageWithURL:[NSURL URLWithString:cellModel.headimageStr] placeholderImage:[UIImage imageNamed:@"Album"]];
    
    _headLabel.text = cellModel.headTitle;
    
    //[_subImage sd_setImageWithURL:[NSURL URLWithString:cellModel.subimageStr] placeholderImage:[UIImage imageNamed:@""]];
    
}

+(CGFloat)heightForCell
{
    return 64.0;
}


@end
