//
//  COMyWXCollectionModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COMyWXCollectionModel : NSObject

@property (nonatomic, strong)NSString *titleStr;

@property (nonatomic, strong)NSString *imageUrlStr;

@property (nonatomic, strong)NSString *sourceStr;

@property (nonatomic, strong)NSString *timeStr;

@property (nonatomic, strong)NSString *collectionUrlStr;


- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
