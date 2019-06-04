//
//  UIView+EmptyView.m
//  YiBiFen
//
//  Created by caohuihui on 15/12/11.
//  Copyright © 2015年 hhly. All rights reserved.
//

#import "UIView+EmptyView.h"
#import <objc/runtime.h>

@implementation UIView (EmptyView)

static char BlankPageViewKey;

- (void)setBlankPageView:(LYBlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (LYBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

// 无数据显示
- (void)configWithHasData:(BOOL)hasData noDataImage:(UIImage *)image noDataTitle:(NSString *)title hasError:(BOOL)hasError  reloadBlock:(void(^)(id sender))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[LYBlankPageView alloc] initWithFrame:self.bounds];
        }
        self.blankPageView.hidden = NO;
        self.blankPageView.backgroundColor = [UIColor whiteColor];
        [self.blankPageContainer addSubview:self.blankPageView];
        [self.blankPageView configWithHasData:hasData noDataImage:image noDataTitle:title hasError:hasError  reloadBlock:block];
    }
}

// 无数据显示
- (void)configWithHasData:(BOOL)hasData noDataTitle:(NSString *)title hasError:(BOOL)hasError reloadBlock:(void(^)(id sender))block
{
    [self configWithHasData:hasData noDataImage:nil noDataTitle:title hasError:hasError reloadBlock:block];
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}

@end

@implementation LYBlankPageView
- (UIImageView *)logoView
{
    //图片
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        [_logoView setImage:[UIImage imageNamed:@"NetError"]];
        [self addSubview:_logoView];
    }
    return _logoView;
}

- (UILabel *)tipLabel
{
    //文字
    if (!_tipLabel) {
        _tipLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _tipLabel.backgroundColor=[UIColor clearColor];
        _tipLabel.numberOfLines=0;
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor=[UIColor getColor:@"42466D"];
        _tipLabel.alpha = 0.5;
        //80是左右的间距
        _tipLabel.preferredMaxLayoutWidth = CCWScreenW -80;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"页面被外星人带走了！";
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (UIButton *)reloadButton
{
    if (!_reloadButton) {
        [_reloadButton removeFromSuperview];
        _reloadButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _reloadButton.backgroundColor = [UIColor getColor:@"63D0AB"];
        _reloadButton.layer.cornerRadius = 21;
        _reloadButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_reloadButton setTitle:@"刷新页面" forState:UIControlStateNormal];
        [_reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadButton];
    }
    return _reloadButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 带有图片的
- (void)configWithHasData:(BOOL)hasData noDataImage:(UIImage *)image noDataTitle:(NSString *)title hasError:(BOOL)hasError reloadBlock:(void (^)(id))block{
    CCWWeakSelf;
    // 上面已判断，此处多余
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    //布局
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(-60);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.logoView.mas_bottom).offset(15);
    }];
    
    if (hasError) {
        self.reloadButton.hidden = NO;
        _reloadButtonBlock = block;
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tipLabel.mas_bottom).offset(60);
            make.centerX.equalTo(weakSelf.tipLabel.mas_centerX);
            make.height.mas_equalTo(@42);
            make.width.mas_equalTo(@128);
            [weakSelf.reloadButton sizeToFit];
        }];
        
    }else{
        //空白数据
        self.reloadButton.hidden = YES;
        [self.logoView setImage:image];
        self.tipLabel.text = title;
    }
}

- (void)reloadButtonClicked:(id)sender{
    
    self.hidden = YES;
    [self removeFromSuperview];
    CCWWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !weakSelf.reloadButtonBlock?:weakSelf.reloadButtonBlock(sender);
    });
}
@end
