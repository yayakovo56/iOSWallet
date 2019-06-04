//
//  CCWBaseAlert.m
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWBaseAlert.h"


@interface CCWBaseAlert ()
/**
 *  alertVc
 */
@property(nonatomic,strong) CCWAlertController *alertVc;

/**
 *  actions
 */
@property(nonatomic,strong) NSArray<CCWAlertAction *> *actions;

@end

@implementation CCWBaseAlert
#pragma mark - 弹出方法
- (void)alertWithController:(UIViewController *)formController {
    
    
    [self.alertVc CCW_addActions:self.actions];
    
    [formController presentViewController:self.alertVc animated:YES completion:nil];
    
}

/** 默认处理事件的弹窗 */
- (void)alertWithRootViewController {
    
    [self alertWithController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

/** 带有处理事件的弹窗 */
- (void)alertWithRootViewControllerAddAction:(NSArray<CCWAlertAction *> *)actions {
    
    [self.alertVc CCW_addActions:actions];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.alertVc animated:YES completion:nil];
}
#pragma mark - lazy load
- (CCWAlertController *)alertVc {
    
    if (!_alertVc) {
        _alertVc = [CCWAlertController CCW_alertControllerWithTitle:[self showWithTitle] message:[self showWithMessage] preferredStyle:[self showWithStyle]];
        _alertVc.delegate = self;
    }
    
    return _alertVc;
}
- (NSArray<CCWAlertAction *> *)actions {
    
    if (!_actions) {
        _actions = [self getActions];
    }
    
    return _actions;
}

#pragma 弹出的内容
#pragma mark - CCWBaseAlertDataSource
- (CCWAlertControllerStyle)showWithStyle {
    return CCWAlertControllerStyleAlert;
}

- (NSArray<CCWAlertAction *> *)getActions {
    
    return nil;
}

- (NSString *)showWithTitle {
    return nil;
}

- (NSString *)showWithMessage {
    return nil;
}

#pragma mark - 事件具体处理方法
- (void)disMiss {
    [self.alertVc dismissViewControllerAnimated:YES completion:nil];
}
@end
