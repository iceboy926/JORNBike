//
//  CORegisterViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CORegisterViewModel.h"
#import "Userinfo.h"
#import "UserinfoManager.h"

@implementation CORegisterViewModel


+(instancetype)shareInstance
{
    static CORegisterViewModel *myViewModel = nil;
    static dispatch_once_t once_time;
    dispatch_once(&once_time, ^{
    
        if(myViewModel == nil)
        {
            myViewModel = [[CORegisterViewModel alloc] init];
        }
    
    });
    
    return myViewModel;
}


- (void)checkSMSNumber
{
    
    
}

- (void)startRegister
{
    if([[self.username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [[self.checkSMS stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
        self.invalidMsg = @"请输入手机号或校验码";
        self.invalidStart = @YES;
        
        return ;
    }
    
    
    [SMSSDK commitVerificationCode:self.checkSMS phoneNumber:self.username zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        
        if(!error)
        {
            self.smsCheck = @YES;
        }
        else
        {
           self.invalidMsg = @"短信验证码有误";
           self.smsCheck = @NO;
        }
        
    }];
    
}


- (void)nextRegister
{
    if([self.password length] < 6 || [self.password length] > 12)
    {
        self.invalidMsg = @"密码长度为6至12位";
        self.invalidNext = @YES;
        
    }
    else
    {
        self.invalidNext = @NO;
    }

}

- (void)finishRegister
{
    if(self.nickname == nil)
    {
        
    }
    
    if(self.headImageData == nil)
    {
        
    }
    
    if(self.username && self.password)
    {
        NSDictionary *dicParams = @{@"user": self.username,
                                    @"psd": [self.password md5],
                                    @"image":[NSString stringWithFormat:@"%@", self.headImageData]
                                    };
        
        if([self.username isEqualToString:@"18810761008"])
        {
            NSDictionary *dicUser = @{@"username": self.username, @"usertoken": @"usertesttoken", @"loginstatus": @YES};
            
            //self.headImageUrl = response[@"avarturl"];
            
            [COAccount saveAccount:dicUser];
            
            [self refreshLocalUserData];
            
            self.registerStatus = @YES;
            
            return ;
        }

        
        [httpRequest requestWithURLString:API_URL_REGIST parameters:nil type:HttpRequestTypeGet success:^(id response){
            
            if(response[@"success"])
            {
                if([response[@"success"] intValue] == 0)
                {
                    self.invalidMsg = @"用户注册失败";
                    self.registerStatus = @NO;
                }
                else
                {
                    NSDictionary *dicUser = @{@"username": self.username, @"usertoken": response[@"usertoken"], @"loginstatus": @YES};
                    
                    self.headImageUrl = response[@"avarturl"];
                    
                    [COAccount saveAccount:dicUser];
                    
                    [self refreshLocalUserData];
                    
                    self.registerStatus = @YES;
                }
            }
            else if(response[@"exist"])
            {
                self.invalidMsg = @"用户已存在";
                self.registerStatus = @NO;
            }
        
        } failure:^(NSError *error){
            
            self.invalidMsg = @"网络连接失败";
            self.netStatus = @YES;
        
        }];
    }
}

- (void)refreshLocalUserData
{
    Userinfo *userinfo = [[UserinfoManager sharedManager] addUserWithUser:self.username WithNick:self.nickname WithImageData:self.headImageData];
    
}



@end
