//
//  CCWSelectSellCoinViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWSelectSellCoinViewController.h"
#import "CCWSellCoinTypeTableViewCell.h"

@interface CCWSelectSellCoinViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation CCWSelectSellCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"币种选择");
    self.view.backgroundColor = [UIColor getColor:@"F6F7FB"];
    
    UITableView *tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.height = self.view.height;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 70;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCWSellCoinTypeTableViewCell *cell = [CCWSellCoinTypeTableViewCell cellWithTableView:tableView WithIdentifier:@"SellCoinTypeTableViewCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
