//
//  CCWContactTableViewCell.m
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/20.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import "CCWContactTableViewCell.h"

@interface CCWContactTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end

@implementation CCWContactTableViewCell

/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWContactTableViewCell class]) owner:nil options:nil] lastObject];
    }
    return cell;
}

// 设置数据
- (void)setContactModel:(CCWContactModel *)contactModel
{
    _contactModel = contactModel;
    self.nameLabel.text = contactModel.name;
    if (![contactModel.note isEqualToString:@""]) {
        self.noteLabel.text = [NSString stringWithFormat:@"（%@）",contactModel.note];
    }
    self.addressLabel.text = contactModel.address;
}

@end
