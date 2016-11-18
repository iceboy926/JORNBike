//
//  COCollectionViewCell.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/9.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COResultInfo;
@interface COCollectionViewCell : UICollectionViewCell

- (void)configWithDataModel:(COResultInfo *)resultInfo;

@end
