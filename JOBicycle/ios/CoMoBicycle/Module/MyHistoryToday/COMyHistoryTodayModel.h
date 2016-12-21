//
//  COMyHistoryTodayModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COMyHistoryTodayModel : NSObject

@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong)NSString *timeStr;
@property (nonatomic, strong)NSString *eidStr;

- (instancetype)initWithDictionary:(NSDictionary *)dicresult;

@end
