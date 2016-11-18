//
//  CONavigationBar.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CORegistNavigationBar.h"

@interface CORegistNavigationBar()

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation CORegistNavigationBar

- (instancetype)initWithTitle:(NSString *)strTitle
{
    self = [super init];
    if(self)
    {
        [self setTitleStr:strTitle];
        [self addSubview:self.nextBtn];
        
        [self addUIContraints];
    }
    
    return self;
}


#pragma mark ui layout

- (void)addUIContraints
{
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.bottom.equalTo(self).insets(UIEdgeInsetsMake(20, 0, 0, 0));
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
        
    }];
}

#pragma mark lazy load

- (UIButton *)nextBtn
{
    if(_nextBtn == nil)
    {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _nextBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _nextBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:customButtonColor forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _nextBtn;
}


#pragma mark button-action

- (void)nextBtnClicked:(id)sender
{
    if(self.nextBtnClickedBlock)
    {
        self.nextBtnClickedBlock();
    }
}

@end
