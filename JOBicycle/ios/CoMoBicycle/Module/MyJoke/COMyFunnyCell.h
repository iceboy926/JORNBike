//
//  COMyFunnyCell.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COMyJokeModel, UITableView;

@interface COMyFunnyCell : UITableViewCell

@property (nonatomic, strong)COMyJokeModel *funnyModel;

+ (COMyFunnyCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)heightForCellModel:(COMyJokeModel *)funnyModel;

@end
