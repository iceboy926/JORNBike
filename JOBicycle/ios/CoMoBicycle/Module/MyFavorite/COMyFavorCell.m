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
@property (nonatomic, strong) UILabel  *timeLabel;

@end

@implementation COMyFavorCell

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *cellIdentifier = @"MyFavorCell";
    
    COMyFavorCell *myFavorCell = [tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if(myFavorCell == nil)
    {
        myFavorCell = [[COMyFavorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
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
    
}

#pragma mark lazy load

- (UIImageView *)headImageView
{
    if(_headImageView == nil)
    {
        
    }
    return _headImageView;
}

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        
    }
    
    return _titleLabel;
}

- (UIImageView *)contentImageView
{
    if(_contentImageView == nil)
    {
        
    }
    
    return _contentImageView;
}

@end
