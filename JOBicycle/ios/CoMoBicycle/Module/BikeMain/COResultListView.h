//
//  COResultListView.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/9.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COResultListView : UIView

@property (nonatomic, copy) void (^DidSelectResultInfoBlock)(NSInteger index);

- (instancetype)initWithKeyWord:(NSString *)strKeyword InfoData:(NSArray *)resultData;

- (void)showView;

- (void)hideView;

@end
