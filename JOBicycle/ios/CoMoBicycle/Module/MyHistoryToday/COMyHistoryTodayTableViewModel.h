//
//  COMyHistoryTodayViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COMyHistoryTodayCell, UITableView;

@interface COMyHistoryTodayTableViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *historyArrayData;

- (void)requestHistoryDataModelWithCompletion:(void(^)(BOOL blfinished)) completion;

- (NSInteger)numbersOfRowsInSection:(NSInteger)section;

- (COMyHistoryTodayCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
