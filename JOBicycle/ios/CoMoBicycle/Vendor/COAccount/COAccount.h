//
//  COAccount.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COAccount : NSObject


+(void)saveAccount:(NSDictionary *)account;


+(NSDictionary *)getAccount;


+(void)DeleteAcount;


@end
