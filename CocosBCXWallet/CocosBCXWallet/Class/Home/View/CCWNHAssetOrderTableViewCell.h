//
//  CCWNHAssetOrderTableViewCell.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWNHAssetOrderModel.h"

NS_ASSUME_NONNULL_BEGIN
@class CCWNHAssetOrderTableViewCell;

@protocol CCWPropOrderCellDelegate <NSObject>

- (void)CCWPropOrderCellbuyClick:(CCWNHAssetOrderTableViewCell *)propOrderCell;

@end

@interface CCWNHAssetOrderTableViewCell : UITableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;

@property (nonatomic, strong) CCWNHAssetOrderModel *nhAssetOrderModel;

@property (nonatomic, weak) id<CCWPropOrderCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
