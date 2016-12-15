//
//  COMyAlbumViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyWXCollectionViewController.h"
#import "COMyWXCollectionTableViewModel.h"
#import "COMyWXCollectionDetailViewController.h"

@interface COMyWXCollectionViewController() <UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    FCXRefreshHeaderView *headerRefreshView;
}

@property (nonatomic, strong)UITableView *mytableView;
@property (nonatomic, strong)COMyWXCollectionTableViewModel *collectionTableViewModel;


@end

@implementation COMyWXCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:backGroundColor];
    
    [self.view addSubview:self.mytableView];
    
    [self setNavigationBar];
    
    [self addUIConstriants];
    
    [self addHeadRefreshView];
    
    [SVProgressHUD ShowWaitMsg:@"正在加载"];
    
    [self fetchCollectionData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)setNavigationBar
{
    UIBarButtonItem *navigativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navigativeSeperator.width = -10;//此处修改到边界的距离，请自行测试
    
    UIBarButtonItem *iconItem = [[UIBarButtonItem alloc] initWithNormalIcon:@"goback" highlightedIcon:nil target:self action:@selector(backBtnClicked:)];
    
    if(ISIOS7)
    {
        self.navigationItem.leftBarButtonItems = @[navigativeSeperator, iconItem];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = iconItem;
    }
    
    [self setTitle:@"我的精选"];
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UI layout

- (void)addUIConstriants
{
    
    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.edges.equalTo(self.view);
        
    }];
    
}

- (void)addHeadRefreshView
{
    WEAK_SELF(weakself)
    headerRefreshView = [self.mytableView addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        
        //refresh action
        
        [weakself fetchCollectionData];
        
    }];
}

#pragma mark lazy load

- (UITableView *)mytableView
{
    if(_mytableView == nil)
    {
        _mytableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
        _mytableView.emptyDataSetSource = self;
        _mytableView.emptyDataSetDelegate = self;
    }
    
    return _mytableView;
}

- (COMyWXCollectionTableViewModel *)collectionTableViewModel
{
    if(_collectionTableViewModel == nil)
    {
        _collectionTableViewModel = [[COMyWXCollectionTableViewModel alloc] init];
    }
    
    return _collectionTableViewModel;
}

#pragma mark function

- (void)fetchCollectionData
{
    WEAK_SELF(weakself)
    
    [self.collectionTableViewModel requestWXCollectionModelWithCompletion:^(BOOL blfinished) {
       
        [SVProgressHUD hideWait];
        __weak FCXRefreshHeaderView *weakHeaderView = headerRefreshView;
        
        [weakHeaderView endRefresh];
        
        if(blfinished)
        {
            [weakself.mytableView reloadData];
        }
        
    }];
}


#pragma mark tableViewdatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.collectionTableViewModel numbersOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionTableViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}


#pragma mark uitableviewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionTableViewModel heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [self.collectionTableViewModel tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"url is %@", url);
    
    COMyWXCollectionDetailViewController *detailVC = [[COMyWXCollectionDetailViewController alloc] initWithURL:url];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark DZNEmptyDataSetSource delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    text = @"数据未更新";
    font = [UIFont boldSystemFontOfSize:17.0];
    textColor = UIColorFromRGB(0x25282b);
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    text = @"我的精选文章还未更新，先休息一下吧";
    font = [UIFont systemFontOfSize:14.5];
    textColor = UIColorFromRGB(0x7b8994);
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    
    return attributedString;
    
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *imageName = [NSString stringWithFormat:@"placeholder_dropbox"];
    
    return [UIImage imageNamed:imageName];
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}





@end
