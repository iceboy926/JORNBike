//
//  UIInitServer.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "UIInitServer.h"
#import "COMediator+COLoginRegistComponet.h"
#import "COMediator+COBikeMainComponet.h"
#import "COMediator+COUserSettingComponet.h"
#import "COBaseNavigationController.h"


@interface UIInitServer()



@end

@implementation UIInitServer

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // init interface load

    [self initWithApplication:application];
    
    [self addLauchImageWithApplication:application Image:[UIImage imageNamed:@"blurred_background"]];

    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
 
    FDRedLog(@"< iso9 source application");
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    FDRedLog(@" > ios9 open url options");
    
    return YES;
}


#pragma mark temp function

- (void)initWithApplication:(UIApplication *)application
{
    application.delegate.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootVC = nil;
    if([COAccount getAccount] == nil)
    {
        //登录界面
        UIViewController *loginVC = [[COMediator shareInstance] COLoginRegistComponet_LoginViewController];
        
        COBaseNavigationController *leftNavController = [[COBaseNavigationController alloc] initWithRootViewController:[[COMediator shareInstance] COUserSettingComponet_ViewController]];
        
        self.drawerController.centerViewController = loginVC;
        
        self.drawerController.leftDrawerViewController = leftNavController;
        
        rootVC = self.drawerController;
    }
    else
    {
        //主界面
        COBaseNavigationController *CenterNavController = [[COBaseNavigationController alloc] initWithRootViewController:[[COMediator shareInstance] COBikeComponet_ViewController]];
        self.drawerController.centerViewController = CenterNavController;
        
        COBaseNavigationController *leftNavController = [[COBaseNavigationController alloc] initWithRootViewController:[[COMediator shareInstance] COUserSettingComponet_ViewController]];
        
        self.drawerController.leftDrawerViewController = leftNavController;
        
    
        rootVC = self.drawerController;
    }
    
    application.delegate.window.rootViewController = rootVC;
    
    [application.delegate.window makeKeyAndVisible];
}

#pragma mark lauch image

- (void)addLauchImageWithApplication:(UIApplication *)application Image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = image;
    [application.delegate.window.rootViewController.view addSubview:imageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [UIView animateWithDuration:1.5 animations:^{
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            imageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
            
            imageView.alpha = 0;
            
        } completion:^(BOOL blfinished){
            
            [imageView removeFromSuperview];
            
        }];
    
    });
}

#pragma mark lazy load

- (MMDrawerController *)drawerController
{
    if(_drawerController == nil)
    {
        _drawerController = [[MMDrawerController alloc] init];
        
        [_drawerController setMaximumLeftDrawerWidth:WIDTH_TO_FIT(250)];
        [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

    }
    
    return _drawerController;
}


#pragma mark member function

- (void)toggleLeftView
{
    [self.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)closeLeftViewAnimated:(BOOL)animated completion:(void (^)(BOOL blfinised))completion
{
    [self.drawerController closeDrawerAnimated:animated completion:completion];
}

@end
