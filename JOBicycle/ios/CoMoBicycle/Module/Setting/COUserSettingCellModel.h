//
//  COUserSettingCellModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/4.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COUserSettingCellModel : NSObject

@property (nonatomic, strong) NSString *headimageStr;

@property (nonatomic, strong) NSString *headTitle;

@property (nonatomic, strong) NSString *subimageStr;

- (id)initWithDictionary:(NSDictionary *)objDic;

@end
