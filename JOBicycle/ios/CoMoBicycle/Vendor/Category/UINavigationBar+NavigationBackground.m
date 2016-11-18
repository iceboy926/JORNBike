//
//  UINavigationBar+NavigationBackground.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/11.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "UINavigationBar+NavigationBackground.h"
#import <objc/runtime.h>

static char navigationBar_BackgroundImage;

@implementation UINavigationBar (NavigationBackground)

- (UIImage *)navigationBarBackgroundImage
{
    return objc_getAssociatedObject(self, &navigationBar_BackgroundImage);
}

- (void)setNavigationBarBackgroundImage:(UIImage *)backgroundImage
{
    objc_setAssociatedObject(self, &navigationBar_BackgroundImage, backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)co_setbackgroundWithColor:(UIColor *)backgroundColor
{
    UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 64)];
    
    navBgView.backgroundColor = backgroundColor;
    
    [self setValue:navBgView forKey:@"backgroundView"];
    
}


@end
