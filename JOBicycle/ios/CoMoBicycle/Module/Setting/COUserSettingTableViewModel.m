//
//  COSettingTableViewModel.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/4.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COUserSettingTableViewModel.h"

#import "COUserSettingCell.h"
#import "COUserSettingCellModel.h"

@interface COUserSettingTableViewModel()

@end

@implementation COUserSettingTableViewModel


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
    }
    
    return self;
}

- (NSMutableArray *)infoArray
{
    if(_infoArray == nil)
    {
        _infoArray = [[NSMutableArray alloc] init];
    }
    
    return _infoArray;
}


- (void)requestUserSettingModelWithCallBack:(void (^)(BOOL))callback
{
    NSDictionary *accout = [COAccount getAccount];
    if(accout)
    {
        NSDictionary *dicParams = @{@"user": accout[@"username"], @"token": accout[@"usertoken"]};
        
        WEAK_SELF(weakself)
        [httpRequest requestWithURLString:API_URL_USERSETTING parameters:nil type:HttpRequestTypeGet success:^(id response){
            
            if(response)
            {
                NSArray *arrayResult = response[@"centerSetting"];
                
                if([weakself.infoArray count] > 0)
                {
                    [weakself.infoArray removeAllObjects];
                }
                
                for (NSDictionary *dic in arrayResult) {
                
                    COUserSettingCellModel *cellModel = [[COUserSettingCellModel alloc] initWithDictionary:dic];
                    if(cellModel)
                    {
                        [weakself.infoArray addObject:cellModel];
                    }
                }
                
                if(callback)
                {
                    callback(YES);
                }
            }
        
        } failure:^(NSError *error){
        
            NSDictionary *dic = [weakself fetchUserSettingPlistValue];
            
            NSArray *arrayResult = dic[@"centerSetting"];
            
            if([weakself.infoArray count] > 0)
            {
                [weakself.infoArray removeAllObjects];
            }
            
            for (NSDictionary *dic in arrayResult) {
                
                COUserSettingCellModel *cellModel = [[COUserSettingCellModel alloc] initWithDictionary:dic];
                if(cellModel)
                {
                    [weakself.infoArray addObject:cellModel];
                }
            }

            if(callback)
            {
                callback(YES);
            }
        
        }];
    }
    else
    {
        
    }
}

- (NSMutableDictionary *)fetchUserSettingPlistValue
{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserSetting" ofType:@"plist"];
    
    NSMutableDictionary *userSettingDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    return userSettingDic;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [self.infoArray count];
    
    return rows;
}

- (COUserSettingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COUserSettingCell *cell = [COUserSettingCell cellWithTableView:tableView];
    if(cell)
    {
        cell.cellModel = self.infoArray[[indexPath row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    
    height = [COUserSettingCell heightForCell];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
