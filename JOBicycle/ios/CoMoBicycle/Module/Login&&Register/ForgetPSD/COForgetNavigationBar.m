//
//  COForgetNavigationBar.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COForgetNavigationBar.h"

@interface COForgetNavigationBar()

@end

@implementation COForgetNavigationBar

- (instancetype)initWithTitle:(NSString *)strTitle
{
    self = [super init];
    if(self)
    {
        [self setTitleStr:strTitle];
    }
    
    return self;
}

@end
