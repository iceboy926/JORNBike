//
//  COMediator+COBikeMainComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COBikeMainComponet.h"

#define Main_Target @"COBikeMainComponet"
#define Main_Action @"BikeMainViewController"

@implementation COMediator (COBikeMainComponet)

- (UIViewController *)COBikeComponet_ViewController
{
    UIViewController *viewController = [self performTarget:Main_Target action:Main_Action params:nil];
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
