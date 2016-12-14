//
//  COMediator+COMyFolderComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COMyNewsTopComponet.h"

#define MyNewsTop_Target     @"COMyNewsTopComponet"
#define MyNewsTop_Action     @"MyNewsTopViewController"

@implementation COMediator (COMyNewsTopComponet)

- (UIViewController *)COMyNewsTopComponet_ViewController
{
    UIViewController *viewcontroller = [self performTarget:MyNewsTop_Target action:MyNewsTop_Action params:nil];
    
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
