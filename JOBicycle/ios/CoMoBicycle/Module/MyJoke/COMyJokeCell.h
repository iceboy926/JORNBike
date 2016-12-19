//
//  COMyJokeCell.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COMyJokeModel, UITableView;

@interface COMyJokeCell : UITableViewCell

@property (nonatomic, strong) COMyJokeModel *jokeModel;

+ (COMyJokeCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)heightForCell;


@end
