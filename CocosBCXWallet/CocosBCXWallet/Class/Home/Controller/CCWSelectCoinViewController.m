//
//  CCWSelectCoinViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/4/10.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWSelectCoinViewController.h"
#import "CCWWalletTableViewCell.h"
#import "CCWTransferViewController.h"
#import "CCWReceiveViewController.h"

@interface CCWSelectCoinViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation CCWSelectCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.selectCoinStyle == CCWSelectCoinStyleTransfer) {
        self.title = CCWLocalizable(@"选择转账币种");
    }else{
        self.title = CCWLocalizable(@"选择收款币种");
    }
    
    UITableView *tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.height = self.view.height - APP_Tabbar_Height;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 82;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior =
            UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        tableView;
    });
    self.tableView = tableView;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectCoinStyle == CCWSelectCoinStyleTransfer) {
        CCWTransferViewController *transferViewController = [[CCWTransferViewController alloc] init];
        transferViewController.assetsModel = self.assetsModelArray[indexPath.row];;
        [self.navigationController pushViewController:transferViewController animated:YES];
    }else{
        CCWReceiveViewController *receiveViewController = [[CCWReceiveViewController alloc] init];
        receiveViewController.assetsModel = self.assetsModelArray[indexPath.row];;
        [self.navigationController pushViewController:receiveViewController animated:YES];
    }
}

@end
