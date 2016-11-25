//
//  AppDelegate.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "AppDelegate.h"
#import "ServiceComponent.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    id<UIApplicationDelegate> service;
    
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
        {
            [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    id<UIApplicationDelegate> service;
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service respondsToSelector:@selector(applicationWillResignActive:)])
        {
            [service applicationWillResignActive:application];
        }
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    id<UIApplicationDelegate> service;
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service respondsToSelector:@selector(applicationDidEnterBackground:)])
        {
            [service applicationDidEnterBackground:application];
        }
    }
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    id<UIApplicationDelegate> service;
    
    for (service in [[ServiceComponent shareInstance] services]) {
    
        if([service respondsToSelector:@selector(applicationWillEnterForeground:)])
        {
            [service applicationWillEnterForeground:application];
        }
    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    id<UIApplicationDelegate> service;
    
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service respondsToSelector:@selector(applicationDidBecomeActive:)])
        {
            [service applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    id<UIApplicationDelegate> service;
    for (service in [[ServiceComponent shareInstance] services]) {
        if ([service respondsToSelector:@selector(applicationWillTerminate:)]) {
            
            [service applicationWillTerminate:application];
        }
    }

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
    id<UIApplicationDelegate> service;
    for(service in[[ServiceComponent shareInstance] services])
    {
        if([service respondsToSelector:@selector(application:openURL:options:)])
        {
            return [service application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
        
    }
    
    return NO;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    id<UIApplicationDelegate> service;
    for(service in[[ServiceComponent shareInstance] services])
    {
        if([service respondsToSelector:@selector(application:openURL:options:)])
        {
            return [service application:app openURL:url options:options];
        }
        
    }
    
    return NO;
}


#pragma mark member function

+ (AppDelegate *)globalDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)openDrawleft
{
    id<UIApplicationDelegate> service;
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service isKindOfClass:[UIInitServer class]])
        {
            [(UIInitServer *)service toggleLeftView];
        }
    }
}

- (void)closeDrawleft
{
    id<UIApplicationDelegate> service;
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service isKindOfClass:[UIInitServer class]])
        {
            [(UIInitServer *)service closeLeftViewAnimated:NO completion:nil];
        }
    }
}

- (UINavigationController *)rootNavigationController
{
    id<UIApplicationDelegate> service;
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service isKindOfClass:[UIInitServer class]])
        {
            MMDrawerController *drawerController = [(UIInitServer *)service drawerController];
            
            return (UINavigationController *)drawerController.centerViewController;
        }
    }

    return nil;
}

- (void)setRootNavigationController:(UINavigationController *)rootNavigationController
{
    id<UIApplicationDelegate> service;
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service isKindOfClass:[UIInitServer class]])
        {
            MMDrawerController *drawerController = [(UIInitServer *)service drawerController];
            
            drawerController.centerViewController = rootNavigationController;
        }
    }

}

- (void)showMainPage
{
    id<UIApplicationDelegate> service;
    for (service in [[ServiceComponent shareInstance] services]) {
        if([service isKindOfClass:[UIInitServer class]])
        {
            MMDrawerController *drawerController = [(UIInitServer *)service drawerController];
            
            self.window.rootViewController = drawerController;
            
            [self.window makeKeyAndVisible];

        }
    }

}

@end
