//
//  COMediator+COMyJokeComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/16.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COMyJokeComponet.h"

#define MyJoke_Target   @"COMyJokeComponet"
#define MyJoke_Action   @"MyJokeViewController"

@implementation COMediator (COMyJokeComponet)

- (UIViewController *)COMyJokeComponet_ViewController
{
    UIViewController *viewcontroller = [self performTarget:MyJoke_Target action:MyJoke_Action params:nil];
    
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
