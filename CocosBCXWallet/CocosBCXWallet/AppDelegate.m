//
//  AppDelegate.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/1/28.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "CCWNavigationController.h"

#import "CCWEncryptTool.h"
#import "CCWDataBase+CCWNodeINfo.h"

#import "Cocos_Key_Account.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}

- (void)createName:(NSString *)accountName addPassword:(NSString *)password withArray:(NSMutableArray *)array{
    NSString *owner = @"owner";
    NSString *active = @"active";
    NSString *ownerSeed = [NSString stringWithFormat:@"%@%@%@",accountName,owner,password];
    NSString *activeSeed = [NSString stringWithFormat:@"%@%@%@",accountName,active,password];
    NSString *owner_key = [Cocos_Key_Account private_with_seed:ownerSeed];
    NSString *active_key = [Cocos_Key_Account private_with_seed:activeSeed];
    NSString *owner_pubkey = [Cocos_Key_Account publicKey_with_seed:ownerSeed];
    NSString *active_pubkey = [Cocos_Key_Account publicKey_with_seed:activeSeed];
    
    NSDictionary *dic = @{
                          @"account":accountName,
                          @"password":password,
                          @"owner_key":owner_key,
                          @"active_key":active_key
                          };
    
    NSMutableDictionary *paramAccount = [NSMutableDictionary dictionary];
    paramAccount[@"name"] = accountName;
    paramAccount[@"owner_key"] = owner_pubkey;
    paramAccount[@"referror"] = @"";
    paramAccount[@"memo_key"] = active_pubkey;
    paramAccount[@"active_key"] = active_pubkey;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:paramAccount forKey:@"account"];
    [[CocosHTTPManager CCW_shareHTTPManager] CCW_POST:@"http://47.93.62.96:8041/api/v1/accounts" Param:param Success:^(id responseObject) {
        
        [array addObject:dic];
        [array writeToFile:@"/Users/SYLApple/Desktop/robot1.plist" atomically:YES];
        NSLog(@"+++++++++++Success+++++++++++:%zd",array.count);
    } Error:^(NSError *error) {
        NSLog(@"--------error-------%@",accountName);
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSMutableArray *mulArray = [NSMutableArray array];
//    NSTimer *timer = [NSTimer ccw_timerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
//        [self createName:[self randomStringWithLength:7] addPassword:[self randomStringWithLength:6] withArray:mulArray];
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
//    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"robot1" ofType:@"plist"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:dataPath];
//    [[array mj_JSONString] writeToFile:@"/Users/SYLApple/Desktop/robotjson.txt" atomically:YES];
    
    CCWWeakSelf;
    // 请求连接节点
    [CCWSDKRequest CCW_RequestNodeSuccess:^(id  _Nonnull responseObject) {
        NSMutableArray *nodeArray = [CCWNodeInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 重新填入数据库
        [[CCWDataBase CCW_shareDatabase] CCW_SaveSerVerNodeInfoArray:nodeArray];
        [weakSelf connectNodeWithNodeArray:nodeArray];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        NSMutableArray *nodeArray = [[CCWDataBase CCW_shareDatabase] CCW_QueryNodeInfo];
        [weakSelf connectNodeWithNodeArray:nodeArray];
    }];
    
    // 模块注册
    [[CCWMediator sharedInstance] registerAllModules];
    
    // 选择语言
    [CCWLocalizableTool initUserLanguage];
    
    //设置键盘
    [self CCW_KeyBoardSetting];
    
    // 设置 Toast
    [self CCW_SetToast];
    
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置跟控制器
    self.window.rootViewController = [self CCW_RootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

// 连接节点
- (void)connectNodeWithNodeArray:(NSArray *)nodeArray
{
    CCWNodeInfoModel *nodeInfo = [nodeArray firstObject];
    if (CCWNodeInfo) {
        nodeInfo = [CCWNodeInfoModel mj_objectWithKeyValues:CCWNodeInfo];
    }
    // 最新新节点
    [CCWSDKRequest CCW_InitWithUrl:nodeInfo.ws Core_Asset:nodeInfo.coreAsset Faucet_url:nodeInfo.faucetUrl ChainId:nodeInfo.chainId Success:^(id  _Nonnull responseObject) {
        // 记录已连接的数据
        CCWSETNodeInfo([nodeInfo mj_keyValues]);
        // 发个通知
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CCWNetConnectNetworkKey" object:nil];
        });
        CCWLog(@"xxxxxInit1 Callback:%@", responseObject);
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        
    }];
}

// 跟控制器
- (UIViewController *)CCW_RootViewController
{
    if (CCWAccountName) {
        return [NSClassFromString(@"CCWTabViewController") new];
    }else{
        id<CCWInitModuleProtocol> registerModule = [[CCWMediator sharedInstance] moduleForProtocol:@protocol(CCWInitModuleProtocol)];
        CCWNavigationController *registerController = [[CCWNavigationController alloc] initWithRootViewController:[registerModule CCW_LoginRegisterWalletViewController]];
        return registerController;
    }
}

// 键盘设置
- (void)CCW_KeyBoardSetting
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

// Toast 配置
- (void)CCW_SetToast
{
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.verticalMagin = 50;
    style.backgroundColor = [[UIColor getColor:@"282828"] colorWithAlphaComponent:0.8];
    style.cornerRadius = 3;
    style.messageFont = CCWFont(14);
    
    // @NOTE: Uncommenting the line below will set the shared style for all toast methods:
    [CSToastManager setSharedStyle:style];
    [CSToastManager setDefaultPosition:CSToastPositionBottom];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
