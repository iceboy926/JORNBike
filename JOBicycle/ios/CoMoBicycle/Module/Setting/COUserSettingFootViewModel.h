//
//  COUserSettingFootViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/11.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COUserSettingFootViewModel : NSObject

- (void)fetchUserSettingFootDataWithCallBack:(void (^)(id response))completion;

@end
