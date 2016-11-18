//
//  COSettingTableViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/4.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COUserSettingCell, UITableView;

@interface COUserSettingTableViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *infoArray;

- (void)requestUserSettingModelWithCallBack:(void (^)(BOOL blfinished))callback;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (COUserSettingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
