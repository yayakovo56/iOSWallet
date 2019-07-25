//
//  CCWSellCoinTypeTableViewCell.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWSellCoinTypeTableViewCell.h"
#import "CCWAssetsModel.h"

@interface CCWSellCoinTypeTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *assetNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *assetIDLabel;
@property (nonatomic, weak) IBOutlet UIImageView *assetIconImageView;

@end

@implementation CCWSellCoinTypeTableViewCell

/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWSellCoinTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWSellCoinTypeTableViewCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setAssetModel:(CCWAssetsModel *)assetModel
{
    _assetModel = assetModel;
    self.assetNameLabel.text = assetModel.symbol;
    self.assetIDLabel.text = assetModel.ID;
    NSString *imageName = assetModel.selectAsset?@"languageSelect":@"languageNomal";
    self.assetIconImageView.image = [UIImage imageNamed:imageName];
}
@end
