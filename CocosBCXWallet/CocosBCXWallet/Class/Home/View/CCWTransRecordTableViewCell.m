//
//  CCWTransRecordTableViewCell.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWTransRecordTableViewCell.h"

@interface CCWTransRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *transferTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *transferAccountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferCountLabel;

@end

@implementation CCWTransRecordTableViewCell

/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWTransRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWTransRecordTableViewCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setTransRecordModel:(CCWTransRecordModel *)transRecordModel
{
    _transRecordModel = transRecordModel;
    CCWOperation *operation = transRecordModel.operation;
    
    if ([transRecordModel.from isEqualToString:CCWAccountName]) {
        self.transferAccountNameLabel.text = transRecordModel.to;
        self.transferTypeImageView.image = [UIImage imageNamed:@"transfer_out"];
        self.transferCountLabel.textColor = [UIColor getColor:@"4868DC"];
        self.transferCountLabel.text = [NSString stringWithFormat:@"-%@ %@",operation.amount.amount,operation.amount.symbol];
    }else{
        self.transferAccountNameLabel.text = transRecordModel.from;
        self.transferTypeImageView.image = [UIImage imageNamed:@"transfer_in"];
        self.transferCountLabel.textColor = [UIColor getColor:@"2FC49F"];
        self.transferCountLabel.text = [NSString stringWithFormat:@"+%@ %@",operation.amount.amount,operation.amount.symbol];
    }
    self.transferTimeLabel.text = transRecordModel.timestamp;
}
@end
