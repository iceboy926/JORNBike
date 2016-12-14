//
//  COMyWXCollectionModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyWXCollectionModel.h"

@implementation COMyWXCollectionModel


- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        self.titleStr = dic[@"title"];
        self.sourceStr = dic[@"source"];
        self.imageUrlStr = dic[@"firstImg"];
        self.collectionUrlStr = dic[@"url"];
        self.timeStr = dic[@"id"];
    }
    
    return self;
}

@end
