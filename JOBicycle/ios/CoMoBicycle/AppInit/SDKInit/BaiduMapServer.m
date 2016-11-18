//
//  BaiduMapServer.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/28.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "BaiduMapServer.h"

@interface BaiduMapServer() <BMKGeneralDelegate>

@property (nonatomic, strong) BMKMapManager *bmmanager;

@end

@implementation BaiduMapServer

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.bmmanager = [[BMKMapManager alloc] init];
    
    [self.bmmanager start:BAIDUMAP_SK generalDelegate:self];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    [BMKMapView willBackGround];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    [BMKMapView didForeGround];
}


#pragma mark BMKGenenral Delegate

/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError
{
    if(iError == 0)
    {
        NSLog(@"connect network ok");
    }
    else
    {
        NSLog(@"Ge network state: %d", iError);
    }
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError
{
    NSLog(@"Get Permission state is %d", iError);
}


@end
