//
//  COMyWXCollectionTableViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COMyWXCollectionCell, UITableView;

@interface COMyWXCollectionTableViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *collectionArray;

- (void)requestWXCollectionModelWithCompletion:(void(^)(BOOL blfinished)) completion;

- (NSInteger)numbersOfRowsInSection:(NSInteger)Section;

- (COMyWXCollectionCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSURL *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
