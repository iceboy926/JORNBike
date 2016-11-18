//
//  UserinfoManager.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/3.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "Userinfo.h"

@interface UserinfoManager : NSObject

+(instancetype)sharedManager;

- (Userinfo *)addUserWithUser:(NSString *)username
                     WithNick:(NSString *)nickname
                    WithImageData:(NSData *)imagedata;


- (NSArray *)getAllUsers;

@end
