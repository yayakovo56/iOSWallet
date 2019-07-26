//
//  CCWPropAssetsTableViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/26.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWPropAssetsTableViewController.h"
#import "CCWPropAssetsTableViewCell.h"
#import "CCWPropDetailViewController.h"

@interface CCWPropAssetsTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,CCWPropAssetsCellDelegate>
{
    NSInteger page;
}
/** <#视图#> */
@property (nonatomic, strong) NSMutableArray *propAssetArray;
@end

@implementation CCWPropAssetsTableViewController

- (NSMutableArray *)propAssetArray
{
    if (!_propAssetArray) {
        _propAssetArray = [NSMutableArray array];
    }
    return _propAssetArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadData
{
    page = 1;
    CCWWeakSelf;
    [CCWSDKRequest CCW_QueryAccountNHAsset:CCWAccountId WorldView:@[] PageSize:10 Page:page Success:^(NSArray *responseObject) {
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.propAssetArray = [CCWNHAssetsModel mj_objectArrayWithKeyValuesArray:[responseObject firstObject]];
        [weakSelf.tableView reloadData];
        if (weakSelf.propAssetArray.count < 1) {
            weakSelf.tableView.mj_footer = nil;
        }else if (weakSelf.propAssetArray.count < 10){
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

// 上拉加载更多
- (void)loadMoreData
{
    page += 1;
    CCWWeakSelf;
    [CCWSDKRequest CCW_QueryAccountNHAsset:CCWAccountId WorldView:@[] PageSize:10 Page:page Success:^(NSArray *responseObject) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.propAssetArray addObjectsFromArray:[CCWNHAssetsModel mj_objectArrayWithKeyValuesArray:[responseObject firstObject]]];
        [weakSelf.tableView reloadData];
        if (weakSelf.propAssetArray.count < 10) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.propAssetArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCWPropAssetsTableViewCell *cell = [CCWPropAssetsTableViewCell cellWithTableView:tableView WithIdentifier:@"CCWPropAssetsTableViewCell"];
    cell.delegate = self;
    cell.nhAssetModel = self.propAssetArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCWPropDetailViewController *propDetailVC = [[CCWPropDetailViewController alloc] init];
    propDetailVC.nhAssetModel = self.propAssetArray[indexPath.row];
    CCWWeakSelf;
    propDetailVC.deleteNHAssetComplete = ^{
        [weakSelf.propAssetArray removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    [[UIViewController topViewController].navigationController pushViewController:propDetailVC animated:YES];
}

// 出售资产
- (void)CCWPropAssetCellSellClick:(CCWPropAssetsTableViewCell *)propAssetCell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:propAssetCell];
    id<CCWWalletModuleProtocol> nhAssetModule = [[CCWMediator sharedInstance] moduleForProtocol:@protocol(CCWWalletModuleProtocol)];
    UIViewController *viewController = [nhAssetModule CCW_SellAssetsViewControllerWithAsset:self.propAssetArray[indexPath.row]];
    [[UIViewController topViewController].navigationController pushViewController:viewController animated:YES];
}

#pragma mark - DZNEmptyDataSetSource Methods
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"noData"];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return  -90;
}

#pragma mark - DZNEmptyDataSetDelegate Methods
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}
@end
