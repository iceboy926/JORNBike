//
//  UIView+Helper.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

- (void)addCorner:(CGFloat) radius
{
    UIImage *image = [UIImage new];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[image drawRectWithRounderCorner:radius WithSize:self.bounds.size]];
    
    [self insertSubview:imageView atIndex:0];
}

@end
