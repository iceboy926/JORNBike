//
//  ServiceComponent.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/28.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "ServiceComponent.h"


@interface ServiceComponent()
{
    NSMutableArray *allServices;
}

@end

@implementation ServiceComponent

+(instancetype)shareInstance
{
    static ServiceComponent *myComponent = nil;
    static dispatch_once_t  once_t;
    dispatch_once(&once_t, ^{
    
        if(myComponent == nil)
        {
            myComponent = [[ServiceComponent alloc] init];
        }
    
    });
    
    return myComponent;
}

- (NSMutableArray *)services
{
    if(allServices == nil)
    {
        allServices = [[NSMutableArray alloc] init];
        [self registServices];
    }
    
    return allServices;
}


- (void)registService:(id)service
{
    if(![allServices containsObject:service])
    {
        [allServices addObject:service];
    }
}

- (void)registServices
{
    [self registService:[[BaiduMapServer alloc] init]];
    [self registService:[[UIInitServer alloc] init]];
    [self registService:[[SMSServer alloc] init]];
}

@end
