//
//  COLoginComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COLoginRegistComponet.h"
#import "COLoginViewController.h"
#import "CORegisterStartViewController.h"
#import "COForgetPSDStartViewController.h"

@implementation COLoginRegistComponet

-(UIViewController *)LoginViewController
{
    COLoginViewController *coLogin = [[COLoginViewController alloc] init];
    
    return coLogin;
}

- (UIViewController *)RegistViewController
{
    CORegisterStartViewController *coRegist = [[CORegisterStartViewController alloc] init];
    
    return coRegist;
}

- (UIViewController *)ForgetPSDViewController
{
    COForgetPSDStartViewController *coForget = [[COForgetPSDStartViewController alloc] init];
    
    return coForget;
}

@end
