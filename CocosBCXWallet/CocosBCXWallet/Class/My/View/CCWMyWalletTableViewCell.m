//
//  CCWMyWalletTableViewCell.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/4/11.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWMyWalletTableViewCell.h"

@interface CCWMyWalletTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *currentButton;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@end

@implementation CCWMyWalletTableViewCell

/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWMyWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWMyWalletTableViewCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setWalletAccountModel:(CCWWalletAccountModel *)walletAccountModel
{
    _walletAccountModel = walletAccountModel;
    self.nameLabel.text = walletAccountModel.dbAccountModel.name;
    if ([walletAccountModel.dbAccountModel.name isEqualToString:CCWAccountName]) {
        self.currentButton.hidden = NO;
    }else{
        self.currentButton.hidden = YES;
    }
    self.amountLabel.text = [CCWDecimalTool CCW_decimalSubScaleString:[NSString stringWithFormat:@"%@",self.walletAccountModel.cocosAssets.amount] scale:5];
    self.symbolLabel.text = walletAccountModel.cocosAssets.symbol;
}

- (IBAction)makeAddress:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(walletTableViewCellCopyAddressClick:)]) {
        [self.delegate walletTableViewCellCopyAddressClick:self];
    }

}

@end
