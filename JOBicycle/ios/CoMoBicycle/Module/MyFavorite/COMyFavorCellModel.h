//
//  COMyFavorCellModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COMyFavorCellModel : NSObject

@property (nonatomic, strong)NSString *strHeadImageUrl;
@property (nonatomic, strong)NSString *strTitle;
@property (nonatomic, strong)NSString *strContentImageUrl;
@property (nonatomic, strong)NSString *strContentDescript;
@property (nonatomic, strong)NSString *strTime;

- (instancetype)initWithDictionary:(NSDictionary *)dicRes;

@end
