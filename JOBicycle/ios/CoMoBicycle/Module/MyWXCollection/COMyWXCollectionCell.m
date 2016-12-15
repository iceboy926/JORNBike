//
//  COMyWXCollectionCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyWXCollectionCell.h"
#import "COMyWXCollectionModel.h"

CGFloat heightCollectionCell;

@interface COMyWXCollectionCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation COMyWXCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.firstImageView];
        [self.contentView addSubview:self.sourceLabel];
        [self.contentView addSubview:self.timeLabel];
        
        [self addUIConstriants];
    }
    
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *strCellIdentifier = @"collectionCell";
    
    COMyWXCollectionCell *collectionCell = [tableview dequeueReusableCellWithIdentifier:strCellIdentifier];
    if(collectionCell == nil)
    {
        collectionCell = [[COMyWXCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellIdentifier];
    }
    
    return collectionCell;
}

+(CGFloat)heightForCollectionCell
{
    return heightCollectionCell;
}

#pragma mark ui layout

- (void)addUIConstriants
{
    CGFloat leftPadding = 10.0;
    CGFloat  titleHeight = 50;
    CGFloat  sourceHeight = 30;
    heightCollectionCell = 0.0;
    
    CGFloat  imageSize = 100;
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, leftPadding, 0, leftPadding));
        make.height.mas_equalTo(titleHeight);
        
        heightCollectionCell = titleHeight;
        
    }];
    
    
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.width.mas_equalTo(imageSize);
        
        heightCollectionCell += imageSize;
    }];
    
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(leftPadding);
        make.top.equalTo(_firstImageView.mas_bottom);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(sourceHeight);
        
        heightCollectionCell += sourceHeight;
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_sourceLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-leftPadding);
        make.top.equalTo(_sourceLabel.mas_top);
        make.height.equalTo(_sourceLabel.mas_height);
        
        heightCollectionCell += 5;
    }];
    
}

#pragma mark lazy load

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textColor = UIColorFromRGB(0x364779);
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

- (UIImageView *)firstImageView
{
    if(_firstImageView == nil)
    {
        _firstImageView = [[UIImageView alloc] init];
    }
    
    return _firstImageView;
}

- (UILabel *)sourceLabel
{
    if(_sourceLabel == nil)
    {
        _sourceLabel = [[UILabel alloc] init];
        
        _sourceLabel.font = [UIFont systemFontOfSize:13.0];
        _sourceLabel.textColor = [UIColor grayColor];
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _sourceLabel;
}

- (UILabel *)timeLabel
{
    if(_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc] init];
        
        _timeLabel.font = [UIFont systemFontOfSize:13.0];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _timeLabel;
}

#pragma mark member function

- (void)setCollectionModel:(COMyWXCollectionModel *)collectionModel
{
    _collectionModel = collectionModel;
    
    self.titleLabel.text = [NSString replaceUnicode:collectionModel.titleStr];

    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:collectionModel.imageUrlStr] placeholderImage:[UIImage imageNamed:@"placeholderimage"]];
    self.sourceLabel.text = [NSString stringWithFormat:@"来自: %@", [NSString replaceUnicode:collectionModel.sourceStr]];
    
    NSString *timestr = [collectionModel.timeStr substringWithRange:NSMakeRange(7, 8)];
    
    NSString *yearstr = [timestr substringToIndex:4];
    NSString *monthstr = [timestr substringWithRange:NSMakeRange(4, 2)];
    NSString *daystr = [timestr substringFromIndex:6];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d年%d月%d日", [yearstr intValue], [monthstr intValue], [daystr intValue]];
    
}


@end
