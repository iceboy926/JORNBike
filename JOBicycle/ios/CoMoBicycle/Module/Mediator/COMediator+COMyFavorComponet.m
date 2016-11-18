//
//  COMediator+COMyFavorComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COMyFavorComponet.h"

#define MyFavor_Target  @"COMyFavorComponet"
#define MyFavor_Action  @"MyFavorViewController"

@implementation COMediator (COMyFavorComponet)

- (UIViewController *)COMyFavorComponet_ViewController
{
    UIViewController *viewcontroller = [self performTarget:MyFavor_Target action:MyFavor_Action params:nil];
    
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
