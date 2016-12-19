//
//  COMyFunnyCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyFunnyCell.h"
#import "COMyJokeModel.h"

CGFloat heightFunnyCell = 0.0f;

@interface COMyFunnyCell()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *funnyImageView;

@end


@implementation COMyFunnyCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
    }
    
    return self;
}

+ (COMyFunnyCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifierStr = @"funnycell";
    
    COMyFunnyCell *funnycell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierStr];
    if(funnycell == nil)
    {
        funnycell = [[COMyFunnyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierStr];
    }
    
    return funnycell;
}

+ (CGFloat)heightForCell
{
    return heightFunnyCell;
}

@end
