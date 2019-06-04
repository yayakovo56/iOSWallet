//
//  CCWDigitalAssetsViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/22.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWDigitalAssetsViewController.h"
#import "CCWWalletTableViewCell.h"

@interface CCWDigitalAssetsViewController ()<UITableViewDataSource,UITableViewDelegate>
/** Cocos个数 */
@property (nonatomic, strong) NSMutableArray *assetsModelArray;

@end

@implementation CCWDigitalAssetsViewController

- (NSMutableArray *)assetsModelArray
{
    if (!_assetsModelArray) {
        _assetsModelArray = [NSMutableArray array];
    }
    return _assetsModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 82;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    
    CCWWeakSelf
    // 查询资产
    [CCWSDKRequest CCW_QueryAccountAllBalances:CCWAccountId Success:^(id  _Nonnull responseObject) {
        weakSelf.assetsModelArray = responseObject;
        [weakSelf.tableView reloadData];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assetsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCWWalletTableViewCell *cell = [CCWWalletTableViewCell cellWithTableView:tableView WithIdentifier:@"WalletTableViewCell"];
    cell.assetsModel = self.assetsModelArray[indexPath.row];
    return cell;
}

@end
