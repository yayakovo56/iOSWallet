//
//  CCWContactViewController.m
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/20.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import "CCWContactViewController.h"
#import "CCWContactTableViewCell.h"
#import "CCWEditContactViewController.h"
#import "YBPopupMenu.h"
#import "CCWPrivacyPermissionsManager.h"
#import "CCWScanQRCodeViewController.h"

@interface CCWContactViewController () <UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *contactArray;
@end

@implementation CCWContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self CCW_SetupTableView];
    
}

- (void)CCW_SetupTableView
{
    self.title = CCWLocalizable(@"联系人");
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    [self.view addSubview:tableView];
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setImage:[UIImage imageNamed:@"editContact"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAddContact:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.tableView = tableView;
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 请求数据
    CCWWeakSelf;
    [[CCWDataBase CCW_shareDatabase] CCW_QueryMyContactComplete:^(NSMutableArray<CCWContactModel *> *contactArray) {
        weakSelf.contactArray = contactArray;
        [weakSelf.tableView reloadData];
    }];
}

- (void)rightAddContact:(UIButton *)rightBarButtonItem
{
    CGFloat menuWidth = 130;
    if (iPhone6SP) {
        menuWidth = 140;
    }
    [YBPopupMenu showRelyOnView:rightBarButtonItem titles:@[CCWLocalizable(@"手动添加") , CCWLocalizable(@"扫一扫")] icons:@[@"contactEdit",@"contactScan"] menuWidth:menuWidth otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.type = YBPopupMenuTypeDefault;
        popupMenu.delegate = self;
    }];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    //推荐回调
    if (index == 0) {
        CCWEditContactViewController *editContactViewController = [[CCWEditContactViewController alloc] init];
        editContactViewController.contactEditType = CCWContactEditTypeAdd;
        [self.navigationController pushViewController:editContactViewController animated:YES];
    }else{
        
        if ([CCWPrivacyPermissionsManager fxwIsOpenCamera]) {
            /// 扫描二维码创建
           CCWScanQRCodeViewController *scanQRCodeVC = [[CCWScanQRCodeViewController alloc] init];
            scanQRCodeVC.perVCscanQRCodePerVC = CCWScanQRCodePerVCAddContactVC;
            [self.navigationController pushViewController:scanQRCodeVC animated:YES];
        }else{
            [self.view makeToast:@"请允许访问相机"];
        }
    }
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCWContactTableViewCell *cell = [CCWContactTableViewCell cellWithTableView:tableView WithIdentifier:@"contactTableViewCell"];
    cell.contactModel = self.contactArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCWContactModel *contactModel = self.contactArray[indexPath.row];
    if (self.isSelectToTransfer) {
        !self.blockBackString?:self.blockBackString(contactModel.address);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        CCWEditContactViewController *editContactViewController = [[CCWEditContactViewController alloc] init];
        editContactViewController.contactEditType = CCWContactEditTypeEdit;
        editContactViewController.contactModel = contactModel;
        [self.navigationController pushViewController:editContactViewController animated:YES];
    }
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
    return  -140;
}

#pragma mark - DZNEmptyDataSetDelegate Methods
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}
@end
