//
//  UserinfoManager.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/3.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "UserinfoManager.h"

@interface UserinfoManager()

@end

@implementation UserinfoManager

+(instancetype)sharedManager
{
    static UserinfoManager *myInstance = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
    
        if(myInstance == nil)
        {
            myInstance = [[UserinfoManager alloc] init];
        }
    
    });
    
    return myInstance;
}

- (Userinfo *)addUserWithUser:(NSString *)username
                     WithNick:(NSString *)nickname
                    WithImageData:(NSData *)imagedata
{
    Userinfo *userinfo = [NSEntityDescription insertNewObjectForEntityForName:@"Userinfo" inManagedObjectContext:[CoreDataManager sharedInstance].managerObjectContext];
    
    userinfo.usename = username;
    userinfo.nickname = nickname;
    userinfo.headimage = imagedata;
    
    [[CoreDataManager sharedInstance] saveContext];
    
    return userinfo;
}


- (NSArray *)getAllUsers
{
    NSFetchRequest *fetchrequst = [[NSFetchRequest alloc] initWithEntityName:@"Userinfo"];
    NSError *error = nil;
    
    @try {
        
        NSArray *array = [[CoreDataManager sharedInstance].managerObjectContext executeFetchRequest:fetchrequst error:&error];
        
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:10];
        
        for (NSManagedObject *obj in array) {
            
            Userinfo *user = (Userinfo *)obj;
            [dataArray addObject:user];
        }
        
        return dataArray;
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"get data error is %@", error.userInfo);
        
    }

}


@end
