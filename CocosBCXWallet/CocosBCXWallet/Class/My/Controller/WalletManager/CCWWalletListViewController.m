//
//  CCWWalletListViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/4/11.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWWalletListViewController.h"
#import "CCWMyWalletTableViewCell.h"
#import "CCWWalletManagerViewController.h"

@interface CCWWalletListViewController ()<UITableViewDelegate,UITableViewDataSource,CCWMyWalletTableViewCellDelegate>
/** tableView */
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *myWalletArray;
@end

@implementation CCWWalletListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"钱包管理");
    UITableView *tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 120;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    self.tableView = tableView;
    
    [CCWSDKRequest CCW_QueryAccountListSuccess:^(id  _Nonnull responseObject) {
        self.myWalletArray = responseObject;
        [self.tableView reloadData];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        
    }];

}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myWalletArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCWMyWalletTableViewCell *cell = [CCWMyWalletTableViewCell cellWithTableView:tableView WithIdentifier:@"MyWalletCell"];
    cell.walletAccountModel = self.myWalletArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCWWalletManagerViewController *walletManagerVC = [[CCWWalletManagerViewController alloc] init];
    walletManagerVC.walletAccountModel = self.myWalletArray[indexPath.row];
    [self.navigationController pushViewController:walletManagerVC animated:YES];
}

// 点击复制
- (void)walletTableViewCellCopyAddressClick:(CCWMyWalletTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CCWWalletAccountModel *walletAccountModel = self.myWalletArray[indexPath.row];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:walletAccountModel.dbAccountModel.name];
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}
@end
