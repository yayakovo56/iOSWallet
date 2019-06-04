//
//  CCWTransferRecordTableView.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/22.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWTransferRecordTableView.h"

@implementation CCWTransferRecordTableView

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *rectangleCorner = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CCWScreenW, 180) cornerRadius:0];
    [[UIColor getColor:@"D2D9F3"] setFill];
    [rectangleCorner fill];
}

@end
