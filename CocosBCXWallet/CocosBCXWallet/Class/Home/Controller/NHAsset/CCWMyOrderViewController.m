//
//  CCWMyOrderViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWMyOrderViewController.h"
#import "CCWNHAssetOrderTableViewCell.h"
#import "CCWOrderDetailViewController.h"

@interface CCWMyOrderViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,CCWPropOrderCellDelegate>
{
    NSInteger page;
}

@property (nonatomic, strong) NSMutableArray *myPropOrderArray;

@end

@implementation CCWMyOrderViewController

- (NSMutableArray *)myPropOrderArray
{
    if (!_myPropOrderArray) {
        _myPropOrderArray = [NSMutableArray array];
    }
    return _myPropOrderArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 120;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
   
}

- (void)loadData
{
    page = 1;
    CCWWeakSelf;
    [CCWSDKRequest CCW_ListAccountNHAssetOrder:CCWAccountId PageSize:10 Page:page Success:^(NSMutableArray *responseObject) {
        weakSelf.myPropOrderArray = responseObject;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        if (responseObject.count < 1) {
            weakSelf.tableView.mj_footer = nil;
        }else if (responseObject.count < 10){
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData
{
    page += 1;
    CCWWeakSelf;
    [CCWSDKRequest CCW_ListAccountNHAssetOrder:CCWAccountId PageSize:10 Page:page Success:^(NSArray *responseObject) {
        [weakSelf.myPropOrderArray addObjectsFromArray:responseObject];
        [weakSelf.tableView reloadData];
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if (responseObject.count < 10) {
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
    return self.myPropOrderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCWNHAssetOrderTableViewCell *cell = [CCWNHAssetOrderTableViewCell cellWithTableView:tableView WithIdentifier:@"NHAssetOrderTableViewCell"];
    cell.nhAssetOrderModel = self.myPropOrderArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCWOrderDetailViewController *orderDetailVC = [[CCWOrderDetailViewController alloc] init];
    orderDetailVC.orderModel = self.myPropOrderArray[indexPath.row];
    orderDetailVC.orderType = CCWNHAssetOrderTypeMy;
    [[UIViewController topViewController].navigationController pushViewController:orderDetailVC animated:YES];
}

// 点击取消
- (void)CCWPropOrderCellbuyClick:(CCWNHAssetOrderTableViewCell *)propOrderCell
{
    
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
