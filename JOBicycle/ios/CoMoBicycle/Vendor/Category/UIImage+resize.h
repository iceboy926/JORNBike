//
//  UIImage+resize.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/3.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (resize)

+ (UIImage* )imageWithImage:(UIImage *)image ScaleSize:(CGSize)newsize;

-(UIImage *)drawRectWithRounderCorner:(CGFloat) radius  WithSize:(CGSize) size;

@end
