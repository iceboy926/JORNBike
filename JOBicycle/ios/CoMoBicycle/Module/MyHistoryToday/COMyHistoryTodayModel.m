//
//  COMyHistoryTodayModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyHistoryTodayModel.h"

@implementation COMyHistoryTodayModel

- (instancetype)initWithDictionary:(NSDictionary *)dicresult
{
    self = [super init];
    if(self)
    {
        self.titleStr = dicresult[@"title"];
        self.timeStr = dicresult[@"date"];
        self.eidStr = dicresult[@"e_id"];
    }
    
    return self;
}

@end
