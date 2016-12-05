//
//  COMyFavorCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyFavorCell.h"
#import "COMyFavorCellModel.h"

CGFloat heightCell;

@interface COMyFavorCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel  *contentdescriptLabel;
@property (nonatomic, strong) UILabel  *contenttip;
@property (nonatomic, strong) UILabel  *timeLabel;

@end

@implementation COMyFavorCell

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *cellIdentifier = @"MyFavorCell";
    
    //COMyFavorCell *myFavorCell = [tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    //if(myFavorCell == nil)

      COMyFavorCell*  myFavorCell = [[COMyFavorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    return myFavorCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentImageView];
        [self.contentView addSubview:self.contentdescriptLabel];
        [self.contentView addSubview:self.contenttip];
        [self.contentView addSubview:self.timeLabel];
        [self addUIConstriants];
    }
    
    return self;
}

+(CGFloat)heightForCell
{
    return heightCell;
}


#pragma mark ui layout
- (void)addUIConstriants
{
    NSInteger leftPadding = 5;
    NSInteger midPadding = 10;
    NSInteger rightPadding = 5;
    NSInteger topPadding = 5;
    CGFloat width = 40;
    CGFloat height = width;
    CGFloat titleHeight = 30;
    CGFloat timeLabelWidth = 80;
    CGFloat ContentImageWidth = 80;
    CGFloat ContentImageHeight = ContentImageWidth;
    
    heightCell = 0.0;
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(leftPadding);
        make.top.equalTo(self.contentView.mas_top).offset(topPadding);
        make.size.mas_equalTo(CGSizeMake(width, height));
        
        heightCell = topPadding;
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headImageView.mas_right).offset(midPadding);
        make.right.equalTo(_timeLabel.mas_left).offset(-midPadding);
        make.top.equalTo(_headImageView.mas_top);
        make.height.mas_equalTo(titleHeight);
        
        heightCell += titleHeight;
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-rightPadding);
        make.width.mas_equalTo(timeLabelWidth);
        make.top.equalTo(_headImageView.mas_top);
        make.height.mas_equalTo(titleHeight);
        
    }];
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ContentImageWidth, ContentImageHeight));
        heightCell += ContentImageHeight;
    }];
    
    
    [self.contentdescriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_contentImageView.mas_top);
        make.left.equalTo(_contentImageView.mas_right).offset(5);
        make.right.equalTo(_timeLabel.mas_right);
        make.height.equalTo(_contentImageView.mas_height).multipliedBy(0.8);
    }];
    
    [self.contenttip mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_contentdescriptLabel.mas_bottom);
        make.left.equalTo(_contentdescriptLabel.mas_right).offset(5);
        make.right.equalTo(_timeLabel.mas_right);
        make.bottom.equalTo(_contentImageView.mas_bottom);
        
    }];
    
    
}

#pragma mark lazy load

- (UIImageView *)headImageView
{
    if(_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_placeholder"]];
        
        
    }
    return _headImageView;
}

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        
    }
    
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if(_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc] init];
        
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _timeLabel;
}

- (UIImageView *)contentImageView
{
    if(_contentImageView == nil)
    {
        _contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder_60x60"]];
        
    }
    
    return _contentImageView;
}

- (UILabel *)contentdescriptLabel
{
    if(_contentdescriptLabel == nil)
    {
        _contentdescriptLabel = [[UILabel alloc] init];
        
        _contentdescriptLabel.font = [UIFont systemFontOfSize:14.0];
        _contentdescriptLabel.textAlignment = NSTextAlignmentLeft;
        _contentdescriptLabel.backgroundColor = [UIColor clearColor];
        _contentdescriptLabel.numberOfLines = 0;
        
    }
    
    return _contentdescriptLabel;
}

- (UILabel *)contenttip
{
    if(_contenttip == nil)
    {
        _contenttip = [[UILabel alloc] init];
        
        _contenttip.font = [UIFont systemFontOfSize:12.0];
        _contenttip.textAlignment = NSTextAlignmentLeft;
        _contenttip.backgroundColor = [UIColor clearColor];
        _contenttip.textColor = [UIColor grayColor];
    }
    
    return _contenttip;
}


#pragma mark member function

- (void)setFavorCellModel:(COMyFavorCellModel *)favorCellModel
{
    _favorCellModel = favorCellModel;
    
    // headerImage
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:favorCellModel.strHeadImageUrl] placeholderImage:[UIImage imageNamed:@"header_placeholder"]];

    [self.headImageView addCorner:20];
 

    //title
    self.titleLabel.text = favorCellModel.strTitle;
    
    //time
    self.timeLabel.text = favorCellModel.strTime;


    //contentImage
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:favorCellModel.strContentImageUrl] placeholderImage:[UIImage imageNamed:@"ic_category_11"]];
    
    
    //ContentDescript
    
    self.contentdescriptLabel.text = favorCellModel.strContentDescript;
    
    
    self.contenttip.text = favorCellModel.strContentTip;
    
}


@end
