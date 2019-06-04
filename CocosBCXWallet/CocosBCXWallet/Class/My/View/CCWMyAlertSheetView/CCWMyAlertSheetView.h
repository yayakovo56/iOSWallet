//
//  CCWMyAlertSheetView.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/11/28.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCWMyAlertSheetView;
@protocol CCWMyAlertSheetViewDelegate <NSObject>

- (void)CCW_MyAlertSheetView:(CCWMyAlertSheetView *)alertSheetView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CCWMyAlertSheetView : UIView

- (void)CCW_Show;

@property (nonatomic ,weak) id<CCWMyAlertSheetViewDelegate> delegate;
@end
