//
//  CCWEditContactViewController.h
//  CocosWallet
//
//  Created by 邵银岭 on 2018/12/20.
//  Copyright © 2018年 CCW. All rights reserved.
//

typedef NS_ENUM(NSUInteger, CCWContactEditType) {
    CCWContactEditTypeAdd = 0,      //添加
    CCWContactEditTypeEdit = 1,     //编辑
    CCWContactEditTypeScanAdd = 2,  //扫码添加
    CCWContactEditTypeScanEdit = 3  //扫码编辑
};

#import <UIKit/UIKit.h>

@interface CCWEditContactViewController : UIViewController
/** 编辑类型 */
@property (nonatomic, assign) CCWContactEditType contactEditType;
/** <#视图#> */
@property (nonatomic, strong) CCWContactModel *contactModel;
@end
