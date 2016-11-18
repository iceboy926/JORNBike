//
//  COForgetStartView.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

@class COAuthCodeView;
@interface COForgetStartView : UIView

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *authCodeTextField;
@property (nonatomic, strong) COAuthCodeView *authCodeView;
@property (nonatomic, copy) void (^forgetStartClickedBlock)(BOOL blAuth);

@end
