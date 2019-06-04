//
//  CCWFindFirstTableViewCell.m
//  CocosWallet
//
//  Created by SYL on 2018/11/16.
//  Copyright © 2018 CCW. All rights reserved.
//

// Dapp 图标
#define kCCWDappPicURL @"http://api-dev.cjfan.net/wallet/static/images/dapp/"
#define CCWDappIconStrFormat(str)    [NSString stringWithFormat:@"%@%@",kCCWDappPicURL,str]

#import "CCWFindFirstTableViewCell.h"
#import "XRCarouselView.h"
#import "CCWFindButton.h"

@interface CCWFindFirstTableViewCell ()<XRCarouselViewDelegate>

@property (nonatomic, strong) XRCarouselView *carouselView;//轮播图

@end

@implementation CCWFindFirstTableViewCell
/** 初始化Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)identifier
{
    CCWFindFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CCWFindFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self CCW_SetupSubView];
    }
    return self;
}

- (void)CCW_SetupSubView
{
    // 1.轮播
    /** 通过代码创建轮播 */
    XRCarouselView *carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(16, 16, CCWScreenW - 32, FindCellScrollHeight)];
    carouselView.imageCornerRadius = 4;
    carouselView.delegate = self;
    //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
    carouselView.placeholderImage = [UIImage imageNamed:@"XRPlaceholder"];
    //设置图片数组及图片描述文字
    //    carouselView.imageArray = bannerImage;
    //设置每张图片的停留时间，默认值为5s，最少为1s
    carouselView.time = 3;
    carouselView.pagePosition = PositionBottomOut;
    //设置分页控件的颜色,不设置则为系统默认
    [carouselView setPageImage:[UIImage imageNamed:@"FindBannerNomal"] andCurrentPageImage:[UIImage imageNamed:@"FindBannerCurrent"]];
    //设置分页控件的位置，底部超出
    //设置滑动时gif停止播放
    carouselView.gifPlayMode = GifPlayModePauseWhenScroll;
    [self addSubview:carouselView];
    self.carouselView = carouselView;
  
    // 2.四个按钮
    UIView *contentButtonView = [[UIView alloc] init];
    CGFloat buttonH = FindHeadButtonHeight;
    contentButtonView.frame = CGRectMake(0, CGRectGetMaxY(carouselView.frame) + 22, CCWScreenW, buttonH);
    CGFloat buttonW = CCWScreenW / 4;
    for (int i = 0; i < 4; i++) {
        CCWFindButton *button = [[CCWFindButton alloc] init];
        button.tag = i+100;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [contentButtonView addSubview:button];
        if (i == 3) {
            [button setTitleColor:[UIColor getColor:@"A5A9B1"] forState:UIControlStateNormal];
        }
    }
    [self addSubview:contentButtonView];

}

// 设置数据
- (void)setFirstCellWithCarouselImageArray:(NSArray *)imageArray dappModelArray:(NSArray <CCWDappModel *>*)dappArray
{
    NSMutableArray *carouImageArray = [NSMutableArray array];
    for (CCWDappModel *dappModel in imageArray) {
        [carouImageArray addObject:[UIImage imageNamed:dappModel.image]];
    }
    self.carouselView.imageArray = carouImageArray;
    for (int i = 0; i < dappArray.count; i++) {
        CCWDappModel *dappModel = dappArray[i];
        UIButton *button = [self viewWithTag:i+100];
        [button setTitle:CCWLocalizable(dappModel.name) forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dappModel.image] forState:UIControlStateNormal];
    }
}

// 点击事件
- (void)buttonClick:(CCWFindButton *)button
{
    if ([self.delegate respondsToSelector:@selector(CCW_FindFirstCellClickNavButtonWithTableViewCell:button:)]) {
        [self.delegate CCW_FindFirstCellClickNavButtonWithTableViewCell:self button:button];
    }
}

- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(CCW_FindFirstCellClickCarouselViewWithTableViewCell:butclickImageAtIndex:)]) {
        [self.delegate CCW_FindFirstCellClickCarouselViewWithTableViewCell:self butclickImageAtIndex:index];
    }
}
@end
