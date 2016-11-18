//
//  COAuthCodeView.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COAuthCodeView : UIView

@property (nonatomic, strong) NSMutableString *authCodeStr;

- (NSString *)getCode;

@end
