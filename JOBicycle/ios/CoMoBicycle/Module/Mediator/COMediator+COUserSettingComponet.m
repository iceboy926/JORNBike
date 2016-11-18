//
//  COMediator+COUserSettingComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/3.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COUserSettingComponet.h"

#define Setting_Target @"COUserSettingComponet"
#define Setting_Action @"UserSettingViewController"

@implementation COMediator (COUserSettingComponet)

- (UIViewController *)COUserSettingComponet_ViewController
{
    UIViewController *viewController = [self performTarget:Setting_Target action:Setting_Action params:nil];
    
    if([viewController isKindOfClass:[UIViewController class]])
    {
        return viewController;
    }
    else
    {
        return [[UIViewController alloc] init];
    }
    
}

@end
