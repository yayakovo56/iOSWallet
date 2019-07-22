//
//  CCWEditContactViewController.m
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/20.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import "CCWEditContactViewController.h"

@interface CCWEditContactViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *addEditButton;
@property (weak, nonatomic) IBOutlet UIButton *makeAddressButton;

@end

@implementation CCWEditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = CCWLocalizable(@"联系人");
    self.addEditButton.backgroundColor = CCWButtonBgColor;
    
    if (self.contactEditType == CCWContactEditTypeAdd) {
        self.makeAddressButton.hidden = YES;
    }else if (self.contactEditType == CCWContactEditTypeScanEdit || self.contactEditType == CCWContactEditTypeEdit) {
        self.nameTextField.text = self.contactModel.name;
        self.noteTextField.text = self.contactModel.note;
        self.addressTextField.text = self.contactModel.address;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:CCWLocalizable(@"删除") style:UIBarButtonItemStylePlain target:self action:@selector(deleteComplete)];
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:CCWLocalizable(@"删除") style:UIBarButtonItemStylePlain target:self action:@selector(deleteComplete)];
        self.addressTextField.text = self.contactModel.address;
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.contactEditType == CCWContactEditTypeScanAdd || self.contactEditType == CCWContactEditTypeScanEdit) {
        // 改变跳转
        NSMutableArray *viewControllersArray = self.navigationController.viewControllers.mutableCopy;
        [viewControllersArray removeObjectAtIndex:viewControllersArray.count-2];
        self.navigationController.viewControllers = viewControllersArray;
    }
}
- (IBAction)makeAddressClick:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.addressTextField.text];
    [self.view makeToast:CCWLocalizable(@"复制成功")];
}

- (IBAction)addEditContact:(UIButton *)sender {

    if (self.nameTextField.text.length == 0) {
        [self.view makeToast:CCWLocalizable(@"收款方账户名不能为空")];
        return;
    }
    if (self.addressTextField.text.length == 0) {
        [self.view makeToast:CCWLocalizable(@"请输入钱包地址")];
        return;
    }
//    else if (![self.addressTextField.text ys_regexValidate:@"^0[xX][\\da-fA-F]{40}$"]) {
//        [self.view makeToast:CCWLocalizable(@"请填写正确钱包地址")];
//        return;
//    }
    // 区别是编辑还是添加
    CCWContactModel *contactModel = [[CCWContactModel alloc] init];
    contactModel.name = self.nameTextField.text;
    contactModel.note = self.noteTextField.text;
    contactModel.address = self.addressTextField.text;
    [[CCWDataBase CCW_shareDatabase] CCW_SaveMyContactModel:contactModel];
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 完成
- (void)deleteComplete
{
    CCWWeakSelf
    CCWVCShowAlertCancelWithMsgHandler(CCWLocalizable(@"确定删除联系人？"), nil, ^(UIAlertAction * _Nonnull action) {
        [[CCWDataBase CCW_shareDatabase] CCW_DeleteContact:weakSelf.contactModel];
        [self.navigationController popViewControllerAnimated:YES];
    });
}


@end
