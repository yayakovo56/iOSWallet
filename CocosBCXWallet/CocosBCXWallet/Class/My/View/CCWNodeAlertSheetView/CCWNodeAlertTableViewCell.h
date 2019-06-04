//
//  CCWNodeAlertTableViewCell.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/6/3.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWDataBase+CCWNodeINfo.h"

NS_ASSUME_NONNULL_BEGIN

@class CCWNodeAlertTableViewCell;
@protocol CCWNodeAlertTableViewCellDelegate <NSObject>

- (void)CCW_NodeAlertCell:(CCWNodeAlertTableViewCell *)alertCell nodeInfo:(CCWNodeInfoModel *)nodeInfoModel;

@end

@interface CCWNodeAlertTableViewCell : UITableViewCell
/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;
@property (weak, nonatomic) IBOutlet UIImageView *coinTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nodeLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic, strong) CCWNodeInfoModel *nodeInfoModel;

@property (nonatomic, weak) id<CCWNodeAlertTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
