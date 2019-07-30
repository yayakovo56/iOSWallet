//
//  MJRefreshStateHeader+Localize.m
//  TaiYangHua
//
//  Created by admin on 16/11/24.
//  Copyright © 2016年 hhly. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>
/*********** 下拉条本地化语言处理 add by SYLing 2016.11.24 *************/
@implementation MJRefreshStateHeader (Localize)
/** 覆盖原始类的方法对时间显示进行本地化 add by SYLing 2016.11.24 */
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    // 如果有block
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSString *time = nil;
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat =@"HH:mm";
            //time = [formatter stringFromDate:lastUpdatedTime];
            time = [NSString stringWithFormat:@"%@ %@", CCWLocalizable(@"今天"),[formatter stringFromDate:lastUpdatedTime]];
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
            time = [formatter stringFromDate:lastUpdatedTime];
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
            time = [formatter stringFromDate:lastUpdatedTime];
        }
        
        // 3.显示日期
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat: CCWLocalizable(@"最后更新：%@"), time];
    } else {
        self.lastUpdatedTimeLabel.text =  CCWLocalizable(@"最后更新：无记录");
    }
}

- (void)prepare
{
    [super prepare];
    
    // 初始化文字
    [self setTitle:CCWLocalizable(@"下拉可以刷新") forState:MJRefreshStateIdle];
    [self setTitle:CCWLocalizable(@"松开立即刷新") forState:MJRefreshStatePulling];
    [self setTitle:CCWLocalizable(@"正在刷新数据中...") forState:MJRefreshStateRefreshing];
    
    // 图标的距离
    self.labelLeftInset = 10;
}

@end

#pragma mark - MJRefreshAutoStateFooter

@implementation MJRefreshAutoStateFooter (Localize)
- (void)prepare
{
    [super prepare];
    
    // 初始化文字
    [self setTitle:CCWLocalizable(@"点击或上拉加载更多") forState:MJRefreshStateIdle];
    [self setTitle:CCWLocalizable(@"正在加载更多的数据...") forState:MJRefreshStateRefreshing];
    [self setTitle:CCWLocalizable(@"已经全部加载完毕") forState:MJRefreshStateNoMoreData];
    
    // 监听label
    self.stateLabel.userInteractionEnabled = YES;
    [self.stateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(@"stateLabelClick")]];
}
@end
