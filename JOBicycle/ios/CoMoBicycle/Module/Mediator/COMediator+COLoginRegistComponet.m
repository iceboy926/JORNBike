//
//  COMediator+COLoginComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COLoginRegistComponet.h"

#define LoginRegist_Target @"COLoginRegistComponet"
#define Login_Action @"LoginViewController"
#define Regist_Action @"RegistViewController"
#define ForgetPSD_Action @"ForgetPSDViewController"


@implementation COMediator (COLoginRegistComponet)

- (UIViewController *)COLoginRegistComponet_LoginViewController
{
    UIViewController *viewController = [self performTarget:LoginRegist_Target action:Login_Action params:nil];
    if([viewController isKindOfClass:[UIViewController class]])
    {
        return viewController;
    }
    else
    {
        return [[UIViewController alloc] init];
    }
}

- (UIViewController *)COLoginRegistComponet_RegistViewController
{
    UIViewController *viewController = [self performTarget:LoginRegist_Target action:Regist_Action params:nil];
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
