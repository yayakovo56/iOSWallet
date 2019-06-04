//
//  CCWPageControl.m
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/5.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import "CCWPageControl.h"
// 圆点间距
#define margin 4
// 圆点宽度
#define activeDotW 9

@implementation CCWPageControl

- (void)layoutSubviews
{
    [super layoutSubviews];

    //计算整个pageControll的宽度
//    CGFloat newW = self.subviews.count * (margin +  activeDotW) - margin;
    //设置新frame
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
//    //设置居中
//    CGPoint center = self.center;
//    center.x = self.superview.center.x;
//    self.center = center;
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView *dot = [self.subviews objectAtIndex:i];
        [dot setFrame:CGRectMake(i * (margin + activeDotW), dot.frame.origin.y, activeDotW, 3)];
    }
}

@end
