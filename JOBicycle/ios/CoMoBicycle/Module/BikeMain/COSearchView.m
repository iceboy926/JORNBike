//
//  COSearchView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/8.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COSearchView.h"

@interface COSearchView() <UISearchBarDelegate>

@property (nonatomic, strong)UIImageView *headImageView;



@end

@implementation COSearchView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = backGroundColor;
        
        [self addSubview:self.headImageView];
        [self addSubview:self.inputSearch];
        
        [self addUIConstraints];
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstraints
{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height).multipliedBy(0.8);
        make.left.equalTo(self.mas_left).offset(5);
        make.width.equalTo(self.mas_height).multipliedBy(0.8);
    }];
    
    [self.inputSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headImageView.mas_right);
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height).multipliedBy(0.8);
    }];
}

#pragma mark lazy load

- (UIImageView *)headImageView
{
    if(_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"defaultheadImage"];
        
        
    }
    
    return _headImageView;
}

- (UISearchBar *)inputSearch
{
    if(_inputSearch == nil)
    {
        _inputSearch = [[UISearchBar alloc] init];
        
        _inputSearch.backgroundColor = [UIColor clearColor];
        [_inputSearch setPlaceholder:@"附件的商场、银行"];
        
        _inputSearch.showsCancelButton = NO;
        _inputSearch.delegate = self;
    }
    
    return _inputSearch;
}

#pragma mark UISearchBar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if(self.inputSearchKeywordBlock)
    {
        self.inputSearchKeywordBlock();
    }

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search bar input is %@", searchText);
    
    [self.inputSearch resignFirstResponder];
    
 }

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search key word is %@", searchBar.text);

}

#pragma mark custom function



@end
