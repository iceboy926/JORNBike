//
//  COBaseNavigationBar.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COBMHeaderView : UIView

@property (nonatomic, copy) void (^leftbtnClickBlock)();

- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)initWithTitle:(NSString *)title HeaderImage:(NSData *)headData;

@end
