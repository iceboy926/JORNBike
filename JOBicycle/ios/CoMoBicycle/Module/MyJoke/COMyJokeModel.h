//
//  COMyJokeModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COMyJokeModel : NSObject

@property (nonatomic, strong)NSString *contentStr;
@property (nonatomic, strong)NSString *unixtimeStr;
@property (nonatomic, strong)NSString *imageURL;
@property (nonatomic, assign)BOOL   blJoke;



- (instancetype)initWithDictionary:(NSDictionary *)dicResult;

@end
