//
//  UIView+EmptyView.h
//  YiBiFen
//
//  Created by caohuihui on 15/12/11.
//  Copyright © 2015年 hhly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYBlankPageView;

@interface UIView (EmptyView)
/**
 *  提示框
 *  @param hasData       是否有数据？
 *  @param title         没有数据时候的标题
 *  @param hasError      是否有网络错误
 *  @param block         网络错误时候的block 刷新回调
 */
- (void)configWithHasData:(BOOL)hasData noDataTitle:(NSString *)title hasError:(BOOL)hasError reloadBlock:(void(^)(id sender))block;

/**
 无数据显示

 @param hasData       是否有数据？
 @param image         没有数据时候的图片
 @param title         没有数据时候的标题
 @param hasError      是否有网络错误
 @param block         网络错误时候的block 刷新回调
 */
- (void)configWithHasData:(BOOL)hasData noDataImage:(UIImage *)image noDataTitle:(NSString *)title hasError:(BOOL)hasError reloadBlock:(void (^)(id sender))block;

@property (strong, nonatomic) LYBlankPageView *blankPageView;

@end

@interface LYBlankPageView : UIView

// 图片
@property (strong,nonatomic)UIImageView *logoView;
// 标题
@property (nonatomic,strong)UILabel *tipLabel;
// 按钮
@property (nonatomic,strong)UIButton *reloadButton;

@property (nonatomic,copy) void (^reloadButtonBlock)(id sender);


@end
