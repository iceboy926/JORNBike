//
//  COUserSettingHeadViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/8.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COUserSettingHeadViewModel : NSObject

- (void)fetchUserSettingHeadDataWithCallBack:(void (^)(id response))completion;

@end
