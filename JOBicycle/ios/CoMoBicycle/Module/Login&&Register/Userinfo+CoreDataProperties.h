//
//  Userinfo+CoreDataProperties.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/2.
//  Copyright © 2016年 AutoMo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Userinfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Userinfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *usename;
@property (nullable, nonatomic, retain) NSString *nickname;
@property (nullable, nonatomic, retain) NSData *headimage;
@property (nullable, nonatomic, retain)NSString *headimageurl;

@end

NS_ASSUME_NONNULL_END
