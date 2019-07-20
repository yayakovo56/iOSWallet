//
//  CCWAllOrderViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/18.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWAllOrderViewController.h"
#import "CCWNHAssetOrderTableViewCell.h"

@interface CCWAllOrderViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger page;
}


@property (nonatomic, strong) NSMutableArray *allPropOrderArray;
@end

@implementation CCWAllOrderViewController

- (NSMutableArray *)allPropOrderArray
{
    if (!_allPropOrderArray) {
        _allPropOrderArray = [NSMutableArray array];
    }
    return _allPropOrderArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 120;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}


- (void)loadData
{
    page = 1;
    CCWWeakSelf;
    [CCWSDKRequest CCW_QueryAllNHAssetOrder:@"" WorldView:@"" BaseDescribe:@"" PageSize:10 Page:page Success:^(id  _Nonnull responseObject) {
        weakSelf.allPropOrderArray = [CCWNHAssetOrderModel mj_objectArrayWithKeyValuesArray:[responseObject firstObject]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
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
    [CCWSDKRequest CCW_QueryAllNHAssetOrder:@"" WorldView:@"" BaseDescribe:@"" PageSize:10 Page:page Success:^(id  _Nonnull responseObject) {
        weakSelf.allPropOrderArray = [CCWNHAssetOrderModel mj_objectArrayWithKeyValuesArray:[responseObject firstObject]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allPropOrderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCWNHAssetOrderTableViewCell *cell = [CCWNHAssetOrderTableViewCell cellWithTableView:tableView WithIdentifier:@"CCWallOrderTableViewCell"];
    cell.allOrderModel = self.allPropOrderArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
