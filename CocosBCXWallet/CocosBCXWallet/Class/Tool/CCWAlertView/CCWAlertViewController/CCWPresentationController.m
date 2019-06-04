//
//  CCWPresentationController.m
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWPresentationController.h"

@implementation CCWPresentationController
//用来布局containerView中子控件的frame
- (void)containerViewDidLayoutSubviews{
    
    self.presentedView.frame = self.containerView.bounds;
}

- (void)presentationTransitionWillBegin{
    
    [self.containerView addSubview:self.presentedView];
    
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    
    [self.containerView removeFromSuperview];
    
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    
}
- (void)dismissalTransitionWillBegin {
    
}

@end
