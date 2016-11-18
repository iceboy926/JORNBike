//
//  CoreDataManager.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/2.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

//上下文
@property (nonatomic, strong) NSManagedObjectContext *managerObjectContext;

//对象模型
@property (nonatomic, strong) NSManagedObjectModel *managerObjectModel;


+(instancetype)sharedInstance;

//保存上下文对象
- (void)saveContext;

@end
