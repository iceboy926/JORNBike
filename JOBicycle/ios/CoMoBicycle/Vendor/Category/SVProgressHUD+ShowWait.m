//
//  SVProgressHUD+ShowWait.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "SVProgressHUD+ShowWait.h"

@implementation SVProgressHUD (ShowWait)

+ (void)ShowWaitMsg:(NSString *)strMsg
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

    [SVProgressHUD showWithStatus:strMsg];
}

+ (void)hideWait
{
    
    [SVProgressHUD dismiss];
}

@end
