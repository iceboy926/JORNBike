//
//  CORegisterViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CORegisterViewModel : NSObject

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *checkSMS;

@property (nonatomic, strong) NSString *nickname;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSData *headImageData;

@property (nonatomic, strong) NSString *headImageUrl;

@property (nonatomic, strong) NSNumber *invalidStart;

@property (nonatomic, strong) NSNumber *invalidNext;

@property (nonatomic, strong) NSString *invalidMsg;

@property (nonatomic, strong) NSNumber *smsCheck;

@property (nonatomic, strong) NSNumber *netStatus;

@property (nonatomic, strong) NSNumber *registerStatus;

+(instancetype)shareInstance;

- (void)startRegister;
- (void)nextRegister;
- (void)finishRegister;

@end
