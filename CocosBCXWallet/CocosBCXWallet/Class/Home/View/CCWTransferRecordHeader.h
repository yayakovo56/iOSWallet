//
//  CCWTransferRecordHeader.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CCWTransferRecordHeader,CCWAssetsModel;

@protocol CCWTransferRecordHeaderDelegate <NSObject>
/** 点击复制地址 */
- (void)transferRecordHeaderCopyAddressClick:(CCWTransferRecordHeader *)headerView;
/** 点击转账 */
- (void)transferRecordHeaderTransferClick:(CCWTransferRecordHeader *)headerView;
/** 点击收款 */
- (void)transferRecordHeaderReceivClick:(CCWTransferRecordHeader *)headerView;
@end

@interface CCWTransferRecordHeader : UIView

@property (nonatomic, weak) id <CCWTransferRecordHeaderDelegate> delegate;

/** 初始化方法 */
+ (instancetype)transferRecordHeader;

/** 数量 */
@property (nonatomic, strong) CCWAssetsModel *assetsModel;
@end

NS_ASSUME_NONNULL_END
