//
//  CORegisterStartView.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/26.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COForgetNextView : UIView

@property (nonatomic, strong) UITextField *usernameTextField;

@property (nonatomic, strong) UITextField *checknumTextField;

@property (nonatomic, copy) void (^nextBtnClickedBlock)();

@end
