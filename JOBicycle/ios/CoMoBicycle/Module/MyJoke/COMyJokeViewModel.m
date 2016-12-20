//
//  COMyJokeViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyJokeViewModel.h"
#import "COMyJokeCell.h"
#import "COMyFunnyCell.h"
#import "COMyJokeModel.h"

@interface COMyJokeViewModel()
{
    BOOL blJoke;
}

@property (nonatomic, strong) NSString *jokeAppKey;
@property (nonatomic, strong) NSString *jokeDataRequestURL;
@property (nonatomic, strong) NSString *jokeType;
@property (nonatomic, assign) NSInteger pageInt;
@property (nonatomic, assign) NSInteger pageSize;


@end

@implementation COMyJokeViewModel

- (instancetype) initWithJokeType:(NSString *)type
{
    self = [super init];
    if(self)
    {
        self.jokeAppKey = @"99b1094eee845b41d3fbfd988d16639c";
        
        if([type isEqualToString:@"joke"])
        {
            self.jokeDataRequestURL = @"http://japi.juhe.cn/joke/content/text.from";
            blJoke = YES;
        }
        else
        {
            self.jokeDataRequestURL = @"http://japi.juhe.cn/joke/img/text.from";
            blJoke = NO;
        }
        
        self.pageInt = 1;
        self.pageSize = 20;
        self.jokeType = type;
    }
    
    return self;
}

#pragma mark lazy load

- (NSMutableArray *)jokeDataArray
{
    if(_jokeDataArray == nil)
    {
        _jokeDataArray = [NSMutableArray array];
    }
    
    return _jokeDataArray;
}


- (void)requestDataModelWithCompletion:(void (^)(BOOL blfinished)) completionBlock
{
    NSDictionary *dicParam = @{@"key": self.jokeAppKey, @"page":[NSString stringWithFormat:@"%d", self.pageInt], @"pagesize":[NSString stringWithFormat:@"%d", self.pageSize]};
    
    
    [httpRequest requestWithURLString:self.jokeDataRequestURL parameters:dicParam type:HttpRequestTypeGet success:^(id responseObject) {
       
        if(responseObject)
        {
            NSDictionary *resultDic = responseObject[@"result"];
            if(resultDic)
            {
                NSArray *arrayData = resultDic[@"data"];
                NSMutableArray *tempDataArray = [NSMutableArray array];
                
                for (NSDictionary *dataDic in arrayData) {
                
                    COMyJokeModel *jokeModel = [[COMyJokeModel alloc] initWithDictionary:dataDic];
                    if(jokeModel)
                    {
                        [tempDataArray addObject:jokeModel];
                    }
                }
                
                
                [self.jokeDataArray insertObjects:tempDataArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempDataArray.count)]];
                
                if(completionBlock)
                {
                    self.pageInt += 1;
                    completionBlock(YES);
                }
                
            }
            else
            {
                completionBlock(NO);
            }
            
            
        }
        

    } failure:^(NSError *error) {
        
        if(error)
        {
            NSLog(@"error is %@", error.localizedDescription);
            completionBlock(NO);
        }
        
    }];
    
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.jokeDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(blJoke == YES)
    {
        COMyJokeCell *jokeCell = [COMyJokeCell cellWithTableView:tableView];
        if(jokeCell)
        {
            jokeCell.jokeModel = [self.jokeDataArray objectAtIndex:[indexPath row]];
        }
        
        return jokeCell;
    }
    else
    {
        COMyFunnyCell *funnyCell = [COMyFunnyCell cellWithTableView:tableView];
        if(funnyCell)
        {
            funnyCell.funnyModel = [self.jokeDataArray objectAtIndex:[indexPath row]];
        }
        
        return funnyCell;
    }
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blJoke)
    {
        return [COMyJokeCell heightForCellModel:[self.jokeDataArray objectAtIndex:[indexPath row]]];
    }
    else
    {
        return [COMyFunnyCell heightForCellModel:[self.jokeDataArray objectAtIndex:[indexPath row]]];
    }
}


@end
