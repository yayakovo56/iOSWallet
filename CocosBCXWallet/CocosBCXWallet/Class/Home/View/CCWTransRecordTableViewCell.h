//
//  CCWTransRecordTableViewCell.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/14.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWTransRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWTransRecordTableViewCell : UITableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;

/** 转账记录 */
@property (nonatomic, strong) CCWTransRecordModel *transRecordModel;
@end

NS_ASSUME_NONNULL_END
