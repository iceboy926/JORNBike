//
//  Macros.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define MAX_WIDTH  [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH_TO_FIT(_width)  (ceilf( [UIScreen mainScreen].bounds.size.width / 414.0f  * (_width / 2) * 2))

#define WEAK_SELF(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define STRONG_SELF(strongSelf) __strong __typeof(&*self)strongSelf = self;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:1.0]


#define ISIOS10 ([[[UIDevice currentDevice] sysytemVersion] doubleValue]>=10.0)
#define ISIOS9 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=9.0)
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)
#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)

#pragma mark color

#define customButtonColor   UIColorFromRGB(0xF89022)
#define backGroundColor     UIColorFromRGB(0xEFEFEF)
#define navigaterBarColor   UIColorFromRGB(0x575757)
#define shadowViewColor     UIColorFromRGB(0xB0B0B0)
#define orangeViewColor     UIColorFromRGB(0xEE9572)


#pragma mark frame

#define NavBarHeight        64
#define ButtonHeight        44

#pragma mark font

#pragma mark imageURL

#pragma mark key

#define BAIDUMAP_SK @"X6fWRYC69DdhfrYc9Y3Qw1uIGyxwLuHn"


#define SMS_APPKEY          @"19be103c5bce6"
#define SMS_APPSECRET       @"8b77bbddf8227e44becf266fb26c445a"

#define Share_AppKey        SMS_APPKEY
#define Share_AppSecret     SMS_APPSECRET


#define SinaWeiBo_AppKey                @"1522613711" //@"2187371547"
#define SinaWeiBo_AppSecret             @"d3963e403edbc49048f5217eb81a2d26"
#define SinaWeiBo_redirectUri           @"http://www.myapp.com/login/callback"

#define WeiXin_AppKey                   @"wxb15b4ab26fce2028"
#define WeiXin_AppSecret                @""


#endif /* Macros_h */
