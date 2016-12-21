//
//  COMyFunnyCell.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/12/19.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COMyFunnyCell.h"
#import "COMyJokeModel.h"
#import "NTImageBrowser.h"

#define  ImageWidth    120
#define  ImageHeight   120


@interface COMyFunnyCell()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *funnyImageView;
@property (nonatomic, strong) UIView    *horizonLineView;

@end


@implementation COMyFunnyCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.funnyImageView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.horizonLineView];
        
        [self addUIConstriants];
        
    }
    
    return self;
}

- (void)addUIConstriants
{
    CGFloat leftPadding = 15;
    CGFloat rightPadding = leftPadding;
    CGFloat topPadding = 5.0;
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(topPadding, leftPadding, 0, rightPadding));
        
        make.height.mas_equalTo(30);
        
    }];
    
    [self.funnyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(leftPadding);
        make.top.equalTo(_contentLabel.mas_bottom).offset(topPadding);
        make.size.mas_equalTo(CGSizeMake(ImageWidth, ImageHeight));
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_contentLabel.mas_right);
        make.top.equalTo(_funnyImageView.mas_bottom).offset(topPadding);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.horizonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentLabel.mas_left);
        make.right.equalTo(_contentLabel.mas_right);
        make.top.equalTo(_timeLabel.mas_bottom).offset(2);
        make.height.mas_equalTo(1.0);
        
    }];
}

- (void)addImageVCGestureRecognation
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self.funnyImageView action:@selector(imageTouchAction:)];
    
    [self.funnyImageView addGestureRecognizer:gesture];
}

- (void)imageTouchAction:(UITapGestureRecognizer *)gesture
{
    UIImageView *imageView = (UIImageView *)gesture.view;
    [NTImageBrowser showImageBrowserWithImageView:imageView];
}


+ (COMyFunnyCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifierStr = @"funnycell";
    
    COMyFunnyCell *funnycell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierStr];
    if(funnycell == nil)
    {
        funnycell = [[COMyFunnyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierStr];
    }
    
    return funnycell;
}

+ (CGFloat)heightForCellModel:(COMyJokeModel *)funnyModel
{
    CGFloat heightCell = 0.0;
    
    CGRect rect = [funnyModel.contentStr boundingRectWithSize:CGSizeMake(MAX_WIDTH - 30, MAX_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]} context:nil];
    
    heightCell = 5;
    
    heightCell += rect.size.height;
    
    heightCell += 5;
    
    heightCell += ImageHeight;
    
    heightCell += 5;
    
    heightCell += 30;
    
    heightCell += 5;
    
    
    return heightCell;
}


#pragma mark lazy load

- (UILabel *)contentLabel
{
    if(_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc] init];
        
        _contentLabel.font = [UIFont systemFontOfSize:15.0];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}

- (UIImageView *)funnyImageView
{
    if(_funnyImageView == nil)
    {
        _funnyImageView = [[UIImageView alloc] init];
        
        _funnyImageView.userInteractionEnabled = YES;
        
    }
    
    return _funnyImageView;
}

- (UILabel *)timeLabel
{
    if(_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc] init];
        
        _timeLabel.font = [UIFont systemFontOfSize:13.0];
        _timeLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _timeLabel;
}

- (UIView *)horizonLineView
{
    if(_horizonLineView == nil)
    {
        _horizonLineView = [[UIView alloc] init];
    
        _horizonLineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    
    return _horizonLineView;
}


#pragma mark member function

- (void)setFunnyModel:(COMyJokeModel *)funnyModel
{
    _funnyModel = funnyModel;
    
    //title
    self.contentLabel.text = [NSString replaceUnicode:funnyModel.contentStr];
    
    CGRect rect = [funnyModel.contentStr boundingRectWithSize:CGSizeMake(MAX_WIDTH - 30, MAX_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]} context:nil];
    
    [self updateContentLabelConstriants:rect.size];
    
    
    //image
    
    WEAK_SELF(weakself)
    [self.funnyImageView sd_setImageWithURL:[NSURL URLWithString:funnyModel.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder_60x60"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        //
        CGSize imageRect = image.size;
        
        NSLog(@"image size is [%f, %f]", imageRect.width, imageRect.height);
        
        [weakself updateFunnyImageConstriants:imageRect];
        
    }];
    

    //time
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[funnyModel.unixtimeStr doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    self.timeLabel.text = confromTimespStr;
    
    
    
}

- (void)updateContentLabelConstriants:(CGSize)textSize
{
    WEAK_SELF(weakself)
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(textSize.height);
        
        [weakself layoutSubviews];
    }];
    
}

- (void)updateFunnyImageConstriants:(CGSize)imageSize
{
    CGSize newSize;
    
    if(imageSize.width > ImageWidth || imageSize.height > ImageHeight)
    {
        CGFloat widthScal = imageSize.width/ImageWidth;
        CGFloat heightScal = imageSize.height/ImageHeight;
        
        //CGFloat  maxScal = MAX(widthScal, heightScal);
        
        CGFloat scal = imageSize.width/imageSize.height;
        
        
        
        newSize.width = ImageWidth *scal;
        newSize.height = ImageHeight;
        
    }
    else
    {
        newSize = imageSize;
    }
    
    WEAK_SELF(weakself)
    [self.funnyImageView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(newSize);
        
        [weakself layoutSubviews];
        
    }];
}


@end
