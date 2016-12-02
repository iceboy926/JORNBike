//
//  COMyFavorTableViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyFavorTableViewModel.h"
#import "COMyFavorCell.h"
#import "COMyFavorCellModel.h"

@interface COMyFavorTableViewModel()

@end

@implementation COMyFavorTableViewModel


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
    }
    
    return self;
}

#pragma mark lazy load

- (NSMutableArray *)modelArray
{
    if(_modelArray == nil)
    {
        _modelArray = [[NSMutableArray alloc] init];
    }
    
    return _modelArray;
}


- (void)requestFavorViewModelWithCompletion:(void (^)(BOOL blfinished)) completion
{
    NSDictionary *accout = [COAccount getAccount];
    if(accout)
    {
        NSDictionary *dicParams = @{@"user": accout[@"username"], @"token": accout[@"usertoken"]};
        
        [httpRequest requestWithURLString:API_URL_MYFAVOR parameters:nil type:HttpRequestTypeGet success:^(id response){
            
            if(response)
            {
                NSArray *arrayResult = response;
                
                if([self.modelArray count] > 0)
                {
                    [self.modelArray removeAllObjects];
                }
                
                for (NSDictionary *dic in arrayResult) {
                    
                    COMyFavorCellModel *cellModel = [[COMyFavorCellModel alloc] initWithDictionary:dic];
                    if(cellModel)
                    {
                        [self.modelArray addObject:cellModel];
                    }
                }
                
                if(completion)
                {
                    completion(YES);
                }
            }
            
        } failure:^(NSError *error){
            
            if(completion)
            {
                completion(NO);
            }
            
        }];
    }
    
}


- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.modelArray count];
    
    return count;
}

- (COMyFavorCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COMyFavorCell *favorCell = [COMyFavorCell cellWithTableView:tableview];
    if(favorCell)
    {
        favorCell.favorCellModel = [self.modelArray objectAtIndex:[indexPath row]];
    }
    
    return favorCell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [COMyFavorCell heightForCell];
}


@end
