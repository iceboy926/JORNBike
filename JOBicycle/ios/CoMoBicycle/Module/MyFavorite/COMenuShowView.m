//
//  COMenuShowView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/21.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMenuShowView.h"

#define itemHeigth     40  //每项高度

@interface COMenuShowView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *arrayData;
@property (nonatomic, strong) UITableView *mytableView;
@property (nonatomic, assign) NSInteger lastRow;

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
        self.lastRow = NSIntegerMax;
        
        self.blShow = NO;
        CGRect newFrame = self.frame;
        newFrame.size.height = [arryItems count]*itemHeigth;
        
        self.frame = newFrame;
        
        self.layer.anchorPoint = CGPointMake(0.5, 0);
        
        self.layer.position = CGPointMake(self.layer.position.x+(0.5-0.5)*self.frame.size.width, self.layer.position.y+(0-0.5)*self.frame.size.height);
    }
    
    return self;
}


//默认的anchorPoint 是(0.5, 0.5)即View中心点
- (void) setAnchorPoint:(CGPoint)anchorpoint forView:(UIView *)view{
    CGRect oldFrame = view.frame;
    view.layer.anchorPoint = anchorpoint;
    view.frame = oldFrame;
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
        _mytableView = [[UITableView alloc] initWithFrame:CGRectZero];
        
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mytableView.scrollEnabled = NO;
    }
    
    return _mytableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"menucell";

     UITableViewCell   *menuCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    
    menuCell.textLabel.text  = [self.arrayData objectAtIndex:[indexPath row]];
    menuCell.textLabel.textColor = [UIColor blackColor];
    menuCell.textLabel.font = [UIFont systemFontOfSize:16.0];
    menuCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return menuCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return itemHeigth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger currentRow = [indexPath row];
    NSInteger currentSection = [indexPath section];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if(selectedCell)
    {
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    
    if(self.lastRow == NSIntegerMax)
    {
        
        self.lastRow = currentRow;
    }
    else
    {
        UITableViewCell *lastSelectedCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastRow inSection:currentSection]];
        if(lastSelectedCell)
        {
            lastSelectedCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        self.lastRow = currentRow;
    }
}


#pragma mark member fun
- (void)showMenuView
{
    self.alpha = 0.0;
    self.transform = CGAffineTransformMakeScale(1, 0.001);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 0.8;
        
    } completion:^(BOOL blfinished){
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        
        self.blShow = YES;
    
    }];
}

- (void)disMissMenuView
{
    self.alpha = 0.8;
    [UIView animateWithDuration:0.3 animations:^{
    
        self.transform = CGAffineTransformMakeScale(1, 0.001);
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        self.blShow = NO;
        [self removeFromSuperview];
    }];
    
}

@end
