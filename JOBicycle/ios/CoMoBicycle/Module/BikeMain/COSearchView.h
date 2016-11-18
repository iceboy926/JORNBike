//
//  COSearchView.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/8.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COSearchView : UIView

@property (nonatomic, strong)UISearchBar *inputSearch;

@property (nonatomic, copy) void (^inputSearchKeywordBlock)();

@end
