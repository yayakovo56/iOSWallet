//
//  CCWMyAlertSheetView.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/11/28.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCWNodeAlertSheetView;
@protocol CCWNodeAlertViewDelegate <NSObject>

- (void)CCW_NodeAlertSheetView:(CCWNodeAlertSheetView *)alertSheetView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

// 添加自定义节点
- (void)CCW_NodeAlertSheetViewAddCustomNode:(CCWNodeAlertSheetView *)alertSheetView;

@end

@interface CCWNodeAlertSheetView : UIView

/** 显示 */
- (void)CCW_ShowWithDataArray:(NSMutableArray *)dataArray;

@property (nonatomic ,weak) id<CCWNodeAlertViewDelegate> delegate;
@end
