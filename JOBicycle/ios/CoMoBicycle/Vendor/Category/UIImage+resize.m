//
//  UIImage+resize.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/3.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "UIImage+resize.h"

@implementation UIImage (resize)

+ (UIImage* )imageWithImage:(UIImage *)image ScaleSize:(CGSize)newsize
{
    UIGraphicsBeginImageContext(newsize);
    [image drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
