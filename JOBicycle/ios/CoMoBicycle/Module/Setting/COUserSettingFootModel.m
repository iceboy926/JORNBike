//
//  COUserSettingFootModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/11.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingFootModel.h"

@implementation COUserSettingFootModel


- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        self.imageUrl = dic[@"image"];
    }
    
    return self;
}

@end
