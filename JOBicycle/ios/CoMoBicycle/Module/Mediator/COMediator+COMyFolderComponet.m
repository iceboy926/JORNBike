//
//  COMediator+COMyFolderComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COMyFolderComponet.h"

#define MyFolder_Target     @"COMyFolderComponet"
#define MyFolder_Action     @"MyFolderViewController"

@implementation COMediator (COMyFolderComponet)

- (UIViewController *)COMyFolderComponet_ViewController
{
    UIViewController *viewcontroller = [self performTarget:MyFolder_Target action:MyFolder_Action params:nil];
    
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
