//
//  COMyWXCollectionCell.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COMyWXCollectionModel;

@interface COMyWXCollectionCell : UITableViewCell

@property (nonatomic, strong)COMyWXCollectionModel *collectionModel;

+(instancetype)cellWithTableView:(UITableView *)tableview;

+(CGFloat)heightForCollectionCell;

@end
