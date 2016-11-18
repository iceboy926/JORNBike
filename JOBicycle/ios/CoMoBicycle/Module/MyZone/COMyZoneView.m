//
//  COMyZoneView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/17.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyZoneView.h"
#import "RCTRootView.h"
#import "RCTBundleURLProvider.h"
#import "CodePush.h"

@interface COMyZoneView()

@property (nonatomic, strong) RCTRootView *rootView;

@end

@implementation COMyZoneView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self addSubview:self.rootView];
        
        [self addUIConstraints];
    }
    
    return self;
}


#pragma mark ui layout

- (void)addUIConstraints
{
    [self.rootView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
        
    }];
    
}


#pragma mark lazy load

- (RCTRootView *)rootView
{
    if(_rootView == nil)
    {
        NSURL *jscodelocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
        
        jscodelocation = [CodePush bundleURL];
        
        _rootView = [[RCTRootView alloc] initWithBundleURL:jscodelocation moduleName:@"CoMoBicycle" initialProperties:nil launchOptions:nil];

    }
    
    return _rootView;
}

@end
