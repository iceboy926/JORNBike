//
//  CoreDataManager.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/2.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator; //持久层助手

@end

@implementation CoreDataManager


+(instancetype)sharedInstance
{
    static CoreDataManager *myInstance = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
    
        if(myInstance == nil)
        {
            myInstance = [[CoreDataManager alloc] init];
        }
    
    });
    
    return myInstance;
}


#pragma mark lazy load

- (NSManagedObjectModel *)managerObjectModel
{
    if(_managerObjectModel == nil)
    {
        NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"CoMoBicycle" withExtension:@"momd"];
        
        _managerObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
        
    }
    
    return _managerObjectModel;
    
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.automo.CoMoBicycle" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managerObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoMoBicycle.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managerObjectContext
{
    if(_managerObjectContext == nil)
    {
        _managerObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if(coordinator == nil)
            return nil;
        
        [_managerObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managerObjectContext;
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managerObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
