//
//  CONavigationBar.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COLRBaseNavigationBar.h"

@interface CORegistNavigationBar :COLRBaseNavigationBar

- (instancetype)initWithTitle:(NSString *)strTitle;

@property (nonatomic, copy) void (^nextBtnClickedBlock)();

@end
