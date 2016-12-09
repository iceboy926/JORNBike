//
//  SMSServer.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/9.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "SMSServer.h"

@interface SMSServer()

@end

@implementation SMSServer

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    
    [SMSSDK registerApp:SMS_APPKEY withSecret:SMS_APPSECRET];
    
    return YES;
}

@end
