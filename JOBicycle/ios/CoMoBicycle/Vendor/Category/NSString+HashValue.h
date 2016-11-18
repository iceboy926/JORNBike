//
//  NSString+HashValue.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HashValue)

-(NSString *)md5;

+(NSString*)replaceUnicode:(NSString *)unicodeStr;

+(NSDate *)dateFromString:(NSString *)string;

-(NSString *)URLEncodeString;

-(NSString *)URLDecodeString;

-(NSMutableString*)GetTime;

@end
