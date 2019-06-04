//
//  CCWAlertController.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>

/******************************************************************/

/**
 *  按钮样式

 - CCWAlertActionStyleDefault:     普通按钮
 - CCWAlertActionStyleCancel:      取消按钮
 - CCWAlertActionStyleDestructive: 警告性按钮
 */
typedef NS_ENUM(NSInteger, CCWAlertActionStyle) {
    CCWAlertActionStyleDefault = 0,
    CCWAlertActionStyleCancel,
    CCWAlertActionStyleDestructive
} ;

/**
 *  弹框模式

 - CCWAlertControllerStyleActionSheet: 底部弹框
 - CCWAlertControllerStyleAlert:       频幕中间弹框
 */
typedef NS_ENUM(NSInteger, CCWAlertControllerStyle) {
    CCWAlertControllerStyleActionSheet = 0,
    CCWAlertControllerStyleAlert
} ;

/*********************************************************************/

@interface CCWAlertAction : NSObject

+ (instancetype)CCW_actionWithTitle:(NSString *)title style:(CCWAlertActionStyle)style handler:(void (^)(CCWAlertAction *action))handler;

@end

/********************************************************************/
@protocol CCWAlertControllerDelegate <NSObject>
@optional
// 自定义标题栏
- (UIView *)titleView:(UILabel *)oringeTitle;

// 自定义消息栏
- (UIView *)messageView:(UILabel *)oringeMessage;

// 点击了蒙版 是否要退出弹框
- (BOOL)shoudDismissAlertWhenDidClickAlertView;

// 添加其他视图
- (UIView *)alertOtherViewForAlert:(UIView *)backgroundView;
// 其他视图
- (UIView *)alertOtherViewForAlert:(UIView *)backgroundView alertView:(UIView *)alertView;

@end

/******************************************************************/

@interface CCWAlertController : UIViewController


/**
 *  数据源（自定义标题、消息栏）// 这里使用strong 防止delegate 是栈区变量 alert控制器需要代理实现的方法 进行操作时代理已经被销毁 由于该警示提示框控制器没有被销毁 alert依赖代理的操作必须由代理实现 例如退出控制器操作
 */
@property(nonatomic,strong) id<CCWAlertControllerDelegate> delegate;


/**
 *  快速创建类方法

 @param title          标题
 @param message        消息栏
 @param preferredStyle 展示样式

 @return 实例化对象
 */
+ (instancetype)CCW_alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(CCWAlertControllerStyle)preferredStyle;


/**
 *  添加点击的事件

 @param action 点击的事件
 */
- (void)CCW_addAction:(CCWAlertAction *)action;

/**
 *  批量添加点击事件

 @param actions 点击事件的集合
 */
- (void)CCW_addActions:(NSArray <CCWAlertAction *> *)actions;

#pragma mark - pererence setting
/** 背景底部颜色  默认是透明度为0.6黑色 */
@property (nonatomic,strong) UIColor * alertBackgroundColor;
/** alert color */
@property (nonatomic,strong) UIColor * alertColor;
/** title color */
@property (nonatomic,strong) UIColor * titleColor;
/** message color */
@property (nonatomic,strong) UIColor * messageColor;

/** action background color */
@property (nonatomic,strong) UIColor * actionBackgroundColor;
/** action color */
@property (nonatomic,strong) UIColor * actionNormalColor;
/** action color */
@property (nonatomic,strong) UIColor * actionHighlightColor;
/** action cacel color */
@property (nonatomic,strong) UIColor * actionCancelColor;
/** action cacel color */
@property (nonatomic,strong) UIColor * actionCancelHighlightColor;
/** action destruct color */
@property (nonatomic,strong) UIColor * actionDestructColor;
/** action destruct color */
@property (nonatomic,strong) UIColor * actionDestructHighlightColor;

#pragma mark sheet
/** sheetActionHight 默认 44.0f */
@property(nonatomic,assign) CGFloat sheetActionHight;
/** sheetActionCornerRadii 默认 0 */
@property(nonatomic,assign) CGFloat sheetActionCornerRadii;
/** sheetActionBorderWidth 默认 0 */
@property(nonatomic,assign) CGFloat sheetActionBorderWidth;
/** sheetActionBorderColor 默认为按钮文字的颜色 */
@property (nonatomic,strong) UIColor * sheetActionBorderColor;
/** sheetActionContenInsets 默认（top:0,left:0,bottom:0,right:0） */
@property(nonatomic,assign) UIEdgeInsets sheetActionContenInsets;
/** sheetSectionContenInsets 默认（top:0,left:0,bottom:20,right:0） */
@property(nonatomic,assign) UIEdgeInsets sheetSectionContenInsets;

@end
