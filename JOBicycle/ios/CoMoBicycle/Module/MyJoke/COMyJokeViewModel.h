//
//  COMyJokeViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

@class COMyJokeCell, UITableView;

#import <Foundation/Foundation.h>

@interface COMyJokeViewModel : NSObject

@property (nonatomic, strong)NSMutableArray *jokeDataArray;

- (instancetype) initWithJokeType:(NSString *)type;

- (void)requestDataModelWithCompletion:(void (^)(BOOL blfinished)) completionBlock;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
