//
//  CCWPropAssetsTableViewCell.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWPropAssetsTableViewCell.h"

@interface CCWPropAssetsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *NHAssetIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *worldViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *passAssetsLabel;

@end

@implementation CCWPropAssetsTableViewCell

/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWPropAssetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWPropAssetsTableViewCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

// 出售资产
- (IBAction)sellNHAssetClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(CCWPropAssetCellSellClick:)]) {
        [self.delegate CCWPropAssetCellSellClick:self];
    }
}

- (void)setNhAssetModel:(CCWNHAssetsModel *)nhAssetModel
{
    _nhAssetModel = nhAssetModel;
    self.NHAssetIDLabel.text = [NSString stringWithFormat:@"ID:%@",nhAssetModel.ID];
    self.passAssetsLabel.text = [NSString stringWithFormat:@"%@%@",CCWLocalizable(@"通行资产:"),nhAssetModel.asset_qualifier];
    self.worldViewLabel.text = [NSString stringWithFormat:@"%@:%@",CCWLocalizable(@"世界观"),nhAssetModel.world_view];
}

@end
