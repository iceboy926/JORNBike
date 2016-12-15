//
//  COMyWXCollectionTableViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyWXCollectionTableViewModel.h"
#import "COMyWXCollectionCell.h"
#import "COMyWXCollectionModel.h"

@interface COMyWXCollectionTableViewModel()
{
    NSInteger totalPage;
    NSInteger currentPage;
}

@property (nonatomic, strong) NSString *WXAppkey;
@property (nonatomic, assign) NSInteger pno;
@property (nonatomic, assign) NSInteger ps;
@property (nonatomic, strong) NSString *dtype;
@property (nonatomic, strong) NSString *WXCollectionRequestURL;

@end

@implementation COMyWXCollectionTableViewModel

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.WXAppkey = @"40821487cc45a055d3d3cb05adf214ca";
        self.pno = 1;
        self.ps = 50;
        self.dtype = @"JSON";
        self.WXCollectionRequestURL = @"http://v.juhe.cn/weixin/query";
        totalPage = 1;
        currentPage = 1;
    }
    
    return self;
}

- (NSMutableArray *)collectionArray
{
    if(_collectionArray == nil)
    {
        _collectionArray = [[NSMutableArray alloc] init];
    }
    
    return _collectionArray;
}


- (void)requestWXCollectionModelWithCompletion:(void(^)(BOOL blfinished)) completion
{
    
    NSMutableDictionary *dicParam = [NSMutableDictionary dictionary];
    
    dicParam[@"pno"] = [NSString stringWithFormat:@"%ld",currentPage];
    dicParam[@"ps"] = [NSString stringWithFormat:@"%ld", self.ps];
    dicParam[@"dtype"] = self.dtype;
    dicParam[@"key"] = self.WXAppkey;

    
//    if(currentPage > totalPage)
//    {
//        completion(NO);
//
//        return ;
//    }
    
    NSMutableArray *tempDataArray = [NSMutableArray array];
    
    [httpRequest requestWithURLString:self.WXCollectionRequestURL parameters:dicParam type:HttpRequestTypeGet success:^(id responseObject) {
        
        if(responseObject)
        {
            //NSLog(@"result is %@", responseObject);
            
            if([responseObject[@"error_code"] intValue] == 0)
            {
                NSDictionary *dicResult = responseObject[@"result"];
                
                if((NSNull *)dicResult == [NSNull null])
                {
                    completion(NO);
                }
                else
                {
                
                    totalPage = [dicResult[@"totalPage"] integerValue];
                    
                    if(dicResult)
                    {
                        NSArray *arrayData = dicResult[@"list"];
                        
                        for (NSDictionary *dataDic in arrayData) {
                            
                            COMyWXCollectionModel *dataModel = [[COMyWXCollectionModel alloc] initWithDictionary:dataDic];
                            
                            [tempDataArray addObject:dataModel];
                        }
                        
                        [self.collectionArray insertObjects:tempDataArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempDataArray.count)]];
                        
                        
                        if(completion)
                        {
                            currentPage++;
                            completion(YES);
                        }
                        
                        
                    }
                    else
                    {
                        completion(NO);
                    }
                }
                
            }
            else
            {
                completion(NO);
            }
        }
        else
        {
            completion(NO);
        }
        

        
        
    } failure:^(NSError *error){
    
        if(error)
        {
            NSLog(@"error is %@", error);
        }
        
        if(completion)
        {
            completion(NO);
        }
    
    }];
    
}

- (NSInteger)numbersOfRowsInSection:(NSInteger)Section
{
    return [self.collectionArray count];
}

- (COMyWXCollectionCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COMyWXCollectionCell *cell = [COMyWXCollectionCell cellWithTableView:tableView];
    
    if(cell)
    {
        cell.collectionModel = [self.collectionArray objectAtIndex:[indexPath row]];
    }
    
    return cell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [COMyWXCollectionCell heightForCollectionCell];
}

- (NSURL *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    COMyWXCollectionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *strurl = [cell.collectionModel collectionUrlStr];
    
    return [NSURL URLWithString:strurl];
}


@end
