//
//  COUserSettingHeadModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/8.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingHeadModel.h"

@implementation COUserSettingHeadModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        self.headImageUrl = dic[@"image"];
        self.titleStr = [NSString replaceUnicode:dic[@"title"]];
        self.descriptionStr = [NSString replaceUnicode:dic[@"description"]];
    }
    
    return self;
}

@end
