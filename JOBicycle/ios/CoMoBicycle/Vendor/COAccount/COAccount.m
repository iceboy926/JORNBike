//
//  COAccount.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COAccount.h"
@implementation COAccount


+ (void)saveAccount:(NSDictionary *)account{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //保存数据 用户信息MD5；用户名；用户密码的hash值
    [userDefaults setObject:account  forKey:@"Account" ];
    NSString *username = account[@"username"];
    NSString *usertoken = account[@"usertoken"];
    NSNumber *islogin = account[@"logstatus"];
    
    [userDefaults setObject:username  forKey:@"username" ];
    [userDefaults setObject:usertoken forKey:@"usertoken"];
    [userDefaults setObject:islogin forKey:@"logstatus"];
    
    
    [userDefaults synchronize];
};


+ (NSDictionary *)getAccount{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:@"Account"];
    return dic;
};

+(void)DeleteAcount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"Account"];
    
    [userDefaults synchronize];
}

@end
