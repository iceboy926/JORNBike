//
//  COForgetViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COForgetViewModel.h"

@implementation COForgetViewModel


+ (instancetype)shareInstance
{
    static COForgetViewModel *myInstance =nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
    
        if(myInstance == nil)
        {
            myInstance = [[COForgetViewModel alloc] init];
        }
    
    });
    
    return myInstance;
}

- (void)forgetStart
{
    if([[self.username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
        self.invalidMsg = @"请输入手机号码";
        self.invalid = @NO;
        return ;
    }
    
    if(![self.authStatus boolValue])
    {
        self.invalidMsg = @"验证码不正确";
        self.invalid = @NO;
        return ;
    }
    else
    {
        self.invalid = @YES;
    }
}


- (void)forgetNext
{
    if([[self.username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [[self.smsCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
        self.invalidMsg = @"请输入手机号码或短信验证码";
        self.invalid = @NO;
        return ;
    }
    
    
    [SMSSDK commitVerificationCode:self.smsCode phoneNumber:self.username zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
       
        if(!error)
        {
            self.invalid = @YES;
        }
        else
        {
            self.invalidMsg = @"短信验证码错误";
            self.invalid = @NO;
        }
        
    }];
}

- (void)forgetEnd
{
    if([[self.password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [[self.repeatPSD stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
        self.invalidMsg = @"请输入密码";
        self.invalid = @YES;
        
        return ;
    }
    
    if(![self.password isEqualToString:self.repeatPSD])
    {
        self.invalidMsg = @"两次输入的密码不相同";
        self.invalid = @YES;
    }
    else
    {
        NSDictionary *dicParams = @{@"user": self.username, @"psd":[self.password md5]};
        
        [httpRequest requestWithURLString:API_URL_FORGETPSD parameters:nil type:HttpRequestTypeGet success:^(id responseObject) {
        
            if(responseObject[@"success"])
            {
                if([responseObject[@"success"] intValue] == 0)
                {
                    self.invalidMsg = @"重置密码失败";
                    self.finishedStatus = @NO;
                }
                else
                {
                    self.finishedStatus = @YES;
                }
            }
            else
            {
                self.invalidMsg = @"重置密码失败";
                self.finishedStatus = @NO;
            }
            
        } failure:^(NSError *error){
        
            self.invalidMsg = @"请检查网络连接";
            self.netStatus = @YES;
        
        }];
        
        
    }
    
}

@end
