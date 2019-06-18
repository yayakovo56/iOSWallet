//
//  CCWCheckVisionAlert.m
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWCheckVisionAlert.h"

@implementation CCWCheckVisionAlert

- (NSArray<CCWAlertAction *> *)getActions {
    
    CCWAlertAction *cancel = [CCWAlertAction CCW_actionWithTitle:CCWLocalizable(@"暂不更新") style:CCWAlertActionStyleCancel handler:^(CCWAlertAction *action) {
        
    }];
    
    CCWAlertAction *comfirm = [CCWAlertAction CCW_actionWithTitle:CCWLocalizable(@"立即更新") style:CCWAlertActionStyleDefault handler:^(CCWAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:CCWNewAppDownloadurl]];
    }];
    
    if (CCWIsForceUpdate) { // 强制更新
        return @[comfirm];
    }else{
        return @[cancel,comfirm];
    }
}

// 标题
- (NSString *)showWithTitle {
    
    return CCWLocalizable(@"发现新版本");
}

// 展示内容
- (NSString *)showWithMessage {
    
    NSString *newVisionTitle = CCWLocalizable(@"有新的版本");
    BOOL isChinese = [[CCWLocalizableTool userLanguageString] isEqualToString:@"中文"];
    NSString *upDataInfo = isChinese?CCWNewAppUpdateNotes:CCWNewAppUpdateEnNotes;
    return [NSString stringWithFormat:@"%@V%@\n%@", newVisionTitle, CCWAppNewVersion,upDataInfo];;
}

// 自定义消息栏
- (UIView *)messageView:(UILabel *)oringeMessage {

    oringeMessage.textAlignment = NSTextAlignmentLeft;
    if (iPhone5 || iPhone4S) {
        oringeMessage.font = [UIFont systemFontOfSize:12];
        CGFloat height = [oringeMessage.text heightWithFont:oringeMessage.font MaxWidth:oringeMessage.width];
        oringeMessage.height = height;
    }
    return oringeMessage;
}


@end
