//
//  CCWNHOrderListViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWNHOrderListViewController.h"
#import "CCWMyOrderViewController.h"
#import "CCWAllOrderViewController.h"
#import "CCWAssetsOverviewCollectionViewCell.h"

@interface CCWNHOrderListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
// 下面布局
/** 所有标题的父控件 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题底部的指示线（下划线） */
@property (nonatomic, weak) UIView *indicatorView;
/** 记录上一次点击的标题按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 存放所有的标题按钮 */
@property (nonatomic, strong) NSArray *titlesArray;
/** 我的订单按钮 */
@property (nonatomic,weak) UIButton *myPropButton;
/** 全网订单按钮 */
@property (nonatomic,weak) UIButton *allPropButton;
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

/** 控制器对应的字典 */
@property (nonatomic, strong) NSMutableDictionary *controllersDict;
/** 控制器缓存池 */
@property (nonatomic, strong) NSMutableDictionary *controllerCache;

/** 默认展示数字资产还是道具资产 */
@property (nonatomic, assign) int assetIndex;
@end

@implementation CCWNHOrderListViewController
/** 重用cell ID */
static NSString *const AssetsCollectionCell = @"OrderCollectionCell";

- (NSMutableDictionary *)controllerCache {
    if (_controllerCache == nil) {
        _controllerCache = [[NSMutableDictionary alloc] init];
    }
    return _controllerCache;
}

- (NSMutableDictionary *)controllersDict {
    if (_controllersDict == nil) {
        NSMutableArray *objectsArray = [[NSMutableArray alloc] initWithObjects:[CCWMyOrderViewController class], [CCWAllOrderViewController class], nil];
        NSMutableArray *keysArray = [[NSMutableArray alloc] initWithObjects:CCWLocalizable(@"我的订单"),CCWLocalizable(@"全网订单"), nil];
        _controllersDict = [[NSMutableDictionary alloc] initWithObjects:objectsArray forKeys:keysArray];
    }
    return _controllersDict;
}

- (NSArray *)titlesArray
{
    if (!_titlesArray) {
        self.titlesArray = @[CCWLocalizable(@"我的订单"),CCWLocalizable(@"全网订单")];
    }
    return _titlesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"订单管理");
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置滚动导航的标签栏
    [self setupTitlesView];
    
    // 创建底部scrollView
    [self setupContentView];
   
    [self titleClick:self.myPropButton];
    
}

/**
 *  设置顶部的标签栏
 */
- (void)setupTitlesView {
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.frame = CGRectMake(0, APP_Navgationbar_Height, CCWScreenW, 50);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor getColor:@"262A33"];
    indicatorView.height = 2;
    indicatorView.width = 32;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    CGFloat width = titlesView.width / self.titlesArray.count;
    CGFloat height = titlesView.height;
    for (int i = 0; i < self.titlesArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:self.titlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor getColor:@"626670"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor getColor:@"262A33"] forState:UIControlStateDisabled];
        button.titleLabel.font = CCWFont(16);
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        if (i == 0) {
            self.myPropButton = button;
        }else{
            self.allPropButton = button;
        }
    }
    [titlesView addSubview:indicatorView];
}


/**
 *  按钮点击
 */
- (void)titleClick:(UIButton *)button {
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    NSUInteger index = [self.titlesArray indexOfObject:button.titleLabel.text];
    // 让底部的内容scrollView滚动到对应位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = button.centerX;
    }];
}

/**
 *  底部的scrollView
 */
- (void)setupContentView {
    
    // 创建一个流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //cell间距
    flowLayout.minimumInteritemSpacing = 0;
    //cell行距
    flowLayout.minimumLineSpacing = 0;
    // 修改属性
    flowLayout.itemSize = CGSizeMake(CCWScreenW, CCWScreenH - APP_Navgationbar_Height - 50);
    // 创建collectionView
    CGRect colletctionFrame = CGRectMake(0, CGRectGetMaxY(self.titlesView.frame), CCWScreenW, CCWScreenH - APP_Navgationbar_Height - 50);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:colletctionFrame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    // 注册一个cell
    [collectionView registerClass:[CCWAssetsOverviewCollectionViewCell class] forCellWithReuseIdentifier:AssetsCollectionCell];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    // 设置数据源对象
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view insertSubview:collectionView atIndex:0];
    self.collectionView = collectionView;
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 创建一个Cell
    CCWAssetsOverviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AssetsCollectionCell forIndexPath:indexPath];
    // 将上一个控制器的view移除
    [cell.showsVc.view removeFromSuperview];
    // 根据标题去缓存池获得对应的需要显示控制器
    UIViewController *showsVc = [self showsVc:self.titlesArray[indexPath.item]];
    cell.showsVc = showsVc;
    cell.backgroundColor = [UIColor whiteColor];
    // 2. 返回一个Cell
    return cell;
}

/**
 *  根据文字获得对应的需要显示控制器
 */
- (UIViewController *)showsVc:(NSString *)titile {
    UIViewController *showsVc = self.controllerCache[titile];
    if (showsVc == nil) {
        // 创建控制器
        // 所有
        UIViewController *typeVc = [[[self.controllersDict objectForKey:titile] alloc] init];
        // 将产品列表控制器添加到缓冲池中
        [self.controllerCache setObject:typeVc forKey:titile];
        return typeVc;
    }
    return showsVc;
}

#pragma mark - UIScrollViewDelegate
/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 一些临时变量
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat offsetX = self.collectionView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    
    // 选中滚动结束的按钮
    UIButton *titleButton = self.titlesView.subviews[index];
    if (titleButton == self.selectedButton) {
        return;
    }
    [self titleClick:titleButton];
}

@end
