//
//  CCWOrderDetailViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/24.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWOrderDetailViewController.h"

@interface CCWOrderDetailViewController ()
// 渐变层
@property (weak, nonatomic) IBOutlet UIView *gradientView;

// 订单id
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *assetIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerLabel;
@property (weak, nonatomic) IBOutlet UILabel *passAssetLabel;
@property (weak, nonatomic) IBOutlet UILabel *worldViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiratTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *baseDataLabel;

@property (weak, nonatomic) IBOutlet UIButton *optionButton;

@end

@implementation CCWOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CCWLocalizable(@"详情");
    [self ccw_setNavBackgroundColor:[UIColor getColor:@"D2D9F3"]];
    self.gradientView.backgroundColor = [UIColor gradientColorFromColors:@[[UIColor getColor:@"D2D9F3"],[UIColor getColor:@"F6F7F8"]] gradientType:CCWGradientTypeTopToBottom colorSize:CGSizeMake(CCWScreenW, 280)];
    self.orderIDLabel.text = self.orderModel.ID;
    self.assetIDLabel.text = self.orderModel.nh_asset_id;
    self.worldViewLabel.text = self.orderModel.world_view;
    self.passAssetLabel.text = self.orderModel.asset_qualifier;
    self.noteLabel.text = self.orderModel.memo;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@",self.orderModel.priceModel.amount,self.orderModel.priceModel.symbol];
    self.expiratTimeLabel.text = self.orderModel.expiration;
    self.baseDataLabel.text = [NSString stringWithFormat:@"%@",[self.orderModel.base_describe dictionaryValue]];
    self.sellerLabel.text = self.orderModel.seller;
    CCWWeakSelf
    [CCWSDKRequest CCW_QueryAccountInfo:self.orderModel.seller Success:^(id  _Nonnull responseObject) {
        weakSelf.sellerLabel.text = responseObject[@"name"];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        
    }];
    if (self.orderType == CCWNHAssetOrderTypeMy) {
        [self.optionButton setTitle:CCWLocalizable(@"取消") forState:UIControlStateNormal];
    }else{
        [self.optionButton setTitle:CCWLocalizable(@"购买") forState:UIControlStateNormal];
    }
}

- (IBAction)oprationClick:(UIButton *)sender {
    if (self.orderType == CCWNHAssetOrderTypeMy) {
        NSLog(@"取消");
    }else{
        NSLog(@"购买");
    }
}


@end
