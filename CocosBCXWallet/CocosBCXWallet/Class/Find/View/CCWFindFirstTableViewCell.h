//
//  CCWFindFirstTableViewCell.h
//  CocosWallet
//
//  Created by SYL on 2018/11/16.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWDappModel.h"

// 轮播图的高度
#define FindCellScrollHeight 140
// 四个导航按钮的高度
#define FindHeadButtonHeight 107
#define FindSuspenHeight (FindCellScrollHeight + FindHeadButtonHeight + 27 + 4) + 5

@class CCWFindFirstTableViewCell;

@protocol CCWFindFirstTableViewCellDelegate <NSObject>
// 点击按钮
- (void)CCW_FindFirstCellClickNavButtonWithTableViewCell:(CCWFindFirstTableViewCell *)tableViewCell button:(UIButton *)button;
// 点击轮播图
- (void)CCW_FindFirstCellClickCarouselViewWithTableViewCell:(CCWFindFirstTableViewCell *)tableViewCell butclickImageAtIndex:(NSInteger)index;
@end

@interface CCWFindFirstTableViewCell : UITableViewCell

/** 初始化方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier;

// 设置数据
- (void)setFirstCellWithCarouselImageArray:(NSArray *)imageArray dappModelArray:(NSArray <CCWDappModel *>*)dappArray;

/** 代理 */
@property(nonatomic,weak)id<CCWFindFirstTableViewCellDelegate> delegate;

@end
