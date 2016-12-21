//
//  COMyHistoryTodayCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyHistoryTodayCell.h"
#import "COMyHistoryTodayModel.h"

@interface COMyHistoryTodayCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView  *horizonBreakView;
@property (nonatomic, strong) UIView  *topLineView;
@property (nonatomic, strong) UIView  *bottomLineView;

@end

@implementation COMyHistoryTodayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = innercardbackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.horizonBreakView];
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.bottomLineView];
        
        [self addUIConstriants];
    }
    
    return self;
}


+ (COMyHistoryTodayCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *strHistoryCell = @"historyTodayCell";
    
    COMyHistoryTodayCell *cell = [tableView dequeueReusableCellWithIdentifier:strHistoryCell];
    if(cell == nil)
    {
        cell = [[COMyHistoryTodayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strHistoryCell];
    }
    
    return cell;
}


+ (CGFloat)heightForCellModel:(COMyHistoryTodayModel *)model
{
    return  75;
}

#pragma mark lazy load

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if(_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc] init];
        
        _timeLabel.textColor = navigaterBarColor;
        _timeLabel.font = [UIFont systemFontOfSize:13.0];
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _timeLabel;
}

- (UIView *)horizonBreakView
{
    if(_horizonBreakView == nil)
    {
        _horizonBreakView = [[UIView alloc] init];
        _horizonBreakView.backgroundColor = [UIColor whiteColor];
    }
    
    return _horizonBreakView;
}

- (UIView *)topLineView
{
    if(_topLineView == nil)
    {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = cellbackgroundColor;
    }
    
    return _topLineView;
}

- (UIView *)bottomLineView
{
    if(_bottomLineView == nil)
    {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = cellbackgroundColor;
    }
    
    return _bottomLineView;
}


#pragma mark UI Layout

- (void)addUIConstriants
{
    CGFloat leftPadding = 15;
    CGFloat rightPadding = 15;
    CGFloat topPadding = 5;

    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(topPadding, leftPadding, 0, rightPadding));
        
        make.height.mas_equalTo(25);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(_timeLabel.mas_top);
        make.height.mas_equalTo(1.0);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_timeLabel.mas_left);
        make.top.equalTo(_timeLabel.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.mas_equalTo(1.0);
        
    }];
    
    [self.horizonBreakView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(_titleLabel.mas_bottom).offset(2);
        make.height.mas_equalTo(15);
    }];
}


#pragma mark 

- (void)setHistoryTodayModel:(COMyHistoryTodayModel *)historyTodayModel
{
    _historyTodayModel = historyTodayModel;
    
    self.timeLabel.text = [NSString replaceUnicode:historyTodayModel.timeStr];
    
    self.titleLabel.text = [NSString replaceUnicode:historyTodayModel.titleStr];
}


@end
