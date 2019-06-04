//
//  CCWTransferInfoTableViewCell.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/21.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWTransferInfoTableViewCell.h"

@interface CCWTransferInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *transferTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tansferInfoLabel;

@end

@implementation CCWTransferInfoTableViewCell

/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWTransferInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWTransferInfoTableViewCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.transferTitleLabel.font = iPhone5?CCWFont(13):CCWFont(15);
    self.tansferInfoLabel.font = iPhone5?CCWFont(13):CCWFont(15);
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    self.transferTitleLabel.text = dataDic[@"title"];
    self.tansferInfoLabel.text = dataDic[@"info"];
}

@end
