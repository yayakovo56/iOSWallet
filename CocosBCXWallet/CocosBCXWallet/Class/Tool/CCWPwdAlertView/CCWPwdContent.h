//
//  CCWPwdContent.h
//  CCWPwdAlertViewDemo
// 

#import <UIKit/UIKit.h>

@interface CCWPwdContent : UIView

+ (instancetype)contentViewCancelClick:(void (^)(void))cancel confirmClick:(void (^)(NSString *pwd, BOOL isIgnoreConfirm))confirm;

@end
