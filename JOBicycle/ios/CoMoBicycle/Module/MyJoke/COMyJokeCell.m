//
//  COMyJokeCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyJokeCell.h"
#import "COMyJokeModel.h"

CGFloat jokeCellHeight = 0.0;

@interface COMyJokeCell()

@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *timeLabel;


@end

@implementation COMyJokeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.timeLabel];
        
        [self addUIConstriants];
    }
    
    return self;
}


#pragma mark UI layout
- (void)addUIConstriants
{
    NSInteger leftPadding = 15;
    NSInteger rightPadding = 15;
    NSInteger topPadding = 5;
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.right.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(topPadding, leftPadding, 0, rightPadding));
        
        make.height.mas_equalTo(40);

        jokeCellHeight = topPadding;
        
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_contentLabel.mas_right);
        make.width.mas_equalTo(100);
        make.top.equalTo(_contentLabel.mas_bottom);
        make.height.mas_equalTo(30);
        
        jokeCellHeight += 35;
    }];
    
    
}

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
        
    }
    
    return _timeLabel;
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

+ (CGFloat)heightForCell
{
    return jokeCellHeight;
}


#pragma mark member func

- (void)setJokeModel:(COMyJokeModel *)jokeModel
{
    _jokeModel = jokeModel;
    
    //set content str
    
    CGRect contentRect = [jokeModel.contentStr boundingRectWithSize:CGSizeMake(MAX_WIDTH - 30, MAX_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]} context:nil];

    
    [self updateUIConstraints:contentRect];
    
    self.contentLabel.text = jokeModel.contentStr;
    
    //set time str
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[jokeModel.unixtimeStr doubleValue]];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
    self.timeLabel.text = confromTimespStr;
}

- (void)updateUIConstraints:(CGRect )contentRect
{
    CGFloat contentHeight = contentRect.size.height;
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(contentHeight);
        
        jokeCellHeight += contentHeight;
    }];
    
    
}




@end
