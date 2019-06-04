//
//  CCWMyWalletTableViewCell.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/4/11.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWWalletAccountModel.h"

@class CCWMyWalletTableViewCell;

NS_ASSUME_NONNULL_BEGIN
@protocol CCWMyWalletTableViewCellDelegate <NSObject>
/** 点击复制地址 */
- (void)walletTableViewCellCopyAddressClick:(CCWMyWalletTableViewCell *)cell;
@end


@interface CCWMyWalletTableViewCell : UITableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;

@property (nonatomic, strong) CCWWalletAccountModel *walletAccountModel;

@property (nonatomic, weak) id<CCWMyWalletTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
