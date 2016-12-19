//
//  COMyFunnyViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/16.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyFunnyView.h"

@interface COMyFunnyView()

@property (nonatomic, strong)UITableView *myTableView;

@end

@implementation COMyFunnyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = backGroundColor;
        [self addSubview:self.myTableView];
    }
    
    return self;
}


#pragma mark lazy load

- (UITableView *)myTableView
{
    if(_myTableView == nil)
    {
        _myTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        //_myTableView.dataSource = self;
        //_myTableView.delegate = self;
    }
    
    return _myTableView;
}


@end
