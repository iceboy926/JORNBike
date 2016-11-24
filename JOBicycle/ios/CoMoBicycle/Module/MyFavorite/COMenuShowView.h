//
//  COMenuShowView.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COMenuShowView : UIView

@property (nonatomic, assign) BOOL blShow;

- (instancetype)initWithFrame:(CGRect)frame  items:(NSArray <NSString *>*)arryItems;

- (void)showMenuView;

- (void)disMissMenuView;

@end
