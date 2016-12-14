//
//  SVProgressHUD+ShowWait.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (ShowWait)

+ (void)ShowWaitMsg:(NSString *)strMsg;

+ (void)hideWait;

@end
