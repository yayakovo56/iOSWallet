//
//  CCWButton.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWButton.h"

@implementation CCWButton

// 语言适配
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTitle:CCWLocalizable(self.titleLabel.text) forState:UIControlStateNormal];
}

@end
