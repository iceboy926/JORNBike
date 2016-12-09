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
        self.settingImageUrl = dic[@"settingimage"];
        self.settingTitleStr = dic[@"settingtitle"];
        self.quitImageUrl = dic[@"quitimage"];
        self.quitTitleStr = dic[@"quittitle"];
    }
    
    return self;
}

@end
