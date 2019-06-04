//
//  CCWWalletTableView.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/22.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWWalletTableView.h"

@implementation CCWWalletTableView

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *rectangleCorner = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CCWScreenW, 250) cornerRadius:0];
    [[UIColor getColor:@"616AC7"] setFill];
    [rectangleCorner fill];
}

@end
