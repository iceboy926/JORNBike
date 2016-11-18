//
//  COAuthCodeView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/31.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COAuthCodeView.h"

#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0]


@interface COAuthCodeView()

@property (nonatomic, strong) NSArray *authCodeArray;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation COAuthCodeView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        //self.layer.cornerRadius = 5.0;
        //self.layer.masksToBounds = YES;
        self.backgroundColor = shadowViewColor;
        [self genAuthCode];
    }
    
    return self;
}

- (void)genAuthCode
{
    _dataArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
    _authCodeStr = [[NSMutableString alloc] initWithCapacity:4];
    
    for (int i = 0; i < 4; i++) {
        
        NSInteger index = arc4random()%(_dataArray.count-1);
        
        NSString *codestr = [_dataArray objectAtIndex:index];
        
        _authCodeStr = (NSMutableString *)[_authCodeStr stringByAppendingString:codestr];
        
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self genAuthCode];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //根据要显示的验证码字符串，根据长度，计算每个字符串显示的位置
    NSString *text = [NSString stringWithFormat:@"%@",_authCodeStr];
    
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSObliquenessAttributeName:@1}];
    
    CGFloat width = rect.size.width/text.length - cSize.width;
    CGFloat height = rect.size.height - cSize.height;
    
    CGPoint point;
    
 
    
    //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
    CGFloat pX,pY;
    for ( int i = 0; i<text.length; i++)
    {
        pX = width/4.0 + rect.size.width/text.length * i;
        pY = height/2.0;//arc4random() % height;
        point = CGPointMake(pX, pY);
        
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(1, 1);
        shadow.shadowBlurRadius = 3.0;
        shadow.shadowColor = kRandomColor;
        
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0], NSForegroundColorAttributeName:kRandomColor, NSObliquenessAttributeName:@1,  NSStrokeWidthAttributeName:@3, NSStrokeColorAttributeName:kRandomColor}];
    }

}

- (NSString *)getCode
{
    return [NSString stringWithString:_authCodeStr];
}


@end
