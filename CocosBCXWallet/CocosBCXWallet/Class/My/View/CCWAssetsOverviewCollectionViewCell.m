//
//  CCWAssetsOverviewCollectionViewCell.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/22.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWAssetsOverviewCollectionViewCell.h"

@implementation CCWAssetsOverviewCollectionViewCell

- (void)setShowsVc:(UIViewController *)showsVc {
    _showsVc = showsVc;
    [self addSubview:showsVc.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.showsVc.view.frame = self.contentView.bounds;
}


@end
