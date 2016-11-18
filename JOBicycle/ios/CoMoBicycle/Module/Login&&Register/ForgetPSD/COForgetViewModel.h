//
//  COForgetViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COForgetViewModel : NSObject

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSNumber *authStatus;

@property (nonatomic, strong) NSString *smsCode;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *repeatPSD;

@property (nonatomic, strong) NSNumber *invalid;

@property (nonatomic, strong) NSString *invalidMsg;

@property (nonatomic, strong) NSNumber *finishedStatus;

@property (nonatomic, strong) NSNumber *netStatus;

+ (instancetype)shareInstance;

- (void)forgetStart;

- (void)forgetNext;

- (void)forgetEnd;

@end
