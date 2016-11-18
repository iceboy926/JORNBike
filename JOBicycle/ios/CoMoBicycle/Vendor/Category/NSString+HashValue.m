//
//  NSString+HashValue.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "NSString+HashValue.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (HashValue)

-(NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+(NSString*)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempstr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempstr2 = [tempstr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempstr3 = [[@"\"" stringByAppendingString:tempstr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempstr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    return returnStr;
    //return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

+(NSDate *)dateFromString:(NSString *)string
{
    if(!string)
        return nil;
    
    struct tm tm;
    time_t t;
    string = [string substringFromIndex:4];
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%b %d %H:%M:%S %z %Y", &tm);
    tm.tm_isdst =-1;
    t= mktime(&tm);
    
    return [NSDate dateWithTimeIntervalSince1970:t];
}

-(NSMutableString*)GetTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *datastr = [NSString dateFromString:self];
    
    NSString *str = [dateFormatter stringFromDate:datastr];
    
    
    NSMutableString *strDate = [[NSMutableString alloc] initWithString:str];
    
    
    return strDate;
}



-(NSString *)URLEncodeString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

-(NSString *)URLDecodeString
{
    if([self respondsToSelector:@selector(stringByRemovingPercentEncoding)])
    {
        return [self stringByRemovingPercentEncoding];
    }
    else
    {
        NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                         (__bridge CFStringRef)self,
                                                                                                                         CFSTR(""),
                                                                                                                         CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        return decodedString;
    }
}


@end
