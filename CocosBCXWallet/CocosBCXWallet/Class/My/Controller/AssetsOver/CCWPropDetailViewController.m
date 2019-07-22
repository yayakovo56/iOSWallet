//
//  CCWPropDetailViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/7/22.
//  Copyright © 2019 邵银岭. All rights reserved.
//

#import "CCWPropDetailViewController.h"

@interface CCWPropDetailViewController ()
// 渐变层
@property (weak, nonatomic) IBOutlet UIView *gradientView;

// 转账成功title
@property (weak, nonatomic) IBOutlet UILabel *transferTypeLabel;
// nhAssetid
@property (weak, nonatomic) IBOutlet UILabel *transferAccountLabel;

@property (weak, nonatomic) IBOutlet UILabel *creater;
@property (weak, nonatomic) IBOutlet UILabel *seller;
@property (weak, nonatomic) IBOutlet UILabel *passAssets;
@property (weak, nonatomic) IBOutlet UILabel *worldviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UITextView *baseDataLabel;

@end

@implementation CCWPropDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CCWLocalizable(@"详情");
    [self ccw_setNavBackgroundColor:[UIColor getColor:@"D2D9F3"]];
    self.gradientView.backgroundColor = [UIColor gradientColorFromColors:@[[UIColor getColor:@"D2D9F3"],[UIColor getColor:@"F6F7F8"]] gradientType:CCWGradientTypeTopToBottom colorSize:CGSizeMake(CCWScreenW, 280)];
    
    self.transferAccountLabel.text = self.nhAssetModel.ID;
    self.passAssets.text = self.nhAssetModel.asset_qualifier;
    self.worldviewLabel.text = self.nhAssetModel.world_view;
    self.createTime.text = self.nhAssetModel.create_time;
    self.baseDataLabel.text = [NSString stringWithFormat:@"%@",[self.nhAssetModel.base_describe dictionaryValue]];
    self.seller.text = self.nhAssetModel.nh_asset_owner;
    self.creater.text = self.nhAssetModel.nh_asset_creator;
    CCWWeakSelf;
    [CCWSDKRequest CCW_QueryAccountInfo:self.nhAssetModel.nh_asset_owner Success:^(id  _Nonnull responseObject) {
        weakSelf.seller.text = responseObject[@"name"];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        
    }];
    [CCWSDKRequest CCW_QueryAccountInfo:self.nhAssetModel.nh_asset_creator Success:^(id  _Nonnull responseObject) {
        weakSelf.creater.text = responseObject[@"name"];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        
    }];
}

- (IBAction)transferAsset:(UIButton *)sender {
    
}

- (IBAction)deleteAsset:(UIButton *)sender {
    
}


@end
