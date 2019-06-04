//
//  CCWFindButton.m
//  YLTouch
//
//  Created by 邵银岭 on 16/7/26.
//  Copyright © 2016年 SYLing. All rights reserved.
//

#import "CCWFindButton.h"

@interface CCWFindButton ()


@end

@implementation CCWFindButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

/**
 *  重写这个方法的目的：去掉父类在highlighted时做的一切操作
 */
- (void)setHighlighted:(BOOL)highlighted {}

-(void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = CCWFont(14);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor getColor:@"262A33"] forState:UIControlStateNormal];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame) + 7;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 20;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat WH = 44;
    CGFloat margin_X = (CGRectGetWidth(contentRect) - WH)  / 2;
    return CGRectMake(margin_X, 16, WH, WH);
}

@end
