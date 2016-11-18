//
//  UIInitServer.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIInitServer : NSObject <UIApplicationDelegate>

@property (nonatomic, strong)MMDrawerController *drawerController;

- (void)toggleLeftView;

- (void)closeLeftViewAnimated:(BOOL)animated completion:(void (^)(BOOL blfinised))completion;



@end
