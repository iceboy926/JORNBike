//
//  COUserSettingFootViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/11.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingFootViewModel.h"


@implementation COUserSettingFootViewModel


- (void)fetchUserSettingFootDataWithCallBack:(void (^)(id response))completion
{
    NSDictionary *account = [COAccount getAccount];
    
    NSDictionary *dicParams = @{@"username": account[@"username"], @"usertoken": account[@"usertoken"]};
    
    [httpRequest requestWithURLString:API_URL_USERSETTING parameters:nil type:HttpRequestTypeGet success:^(id response){
    
        if(response)
        {
            NSDictionary *dicResult = response[@"footSetting"];
            
            if(completion)
            {
                completion(dicResult);
            }
        }
        
    } failure:^(NSError *error){
    
        NSDictionary *dic = [self fetchUserSettingPlistValue];
        if(dic)
        {
            NSDictionary *dicResult = dic[@"footSetting"];
            if(completion)
            {
                completion(dicResult);
            }
        }
    
    }];
}

- (NSMutableDictionary *)fetchUserSettingPlistValue
{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserSetting" ofType:@"plist"];
    
    NSMutableDictionary *userSettingDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    return userSettingDic;
}

@end
