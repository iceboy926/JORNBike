//
//  COMyFavorCellModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyFavorCellModel.h"

@implementation COMyFavorCellModel

- (instancetype)initWithDictionary:(NSDictionary *)dicRes
{
    self = [super init];
    if(self)
    {
        self.strHeadImageUrl = dicRes[@"headimage"];
        self.strTitle = [NSString replaceUnicode:dicRes[@"title"]];
        self.strContentImageUrl = dicRes[@"contentimage"];
        self.strContentDescript = dicRes[@"contentdescript"];
        self.strContentTip = dicRes[@"contentTip"];
        self.strTime = dicRes[@"time"];
    }
    
    return self;
}

@end
