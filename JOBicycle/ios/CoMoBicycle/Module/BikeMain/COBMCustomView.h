//
//  COBMView.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/2.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COBMCustomView : UIView

@property (nonatomic, copy) void (^startSearchBlock)();

- (void)startPoiSearchWithKeyword:(NSString *)strKeyWord;

- (void)hideResultListView;

@end
