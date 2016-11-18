//
//  COUserSettingFootModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/11.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COUserSettingFootModel : NSObject

@property (nonatomic, strong)NSString *imageUrl;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
