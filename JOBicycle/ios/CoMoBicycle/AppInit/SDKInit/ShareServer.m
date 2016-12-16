//
//  ShareServer.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/16.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "ShareServer.h"

@interface ShareServer() <WeiboSDKDelegate>

@end

@implementation ShareServer


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    
    [ShareSDK registerApp:Share_AppKey activePlatforms:@[@(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
                
            case SSDKPlatformTypeWechat:
                
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            default:
                
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType) {
                
            case SSDKPlatformTypeSinaWeibo: {
    
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:SinaWeiBo_AppKey
                                          appSecret:SinaWeiBo_AppSecret
                                        redirectUri:SinaWeiBo_redirectUri
                                           authType:SSDKAuthTypeBoth];
                break;
            }
            
            case SSDKPlatformTypeWechat:{
                
                
                break;
            }
                
            case SSDKPlatformTypeQQ:{
                
                break;
            }
                
    
            default:
                
                break;
        }
        
    }];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)
sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}


/**
 *
 */

/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    
}




@end
