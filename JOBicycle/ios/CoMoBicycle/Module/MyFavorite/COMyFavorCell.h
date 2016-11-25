//
//  COMyFavorCell.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COMyFavorCellModel;

@interface COMyFavorCell : UITableViewCell

@property (nonatomic, strong) COMyFavorCellModel *cellModel;

+(instancetype)cellWithTableView:(UITableView *)tableview;

+(CGFloat)heightForCell;

@end
