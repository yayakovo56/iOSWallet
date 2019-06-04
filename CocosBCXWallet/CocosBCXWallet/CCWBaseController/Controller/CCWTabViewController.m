//
//  CCWTabViewController
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWTabViewController.h"
#import "CCWNavigationController.h"
#import "CCWWalletViewController.h"
#import "CCWFindViewController.h"
#import "CCWMyViewController.h"

@interface CCWTabViewController ()

@end

@implementation CCWTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpdateChildViewController];
}

- (void)setUpdateChildViewController {
    id<CCWWalletModuleProtocol> walletModule = [[CCWMediator sharedInstance] moduleForProtocol:@protocol(CCWWalletModuleProtocol)];
    UIViewController *walletViewController = [walletModule CCW_WalletViewController];
    [self addSubViewController:walletViewController tabBarImage:[UIImage imageNamed:@"home_normal"] tabBarSelectImage:[UIImage imageNamed:@"home_select"] title:CCWLocalizable(@"钱包")];
    
    id<CCWFindModuleProtocol> findModule = [[CCWMediator sharedInstance] moduleForProtocol:@protocol(CCWFindModuleProtocol)];
    UIViewController *findController = [findModule CCW_FindViewController];
    [self addSubViewController:findController tabBarImage:[UIImage imageNamed:@"find_normal"] tabBarSelectImage:[UIImage imageNamed:@"find_select"] title:CCWLocalizable(@"发现")];
    
    id<CCWMyModuleProtocol> myModule = [[CCWMediator sharedInstance] moduleForProtocol:@protocol(CCWMyModuleProtocol)];
    UIViewController *myController = [myModule CCW_MyViewController];
    [self addSubViewController:myController tabBarImage:[UIImage imageNamed:@"mine_normal"] tabBarSelectImage:[UIImage imageNamed:@"mine_select"] title:CCWLocalizable(@"我的")];
    
    UITabBar *tabBar = self.tabBar;
    tabBar.translucent = NO;
    tabBar.barStyle = UIBarStyleDefault;
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    // 设置TabBar字体
    NSMutableDictionary *titleNomalAttri = [NSMutableDictionary dictionary];
    titleNomalAttri[NSFontAttributeName] = CCWFont(12);
    titleNomalAttri[NSForegroundColorAttributeName] = [UIColor getColor:@"8E8E93"];
    [tabBarItem setTitleTextAttributes:titleNomalAttri forState:UIControlStateNormal];
    
    NSMutableDictionary *titleSelectAttri = [NSMutableDictionary dictionary];
    titleSelectAttri[NSForegroundColorAttributeName] = [UIColor getColor:@"2E6EF9"];
    [tabBarItem setTitleTextAttributes:titleSelectAttri forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor getColor:@"E0E0E0"]]];
}

#pragma mark -添加所有子控制器
- (void)addSubViewController:(UIViewController *)viewController tabBarImage:(UIImage *)image tabBarSelectImage:(UIImage *)selectImage title:(NSString *)title
{
    //tabBar按钮上的图片
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //导航标题
    viewController.title = title;
    CCWNavigationController *navigationVC = [[CCWNavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:navigationVC];
}

@end
