//
//  NSTimer+SYLTimer.h
//  CocosHDWallet
//
//  Created by 邵银岭 on 2018/4/16.
//  Copyright © 2018年 邵银岭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (CCWTimer)

+ (instancetype)ccw_timerWithTimeInterval:(NSTimeInterval)time repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

@end
