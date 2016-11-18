//
//  COResultListView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/9.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COResultListView.h"
#import "COCollectionViewCell.h"

@interface COResultListView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSString *strReuser;
    NSArray *resultArray;
    NSString *strKeyWord;
}


@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIBarButtonItem *closeBarBtnItem;


@end



@implementation COResultListView


- (instancetype)initWithKeyWord:(NSString *)strKeyword InfoData:(NSArray *)resultData
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = backGroundColor;
        resultArray = [resultData mutableCopy];
        strKeyWord = [NSString stringWithString:strKeyword];
        
        [self addSubview:self.toolBar];
        [self addSubview:self.collectionView];
        [self addUIConstraints];
        
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstraints
{
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(_toolBar.mas_bottom);
        
    }];
}

#pragma mark lazy load

- (UIToolbar *)toolBar
{
    if(_toolBar == nil)
    {
        _toolBar = [[UIToolbar alloc] init];
        
        [_toolBar sizeToFit];
        
        UIBarButtonItem *titleBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.titleLable];
        UIBarButtonItem *closeBarItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeBarBtnClicked:)];
        
        [closeBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
        
        [_toolBar setItems:[NSArray arrayWithObjects:titleBarItem,closeBarItem, nil] animated:YES];
        
    }
    
    return _toolBar;
}

- (UILabel *)titleLable
{
    if(_titleLable == nil)
    {
        NSInteger offset = 60;
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH-offset, 44)];
    
        NSMutableAttributedString *titleAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共搜索到%d个 ", [resultArray count]] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
        
        [titleAttributedStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:strKeyWord attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor grayColor]}]];
        
        [titleAttributedStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" 相关的结果" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}]];
        
        _titleLable.attributedText = titleAttributedStr;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor clearColor];
    }
    
    return _titleLable;
}

- (UICollectionView *)collectionView
{
    if(_collectionView == nil)
    {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        strReuser = @"CollectionViewCell";
        [_collectionView registerClass:[COCollectionViewCell class] forCellWithReuseIdentifier:strReuser];
        
    }
    
    return _collectionView;
}


#pragma mark UICollectionDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [resultArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    COCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:strReuser forIndexPath:indexPath];
    
    COResultInfo *resultInfo = [resultArray objectAtIndex:[indexPath row]];
    
    [collectionCell configWithDataModel:resultInfo];

    
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.DidSelectResultInfoBlock)
    {
        self.DidSelectResultInfoBlock([indexPath row]);
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(MAX_WIDTH, (MAX_HEIGHT/2.5)/3);
}

#pragma mark barbutton- action

- (void)closeBarBtnClicked:(UIBarButtonItem *)item
{
    [self hideView];
}

#pragma mark member function

-(void)showView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = CGRectMake(0, MAX_HEIGHT - (MAX_HEIGHT/2.5), MAX_WIDTH, (MAX_HEIGHT/2.5));
    
    } completion:^(BOOL blfinished){
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    }];
}


- (void)hideView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = CGRectMake(0, MAX_HEIGHT, MAX_WIDTH, (MAX_HEIGHT/2.5));
    
    } completion:^(BOOL blfinished){
    
        [self removeFromSuperview];
    }];
}



@end
