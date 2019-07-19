//
//  CCWPropAssetsTableViewCell.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWNHAssetsModel.h"

NS_ASSUME_NONNULL_BEGIN
@class CCWPropAssetsTableViewCell;

@protocol CCWPropAssetsCellDelegate <NSObject>

- (void)CCWPropAssetCellSellClick:(CCWPropAssetsTableViewCell *)propAssetCell;

@end

@interface CCWPropAssetsTableViewCell : UITableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;
/** 代理 */
@property (nonatomic, weak) id<CCWPropAssetsCellDelegate> delegate;

/** 资产模型 */
@property (nonatomic, strong) CCWNHAssetsModel *nhAssetModel;
@end

NS_ASSUME_NONNULL_END
