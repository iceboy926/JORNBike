//
//  COMyFavorViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/14.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyFavorViewController.h"
#import "COMenuShowView.h"

@interface COMyFavorViewController() <UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) COMenuShowView *menuView;

@end

@implementation COMyFavorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:backGroundColor];
    
    [self setNavigationBar];
    
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewAction:)];
    
    [self.view addGestureRecognizer:gesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addUIConstriants];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self ClearUI];
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
    
    UIButton *buttonTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [buttonTitle setFrame:CGRectMake(0, 0, 80, 44)];
    [buttonTitle setTitle:@"我的收藏" forState:UIControlStateNormal];
    [buttonTitle setBackgroundColor:[UIColor clearColor]];
    [buttonTitle addTarget:self action:@selector(titleViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    

    [self.navigationItem setTitleView:buttonTitle];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithNormalIcon:@"cancel" highlightedIcon:nil target:self action:@selector(rightItemBtnClicked:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)titleViewButtonClicked:(UIButton *)sender
{
    if(![self.menuView blShow])
    {
        [self.menuView showMenuView];
    }
    else
    {
        [self.menuView disMissMenuView];
    }
}

- (void)rightItemBtnClicked:(id)sender
{
    
}

- (void)touchViewAction:(UITapGestureRecognizer *)gesture
{
    [self ClearUI];
}


- (void)ClearUI
{
    if([self.menuView blShow])
    {
        [self.menuView disMissMenuView];
    }
    
    
}


#pragma mark ui lay out

- (void)addUIConstriants
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
        
    }];
}


#pragma mark lazy load

- (COMenuShowView *)menuView
{
    if(_menuView == nil)
    {
        NSArray *arrayData = @[@"默认收藏", @"我的分组1", @"我的分组2"];
        _menuView = [[COMenuShowView alloc] initWithFrame:CGRectMake(MAX_WIDTH/2.0 - (MAX_WIDTH/4.0), 64, MAX_WIDTH/2.0, 0) items:arrayData];
    }
    
    return _menuView;
}

- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
    
        _tableView.emptyDataSetDelegate = self;
        
        _tableView.emptyDataSetSource = self;
    }
    
    return _tableView;
}

#pragma mark UITableViewDataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;

}


#pragma mark DZNEmptyDataSetSource delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    text = @"Star Your Favorite Files";
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
    
    text = @"Favorites are saved for offline access.";
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
