//
//  CCWNavigationController
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWNavigationController.h"

@interface CCWNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation CCWNavigationController
+ (void)initialize
{
    //获取当前导航条
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    // 设置导航条字体
    NSMutableDictionary *titleAttri = [NSMutableDictionary dictionary];
    titleAttri[NSFontAttributeName] = CCWBoldFont(18);
    [bar setTitleTextAttributes:titleAttri];
    
    /** 全局设置导航栏背景颜色 */
    [UIColor ccw_setDefaultNavBackgroundColor:[UIColor whiteColor]];
    /** 全局设置导航栏黑色分割线是否隐藏*/
    [UIColor ccw_setDefaultNavBarShadowImageHidden:YES];
    /** 全局设置导航栏标题颜色 */
    [UIColor ccw_setDefaultNavBarTitleColor:[UIColor getColor:@"262A33"]];
    [UIColor ccw_setDefaultNavBarTintColor:[UIColor getColor:@"262A33"]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 清空手势代理, 然后就会重新出现手势移除控制器的功能
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //左边导航栏的图标
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backNav)];

        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (void)backNav {
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

@end
