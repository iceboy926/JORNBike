//
//  ServiceComponent.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/28.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaiduMapServer.h"
#import "UIInitServer.h"
#import "SMSServer.h"

@interface ServiceComponent : NSObject

+(instancetype)shareInstance;

- (NSMutableArray *)services;

@end
