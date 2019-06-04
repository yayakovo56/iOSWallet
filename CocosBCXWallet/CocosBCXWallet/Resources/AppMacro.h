//
//  AppMacro.h
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/1/29.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

/** self的弱引用 */
#define CCWWeakSelf __weak typeof(self) weakSelf = self;

/********************    字体    **********************/
#define CCWFont(fontSize) [UIFont systemFontOfSize:fontSize]
#define CCWBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define CCWMediumFont(fontSize) [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium]

/********************    颜色    **********************/
// 按钮渐变色
#define CCWButtonBgColor [UIColor gradientColorFromColors:@[[UIColor getColor:@"6467CF"],[UIColor getColor:@"486BE0"]] gradientType:CCWGradientTypeLeftToRight colorSize:CGSizeMake(CCWScreenW, 50)]

#pragma mark -定义颜色的宏
#define CCWColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/256.0 green:(g)/256.0 blue:(b)/256.0 alpha:a]
#define CCWColor(r, g, b) CCWColorRGBA(r, g, b, 1.0)
// 随机色
#define  CCWRandomColor CCWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 主窗口
#define CCWKeyWindow [UIApplication sharedApplication].keyWindow

/********************    系统函数   **********************/
/// 状态栏高度
#define APP_StatusBar_Height [[UIApplication sharedApplication] statusBarFrame].size.height
/// 导航栏高度
#define APP_Navgationbar_Height (APP_StatusBar_Height + 44)
/// 标签栏高度
#define APP_Tabbar_Height [[(id)[UIApplication sharedApplication].keyWindow.rootViewController tabBar] frame].size.height
/// iPhone X 底部不安全高度
#define iPhoneXBottomNotSafeHeight  (IPHONE_X?34.0:0.0)

#pragma mark -手机屏幕尺寸
/******************** 手机屏幕尺寸 ********************/
#define CCWScreenH [UIScreen mainScreen].bounds.size.height
#define CCWScreenW [UIScreen mainScreen].bounds.size.width

/********************    判断是什么型号的手机    **********************/

// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6SP ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/********************    发布有关的设置    **********************/
#define AppBundleIdentifier                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define AppVersionNumber                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppName                                 [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]
#define DeviceName                              [[UIDevice currentDevice] name]
#define DeviceModel                             [[UIDevice currentDevice] systemName]
#define DeviceVersion                           [[UIDevice currentDevice] systemVersion]
#define DeviceOSVersionLater(version) ([[UIDevice currentDevice].systemVersion doubleValue] >= version)
#define DeviceUIIdiom                           [[UIDevice currentDevice] userInterfaceIdiom] // iPad iPhone
#define URLFromString(str)                      [NSURL URLWithString:str]
#define APIURLFormat(str)                       [NSString stringWithFormat:@"%@%@",API_Base_URL,str]


/********************    自定义打印的Log    **********************/
#ifdef DEBUG // 开发
#define CCWLog(...) NSLog(@"\n [Log输出文件名:%s] \n%s %d \n %@\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__FUNCTION__,__LINE__,[NSString stringWithFormat:__VA_ARGS__]);
#elif TEST // 测试
#define CCWLog(...) NSLog(@"\n [Log输出文件名:%s] \n%s %d \n %@\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__FUNCTION__,__LINE__,[NSString stringWithFormat:__VA_ARGS__]);
#else// 发布
#define CCWLog(...)
#endif

/********************    TODOMessage    **********************/
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]


/********************    弹窗    **********************/
/*! VC 用 TWVCShowAlertWithMsg */
#define CCWVCShowAlertWithMsg(__title__,msg) UIAlertController *alert = [UIAlertController alertControllerWithTitle:__title__ message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sureAction = [UIAlertAction actionWithTitle:CCWLocalizable(@"确认") style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:sureAction];\
[self presentViewController:alert animated:YES completion:nil];

// 有回调
#define CCWVCShowAlertWithMsgHandler(__title__,msg,__handler__) UIAlertController *alert = [UIAlertController alertControllerWithTitle:__title__ message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sureAction = [UIAlertAction actionWithTitle:CCWLocalizable(@"确认") style:UIAlertActionStyleDefault handler:__handler__];\
[alert addAction:sureAction];\
[self presentViewController:alert animated:YES completion:nil];

// 有回调,有取消
#define CCWVCShowAlertCancelWithMsgHandler(__title__,msg,__handler__) UIAlertController *alert = [UIAlertController alertControllerWithTitle:__title__ message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sureAction = [UIAlertAction actionWithTitle:CCWLocalizable(@"确认") style:UIAlertActionStyleDefault handler:__handler__];\
UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CCWLocalizable(@"取消") style:UIAlertActionStyleCancel handler:nil];\
[alert addAction:cancelAction];\
[alert addAction:sureAction];\
[self presentViewController:alert animated:YES completion:nil];

#import "CCWConstkey.h"
/********************    汇率计算公式    **********************/
#define CCWCNYORUSD [CCWSaveTool boolForKey:CCWCurrencyType]
/********************    汇率计算公式    **********************/


#endif /* AppMacro_h */
