//
//  COMediator+COMyZoneComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COMyZoneComponet.h"

#define MyZone_Target   @"COMyZoneComponet"
#define MyZone_Action   @"MyZoneViewController"

@implementation COMediator (COMyZoneComponet)

- (UIViewController *)COMyZoneComponet_ViewController
{
    UIViewController *viewcontroller = [self performTarget:MyZone_Target action:MyZone_Action params:nil];
    
    if([viewcontroller isKindOfClass:[UIViewController class]])
    {
        return viewcontroller;
    }
    else
    {
        return [[UIViewController alloc] init];
    }
}

@end
