//
//  CCWNodeAlertTableViewCell.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/6/3.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWNodeAlertTableViewCell.h"

@implementation CCWNodeAlertTableViewCell

/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWNodeAlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCWNodeAlertTableViewCell class]) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setNodeInfoModel:(CCWNodeInfoModel *)nodeInfoModel
{
    _nodeInfoModel = nodeInfoModel;
    self.titleLabel.text = nodeInfoModel.name;
    self.nodeLabel.text = nodeInfoModel.ws;
    self.deleteButton.hidden = !nodeInfoModel.isSelfSave;

    CCWNodeInfoModel *saveNodelInfo = [CCWNodeInfoModel mj_objectWithKeyValues:CCWNodeInfo];
    if ([saveNodelInfo.ws isEqualToString:nodeInfoModel.ws] && [saveNodelInfo.chainId isEqualToString:nodeInfoModel.chainId] && [saveNodelInfo.faucetUrl isEqualToString:nodeInfoModel.faucetUrl] && [saveNodelInfo.coreAsset isEqualToString:nodeInfoModel.coreAsset]) {
        self.coinTypeImageView.image = [UIImage imageNamed:@"languageSelect"];
    }else{
        self.coinTypeImageView.image = [UIImage imageNamed:@"languageNomal"];
    }
}


// 删除节点
- (IBAction)deletaCustomNode
{
    if ([self.delegate respondsToSelector:@selector(CCW_NodeAlertCell:nodeInfo:)]) {
        [self.delegate CCW_NodeAlertCell:self nodeInfo:self.nodeInfoModel];
    }
}

@end
