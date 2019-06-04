//
//  CCWContactTableViewCell.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/20.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCWContactTableViewCell : UITableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;
/** 联系人 */
@property (nonatomic, strong) CCWContactModel *contactModel;
@end
