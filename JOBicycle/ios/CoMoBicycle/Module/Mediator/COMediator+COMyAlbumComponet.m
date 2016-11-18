//
//  COMediator+COMyAblumComponet.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMediator+COMyAlbumComponet.h"

#define MyAlbum_Target  @"COMyAlbumComponet"
#define MyAlbum_Action  @"MyAlbumViewController"

@implementation COMediator (COMyAlbumComponet)

- (UIViewController *)COMyAlbumComponet_ViewController
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
