//
//  MyMediator.m
//  MyMediatorDemo
//
//  Created by 金玉衡 on 16/10/9.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "COMediator.h"


@implementation COMediator


+(instancetype)shareInstance
{
    static COMediator *myMediator = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        if(myMediator == nil)
        {
            myMediator = [[COMediator alloc] init];
            
        }
    });

    return myMediator;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)paramDic
{
    NSString *targetClassString = [NSString stringWithFormat:@"%@", targetName];
    NSString *actionString = [NSString stringWithFormat:@"%@", actionName];
    
    Class targetClass = NSClassFromString(targetClassString);
    id target = [[targetClass alloc] init];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) {
        // 这里是处理无响应请求的地方之一，这个demo做得比较简单，如果没有可以响应的target，就直接return了。实际开发过程中是可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求的
        return nil;
    }
    
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if(paramDic == nil)
        {
            return [target performSelector:action];
        }
        else
        {
            return [target performSelector:action withObject:paramDic];
        }
#pragma clang diagnostic pop

    } else {
        // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
        SEL action = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:action withObject:paramDic];
#pragma clang diagnostic pop
        } else {
            // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
            return nil;
        }
    }

}

@end
