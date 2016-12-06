//
//  COMyFavorTableViewModel.h
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COMyFavorCell, UITableView;

@interface COMyFavorTableViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, copy) BOOL (^didSelectMGSwiperBtn)(NSInteger index);


- (void)requestFavorViewModelWithCompletion:(void (^)(BOOL blfinished)) completion;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (COMyFavorCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
