//
//  COMenuShowView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMenuShowView.h"

@interface COMenuShowView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *arrayData;
@property (nonatomic, strong) UITableView *mytableView;

@end

@implementation COMenuShowView

- (instancetype)initWithFrame:(CGRect)frame  items:(NSArray <NSString *>*)arryItems
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.arrayData = [arryItems copy];
        [self addSubview:self.mytableView];
        [self addUIConstraints];
    }
    
    return self;
}

#pragma mark ui layout
- (void)addUIConstraints
{
    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
        
    }];
}

#pragma mark lazy load

- (NSArray *)arrayData
{
    if(_arrayData == nil)
    {
        _arrayData = [[NSArray alloc] init];
    }
    return _arrayData;
}


- (UITableView *)mytableView
{
    if(_mytableView == nil)
    {
        _mytableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
        _mytableView.backgroundColor = [UIColor clearColor];
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mytableView.scrollEnabled = NO;
        
    }
    
    return _mytableView;
}

#pragma mark member fun
- (void)showMenuView
{
    
}

- (void)disMissMenuView
{
    
}

@end
