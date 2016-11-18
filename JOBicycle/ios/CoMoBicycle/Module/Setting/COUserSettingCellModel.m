//
//  COUserSettingCellModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/4.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingCellModel.h"

@implementation COUserSettingCellModel


- (id)initWithDictionary:(NSDictionary *)objDic
{
    self = [super init];
    if(self)
    {
        self.headimageStr = objDic[@"headimage"];
        self.headTitle = [NSString replaceUnicode:(NSString *)objDic[@"headtitle"]];
        self.subimageStr = objDic[@"subimage"];
    }
    
    return self;
}

@end
