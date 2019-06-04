//
//  CCWLabel.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWLabel.h"

@implementation CCWLabel

// 语言适配
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.text = CCWLocalizable(self.text);
}

@end
