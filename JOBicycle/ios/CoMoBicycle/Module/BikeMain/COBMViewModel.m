//
//  COBMViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/3.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COBMViewModel.h"
#import "UserinfoManager.h"

@implementation COBMViewModel

+ (instancetype)sharedInstance
{
    static COBMViewModel *myVM = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
    
        if(myVM == nil)
        {
            myVM = [[COBMViewModel alloc] init];
        }
    
    });
    
    return myVM;
}


- (NSData *)getLocalUserImage
{
    NSData *data = nil;
    
    NSArray *userArray = [[UserinfoManager sharedManager] getAllUsers];
    
    if([userArray count] > 0)
    {
        Userinfo *userinfo = [userArray objectAtIndex:0];
        data = userinfo.headimage;
    }
    else
    {
        UIImage *imagehead = [UIImage imageNamed:@"defaultheadImage"];
        data = [NSData dataWithData:UIImagePNGRepresentation(imagehead)];
    }
    
    return data;
}

@end
