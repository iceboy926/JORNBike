//
//  NetWorkServer.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/4.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "NetWorkServer.h"

@interface NetWorkServer()

@property (nonatomic, strong)Reachability *intentreach;

@end

@implementation NetWorkServer

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.intentreach = [Reachability reachabilityForInternetConnection];
    
    [self.intentreach startNotifier];
    
    return YES;
}


- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *currentReach = [notification object];
    
    if([currentReach isKindOfClass:[Reachability class]])
    {
        NetworkStatus status = [currentReach currentReachabilityStatus];
        
        NSLog(@"current networkstatus is %lu", status);
    }
    
    NSLog(@"net woking change");
}

@end
