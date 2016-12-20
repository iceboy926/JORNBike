//
//  COMyJokeCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyJokeCell.h"
#import "COMyJokeModel.h"


@interface COMyJokeCell()

@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIView *horizonLineView;


@end

@implementation COMyJokeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.horizonLineView];
    }
    
    return self;
}


#pragma mark UI layout
//- (void)addUIConstriants
//{
//    NSInteger leftPadding = 15;
//    NSInteger rightPadding = 15;
//    NSInteger topPadding = 5;
//    
//    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//    
//        make.left.right.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(topPadding, leftPadding, 0, rightPadding));
//        
//        make.height.mas_equalTo(40);
//        
//    }];
//    
//    
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.equalTo(_contentLabel.mas_right);
//        make.width.mas_equalTo(200);
//        make.top.equalTo(_contentLabel.mas_bottom);
//        make.height.mas_equalTo(30);
//        
//    }];
//    
//    
//}

#pragma mark lazy load

- (UILabel *)contentLabel
{
    if(_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _contentLabel.font = [UIFont systemFontOfSize:15.0];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel
{
    if(_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _timeLabel.font = [UIFont systemFontOfSize:14.0];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
    }
    
    return _timeLabel;
}

- (UIView *)horizonLineView
{
    if(_horizonLineView == nil)
    {
        _horizonLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _horizonLineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    
    return _horizonLineView;
}


+ (COMyJokeCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *jokeCellIdentifier = @"jokecell";
    
    COMyJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:jokeCellIdentifier];
    if(cell == nil)
    {
        cell = [[COMyJokeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jokeCellIdentifier];
    }
    
    return cell;
}

+ (CGFloat)heightForCellModel:(COMyJokeModel *)jokeModel
{
    CGFloat  jokeHeight = 5;
    
     CGRect contentRect = [jokeModel.contentStr boundingRectWithSize:CGSizeMake(MAX_WIDTH - 30, MAX_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]} context:nil];
    

    jokeHeight += contentRect.size.height + 5;
    
    jokeHeight += 35;
    
    NSLog(@"jokeheight is %f", jokeHeight);
    
    return jokeHeight;
    
}


#pragma mark member func

- (void)setJokeModel:(COMyJokeModel *)jokeModel
{
    _jokeModel = jokeModel;
    
    //set content str
    CGRect contentRect = [jokeModel.contentStr boundingRectWithSize:CGSizeMake(MAX_WIDTH - 30, MAX_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]} context:nil];
    

    
    [self updateUIConstraintsWithSize:contentRect.size];
   
    self.contentLabel.text = jokeModel.contentStr;
    
    //set time str
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[jokeModel.unixtimeStr doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    self.timeLabel.text = confromTimespStr;
}

- (void)updateUIConstraintsWithSize:(CGSize)size
{
    NSInteger leftPadding = 15;
    NSInteger rightPadding = 15;
    NSInteger topPadding = 5;
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(leftPadding);
        make.right.equalTo(self.contentView.mas_right).offset(-rightPadding);
        make.top.equalTo(self.contentView.mas_top).offset(topPadding);
        
        make.height.mas_equalTo(size.height + 5);
        
    }];
    
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_contentLabel.mas_right);
        make.width.mas_equalTo(200);
        make.top.equalTo(_contentLabel.mas_bottom);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.horizonLineView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_contentLabel.mas_left);
        make.right.equalTo(_contentLabel.mas_right);
        make.top.equalTo(_timeLabel.mas_bottom).offset(2);
        make.height.mas_equalTo(1.0);
        
    }];
}



@end
