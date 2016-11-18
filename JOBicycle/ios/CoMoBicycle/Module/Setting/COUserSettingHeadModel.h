//
//  COUserSettingHeadModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/8.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COUserSettingHeadModel : NSObject

@property (nonatomic, strong)NSString *headImageUrl;

@property (nonatomic, strong)NSString *titleStr;

@property (nonatomic, strong)NSString *descriptionStr;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
