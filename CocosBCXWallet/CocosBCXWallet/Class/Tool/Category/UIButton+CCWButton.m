//
//  UIButton+CCWButton.m
//  CocosWallet
//
//  Created by SYL on 2018/11/16.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "UIButton+CCWButton.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation UIButton (CCWButton)
// 封装的SDWebImageView
- (void)CCW_SetImageWithURL:(NSString *)urlString
{
    [self sd_setImageWithURL:URLFromString(urlString) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ccwplaceholder"]];
}

@end
