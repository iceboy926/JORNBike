//
//  COMyHistoryTodayCell.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COMyHistoryTodayModel;

@interface COMyHistoryTodayCell : UITableViewCell

@property (nonatomic, strong) COMyHistoryTodayModel *historyTodayModel;

+ (COMyHistoryTodayCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)heightForCellModel:(COMyHistoryTodayModel *)model;

@end
