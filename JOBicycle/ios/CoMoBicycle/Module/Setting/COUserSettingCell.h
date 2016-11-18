//
//  COSettingCell.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/4.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingCellModel.h"

@interface COUserSettingCell : UITableViewCell

@property (nonatomic, strong) COUserSettingCellModel *cellModel;

+(instancetype)cellWithTableView:(UITableView *)tableview;

+(CGFloat)heightForCell;

@end
