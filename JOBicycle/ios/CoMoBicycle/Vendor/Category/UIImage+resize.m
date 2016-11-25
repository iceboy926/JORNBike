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

-(UIImage *)circleImage
{
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;

}

-(UIImage *)drawRectWithRounderCorner:(CGFloat) radius  WithSize:(CGSize) size
{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(),kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return output;
}

@end
