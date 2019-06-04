//
//  CCWFindTableViewCell.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWDappModel.h"

@interface CCWFindTableViewCell : UITableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;

/** 数据模型 */
@property (nonatomic, strong) CCWDappModel *dappModel;

@end
