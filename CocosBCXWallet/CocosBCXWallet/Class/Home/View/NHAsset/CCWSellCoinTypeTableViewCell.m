//
//  CCWSellCoinTypeTableViewCell.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWSellCoinTypeTableViewCell.h"

@implementation CCWSellCoinTypeTableViewCell

/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWSellCoinTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWSellCoinTypeTableViewCell class]) owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
