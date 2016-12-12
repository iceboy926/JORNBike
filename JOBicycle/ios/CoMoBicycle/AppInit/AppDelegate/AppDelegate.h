//
//  AppDelegate.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong)UIViewController *rootNavigationController;


+ (AppDelegate *)globalDelegate;

- (void)openDrawleft;

- (void)closeDrawleft;

- (void)showMainPage;

@end

