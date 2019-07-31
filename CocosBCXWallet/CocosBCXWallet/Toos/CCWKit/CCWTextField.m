//
//  CCWTextField.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/20.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWTextField.h"

@implementation CCWTextField

// 语言适配
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.placeholder = CCWLocalizable(self.placeholder);
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end
