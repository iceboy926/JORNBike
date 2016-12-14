//
//  COMediator+COMyHistoryTodayComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COMyHistoryTodayComponet.h"

#define MyHistoryToday_Target @"COMyHistoryTodayComponet"
#define MyHistoryToday_Action @"MyHistoryTodayViewController"

@implementation COMediator (COMyHistoryTodayComponet)

- (UIViewController *)COMyHistoryTodayComponet_ViewController
{
    UIViewController *viewcontroller = [self performTarget:MyHistoryToday_Target action:MyHistoryToday_Action params:nil];
    
    if(viewcontroller == nil)
    {
        return viewcontroller;
    }
    else
    {
        return [[UIViewController alloc] init];
    }
}

@end
