//
//  CCWWalletNavButton.m
//  CocosWallet
//
//  Created by zhangxiaoliang on 2018/11/22.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWWalletNavButton.h"

@implementation CCWWalletNavButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 *  重写这个方法的目的：去掉父类在highlighted时做的一切操作
 */
- (void)setHighlighted:(BOOL)highlighted {}

-(void)setup{
    self.titleLabel.font = CCWFont(14);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame) + 10;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 20;//contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat height = 24;
    CGFloat width = 28;
    CGFloat margin_X = (CGRectGetWidth(contentRect) - width)  / 2;
    return CGRectMake(margin_X, 28, width, height);
}
@end
