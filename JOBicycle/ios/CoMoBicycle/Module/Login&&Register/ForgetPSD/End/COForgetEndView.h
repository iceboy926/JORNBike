//
//  CORegisterNextView.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/27.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COForgetEndView : UIView

@property (nonatomic, strong) UITextField *userpsdoldTextField;
@property (nonatomic, strong) UITextField *userpsdnewTextField;
@property (nonatomic, copy) void (^finishBtnClickedBlock)();

@end
