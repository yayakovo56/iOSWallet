//
//  CCWScanQRCodeViewController.m
//  CocosWallet
//
//  Created by 邵银岭 on 2018/11/30.
//  Copyright © 2018年 CCW. All rights reserved.
//

#import "CCWScanQRCodeViewController.h"
#import <SGQRCode/SGQRCode.h>
#import "CCWEditContactViewController.h"

@interface CCWScanQRCodeViewController ()<SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>
@property (nonatomic, strong) SGQRCodeScanManager *manager;
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation CCWScanQRCodeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [_manager resetSampleBufferDelegate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [self removeFlashlightBtn];
    [_manager cancelSampleBufferDelegate];
}

- (void)dealloc {
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = CCWLocalizable(@"扫一扫");
//    self.navigationItem.rightBarButtonItem = [self barButtonItemAction:@selector(rightBarButtonItenAction) title:TWLocalizable(@"相册") titltColor:nil];
    [self.view addSubview:self.scanningView];
    [self setupQRCodeScanning];
    [self.view addSubview:self.promptLabel];
    /// 为了 UI 效果
    [self.view addSubview:self.bottomView];
}

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[SGQRCodeScanningView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.9 * self.view.frame.size.height)];
        _scanningView.scanningImageName = @"QRCodeScanningLine";
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)rightBarButtonItenAction {
    SGQRCodeAlbumManager *manager = [SGQRCodeAlbumManager sharedManager];
    [manager readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
    
    if (manager.isPHAuthorization == YES) {
        [self.scanningView removeTimer];
    }
}

- (void)setupQRCodeScanning {
    self.manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    _manager.delegate = self;
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    NSDictionary *resultDic = [result dictionaryValue];
//    if (resultDic[@"Ethereum"]) {
//        if (self.perVCscanQRCodePerVC == CCWScanQRCodePerVCHomeVC) {
//            CCWTransOutViewController *transferOutVC = [[CCWTransOutViewController alloc] init];
////            transferOutVC.QRCodeDic = resultDic;
//            [self.navigationController pushViewController:transferOutVC animated:YES];
//        }else{
//            !self.scanQRCodeBlock?:self.scanQRCodeBlock(resultDic[@"Ethereum"]);
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }else{
//        [self.view makeToast:CCWLocalizable(@"无法识别")];
//    }
}
- (void)QRCodeAlbumManagerDidReadQRCodeFailure:(SGQRCodeAlbumManager *)albumManager {
    [self.view makeToast:CCWLocalizable(@"无法识别")];
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    //    TWLog(@"QRCodeScanManager\n%@",metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSDictionary *resultDic = [[obj stringValue] dictionaryValue];
        
        CCWLog(@"resultDic\n%@",resultDic);
        if (resultDic[@"symbol"]){
            // 扫描到结果停止
            [self stopScanHandleWithScanManager:scanManager];
            if (self.perVCscanQRCodePerVC == CCWScanQRCodePerVCAddContactVC){
                [self pushAddContactWithAddressString:resultDic];
            } else {
                !self.scanQRCodeBlock?:self.scanQRCodeBlock(resultDic);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else {
            [self.view makeToast:CCWLocalizable(@"无法识别")];
            CCWLog(@"暂未识别出扫描的二维码");
        }
    } else {
        [self.view makeToast:CCWLocalizable(@"无法识别")];
        CCWLog(@"暂未识别出扫描的二维码");
    }
}

// 联系人添加跳转添加
- (void)pushAddContactWithAddressString:(NSDictionary *)objString
{
    CCWEditContactViewController *viewController = [[CCWEditContactViewController alloc] init];
    NSMutableArray *contactModelArray = [[CCWDataBase CCW_shareDatabase] CCW_QueryMyContactWithWalletAddress:objString[@"address"]];
    CCWContactModel *tempContactModel = [[CCWContactModel alloc] init];
    if (contactModelArray.count > 0) {
        tempContactModel = contactModelArray[0];
        viewController.contactEditType = CCWContactEditTypeScanEdit;
    }else{
        tempContactModel.address = objString[@"address"];
        viewController.contactEditType = CCWContactEditTypeScanAdd;
    }
    viewController.contactModel = tempContactModel;
    [self.navigationController pushViewController:viewController animated:YES];
}

// 停止扫描处理
- (void)stopScanHandleWithScanManager:(SGQRCodeScanManager *)scanManager
{
    // 扫描到结果停止
//    [scanManager playSoundName:@"sound.caf"];
    [scanManager stopRunning];
    [scanManager videoPreviewLayerRemoveFromSuperlayer];
}

- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue {
    
    if (brightnessValue < - 1) {
        [self.view addSubview:self.flashlightBtn];
    } else {
        if (self.isSelectedFlashlightBtn == NO) {
            [self removeFlashlightBtn];
        }
    }
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text =  CCWLocalizable(@"将二维码放入框中，既能快速扫描");
    }
    return _promptLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scanningView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.scanningView.frame))];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bottomView;
}

#pragma mark - - - 闪光灯按钮
- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 30;
        CGFloat flashlightBtnH = 30;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.55 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightCloseImage"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [SGQRCodeHelperTool SG_openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SGQRCodeHelperTool SG_CloseFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}

@end
