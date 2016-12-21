//
//  COMyHistoryTodayViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyHistoryTodayTableViewModel.h"
#import "COMyHistoryTodayCell.h"
#import "COMyHistoryTodayModel.h"

@interface COMyHistoryTodayTableViewModel()
{
    NSString *strKey;
    NSString *strCurrentDay;
}

@property (nonatomic, strong) NSString *requestURL;


@end

@implementation COMyHistoryTodayTableViewModel

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.requestURL = @"http://v.juhe.cn/todayOnhistory/queryEvent.php";
        
        strKey = @"eab2a31167dd55c66e02944954c7b0d8";
        
        NSDate *currentDate = [NSDate date];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        NSInteger month=[components month];
        NSInteger day=[components day];
        
        strCurrentDay = [NSString stringWithFormat:@"%d\/%d", month, day];
    }
    
    return self;
}

- (NSMutableArray *)historyArrayData
{
    if(_historyArrayData == nil)
    {
        _historyArrayData = [NSMutableArray array];
    }
    
    return _historyArrayData;
}


- (void)requestHistoryDataModelWithCompletion:(void(^)(BOOL blfinished)) completion
{
    NSDictionary *dicParam = @{@"key": strKey, @"date": strCurrentDay};
    
    [httpRequest requestWithURLString:self.requestURL parameters:dicParam type:HttpRequestTypeGet success:^(id responseObject) {
        
        if(responseObject)
        {
            NSMutableArray *tempArray = [NSMutableArray array];
            NSArray *arrayData = responseObject[@"result"];
            
            if(arrayData)
            {
                for (NSDictionary *dicData in arrayData) {
                
                    COMyHistoryTodayModel *model = [[COMyHistoryTodayModel alloc] initWithDictionary:dicData];
                    
                    [tempArray addObject:model];
                }
                
                [self.historyArrayData insertObjects:tempArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempArray.count)]];
                
                if(completion)
                {
                    completion(YES);
                }
            }
        }
        
        
    } failure:^(NSError *error) {
        
        if(error)
        {
            completion(NO);
        }
    }];

}

- (NSInteger)numbersOfRowsInSection:(NSInteger)section
{
    return [self.historyArrayData count];
}

- (COMyHistoryTodayCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COMyHistoryTodayCell *cell = [COMyHistoryTodayCell cellWithTableView:tableView];
    if(cell)
    {
        cell.historyTodayModel = [self.historyArrayData objectAtIndex:[indexPath row]];
    }
    
    return cell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [COMyHistoryTodayCell heightForCellModel:[self.historyArrayData objectAtIndex:[indexPath row]]];
}

- (NSString *)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    COMyHistoryTodayModel *model = [self.historyArrayData objectAtIndex:[indexPath row]];
    
    return model.eidStr;
}


@end
