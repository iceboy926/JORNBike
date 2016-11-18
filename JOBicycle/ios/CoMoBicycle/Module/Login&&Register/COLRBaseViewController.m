//
//  COBaseViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#define DURATION 0.7f

#import "COLRBaseViewController.h"

@interface COLRBaseViewController()

@end

@implementation COLRBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = backGroundColor;
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

- (void)showInfoStatus:(NSString *)strMsg
{
    [SVProgressHUD showInfoWithStatus:strMsg];
}

- (void)showWaitStatus:(NSString *)strMsg
{
    [SVProgressHUD showWithStatus:strMsg];
}

- (void)hideWait
{
    [SVProgressHUD dismiss];
}

- (void)addPresentAnimation
{
    CATransition *animation = [CATransition animation];
    animation.duration = DURATION;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
}

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)presentNewViewAnimation
{
    [self transitionWithType:kCATransitionPush WithSubtype:kCATransitionFromRight ForView:self.view.window];
}

- (void)dismissOldViewAnimation
{
    [self transitionWithType:kCATransitionPush WithSubtype:kCATransitionFromLeft ForView:self.view.window];
}

@end
