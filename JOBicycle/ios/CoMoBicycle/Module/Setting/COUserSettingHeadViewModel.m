//
//  COUserSettingHeadViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/8.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingHeadViewModel.h"

@interface COUserSettingHeadViewModel()

@end

@implementation COUserSettingHeadViewModel


- (void)fetchUserSettingHeadDataWithCallBack:(void (^)(id response))completion
{
    NSDictionary *accout = [COAccount getAccount];
    if(accout)
    {
        NSDictionary *dicParams = @{@"username": accout[@"username"], @"usertoken": accout[@"usertoken"]};
        
        [httpRequest requestWithURLString:API_URL_USERSETTING parameters:nil type:HttpRequestTypeGet success:^(id response){
        
            if(response)
            {
                NSDictionary *dicResult = response[@"headSetting"];
                if(dicResult)
                {
                    completion(dicResult);
                }
            }
            
        } failure:^(NSError *error){
        
            NSDictionary *dic = [self fetchUserSettingPlistValue];
        
            if(dic)
            {
                NSDictionary *headDic = dic[@"headSetting"];
                if(headDic)
                {
                    completion(headDic);
                }
            }
            
        }];
        
    }
    
}

- (NSMutableDictionary *)fetchUserSettingPlistValue
{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserSetting" ofType:@"plist"];
    
    NSMutableDictionary *userSettingDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    return userSettingDic;
}


@end
