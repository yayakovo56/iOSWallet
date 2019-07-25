//
//  CCWSellCoinTypeTableViewCell.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCWAssetsModel;

NS_ASSUME_NONNULL_BEGIN

@interface CCWSellCoinTypeTableViewCell : UITableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;

@property (nonatomic, strong) CCWAssetsModel *assetModel;
@end

NS_ASSUME_NONNULL_END
