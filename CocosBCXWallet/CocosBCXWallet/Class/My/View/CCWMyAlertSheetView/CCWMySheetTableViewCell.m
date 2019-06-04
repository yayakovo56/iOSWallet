//
//  LYTAlertSheetTableViewCell.m
//  CocosWallet
//
//  Created by 邵银岭 on 2018/11/28.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import "CCWMySheetTableViewCell.h"

@interface CCWMySheetTableViewCell()

@end
@implementation CCWMySheetTableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle WithIdentifier:(NSString *)identifier
{
    CCWMySheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWMySheetTableViewCell class]) owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
