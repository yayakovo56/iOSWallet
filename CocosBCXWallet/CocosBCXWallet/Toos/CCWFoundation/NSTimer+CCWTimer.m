//
//  NSTimer+CCWTimer.h
//  CocosHDWallet
//
//  Created by 邵银岭 on 2018/4/16.
//  Copyright © 2018年 邵银岭. All rights reserved.
//

#import "NSTimer+CCWTimer.h"

@implementation NSTimer (CCWTimer)
+ (instancetype)ccw_timerWithTimeInterval:(NSTimeInterval)time repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block
{
    // 此时的 target 为 NSTimer
    return [NSTimer timerWithTimeInterval:time target:self selector:@selector(timeAction:) userInfo:block repeats:repeats];
}

+ (void)timeAction:(NSTimer *)timer {
    
    void (^block)(NSTimer *) = [timer userInfo];
    
    !block?:block(timer);
}
@end
