//
//  COMyJokeModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyJokeModel.h"

@implementation COMyJokeModel


- (instancetype)initWithDictionary:(NSDictionary *)dicResult
{
    self = [super init];
    if(self)
    {
        self.contentStr = dicResult[@"content"];
        self.unixtimeStr = dicResult[@"unixtime"];
        if(dicResult[@"url"] == nil)
        {
            self.blJoke = NO;
        }
        else
        {
            self.blJoke = YES;
            self.imageURL = dicResult[@"url"];
        }
    }
    
    return self;
}

@end
