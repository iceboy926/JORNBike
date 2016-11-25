//
//  UIView+CirecleView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "UIImageView+CirecleView.h"

@implementation UIImageView (CirecleView)

- (void)addCorner:(CGFloat) radius
{
    self.image = [self.image drawRectWithRounderCorner:radius WithSize:self.bounds.size];
}

@end
