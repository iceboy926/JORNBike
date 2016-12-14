//
//  COMediator+COMyAblumComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COMyWXCollectionComponet.h"

#define MyAlbum_Target  @"COMyWXCollectionComponet"
#define MyAlbum_Action  @"MyWXCollectionViewController"

@implementation COMediator (COMyWXCollectionComponet)

- (UIViewController *)COMyWXCollectionComponet_ViewController
{
    UIViewController *viewcontroller = [self performTarget:MyAlbum_Target action:MyAlbum_Action params:nil];
    
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
