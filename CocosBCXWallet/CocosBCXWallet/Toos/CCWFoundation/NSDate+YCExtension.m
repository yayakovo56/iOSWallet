//
//  NSDate+YCExtension.m
//  YCPublicCocosHDWallet
//
//  Created by Mac on 2017/5/17.
//  Copyright © 2017年 xinhuanwangluo. All rights reserved.
//

#import "NSDate+YCExtension.h"

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926
#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (YCExtension)

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    if ([string containsString:@"."]) {
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    }
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

#pragma mark - ISO 8601格式转NSDate
- (NSString *)formatterToISO8601{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    
    NSString *formattedDateString = [dateFormatter stringFromDate: self];
    return formattedDateString;
}


+ (void)saveCurrentTimeWithName:(NSString *)name{
    if (name == nil) {
        return;
    }
    
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *formatter =  [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *strdate = [formatter stringFromDate:nowDate];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:strdate forKey:name];
    
    [def synchronize];
}

//分钟差
- (NSInteger)minuteToNowDate
{
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitSecond fromDate:self toDate:now options:0];
    return comp.minute;
}


//计算年龄
+ (NSInteger)yearToNowDate:(NSString *)bdateStr
{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd";
    
    NSDate *bdate = [fmt dateFromString:bdateStr];
    
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear fromDate:bdate toDate:now options:0];
    return comp.year;
}

//计数网路反回来时间和当前系统反时间差；
+ (NSInteger)minuteToNowDateFromCreatedDate:(NSString *)createdDate
{
    NSDateFormatter *mf = [[NSDateFormatter alloc] init];
    
    mf.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [mf dateFromString:createdDate];
    
    return [date minuteToNowDate];
    
}
//截取时间字符串（2015-10-30 周五 17:25）
+(NSString *)weekDayfromCreatedDate:(NSString *)strDate
{
    NSArray *arrDate = [strDate componentsSeparatedByString:@"T"];
    
    NSArray *strArr = [arrDate[0] componentsSeparatedByString:@"-"];
    NSInteger year = [strArr[0] integerValue];
    NSInteger month = [strArr[1] integerValue];
    NSInteger day = [strArr[2] integerValue];
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:day];
    [_comps setMonth:month];
    [_comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger weekday = [weekdayComponents weekday];
    
    NSString *str;
    if (weekday ==1) {
        str = @"周日";
    }else if (weekday ==2){
        str = @"周一";
    }else if (weekday ==3){
        str = @"周二";
    }else if (weekday ==4){
        str = @"周三";
    }else if (weekday ==5){
        str = @"周四";
    }else if (weekday ==6){
        str = @"周五";
    }else if (weekday ==7){
        str = @"周六";
    }
    NSString *strTime = [arrDate[1] substringToIndex:5];
    
    NSString *strdate = [NSString stringWithFormat:@"%@(%@)%@",arrDate[0],str,strTime];
    
    
    return strdate;
}


//截取时间字符串（2015-10-30 周五 17:25）(扣电)
+(NSString *)weekDayForKDfromCreatedDate:(NSString *)strDate
{
    NSArray *arrDate = [strDate componentsSeparatedByString:@" "];
    
    NSArray *strArr = [arrDate[0] componentsSeparatedByString:@"-"];
    NSInteger year = [strArr[0] integerValue];
    NSInteger month = [strArr[1] integerValue];
    NSInteger day = [strArr[2] integerValue];
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:day];
    [_comps setMonth:month];
    [_comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger weekday = [weekdayComponents weekday];
    
    NSString *str;
    if (weekday ==1) {
        str = @"周日";
    }else if (weekday ==2){
        str = @"周一";
    }else if (weekday ==3){
        str = @"周二";
    }else if (weekday ==4){
        str = @"周三";
    }else if (weekday ==5){
        str = @"周四";
    }else if (weekday ==6){
        str = @"周五";
    }else if (weekday ==7){
        str = @"周六";
    }
    NSString *strTime = [arrDate[1] substringToIndex:5];
    
    NSString *strdate = [NSString stringWithFormat:@"%@(%@)%@",arrDate[0],str,strTime];
    
    
    return strdate;
}


// 传入日期和 X分钟，计算X分钟后的日期，返回计算后的日期
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMinute:(int)minute

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMinute:minute];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    
    
    return mDate;
    
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:day];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    
    
    return mDate;
    
}

+ (NSString *)getYesterdayDate:(int)dayAgo
{
    NSDate * yesterDayDte = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60 * dayAgo)];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateString = [dateFormatter stringFromDate:yesterDayDte];
    return dateString;
}

//把时间转成12小时

+(NSString *)timeTransformation:(NSString *)cousultTime
{
    
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    //从沙盒去取出过去获取token时间
    NSDate *pastDate = [fmt dateFromString:cousultTime];
    
    NSCalendar *calend = [NSCalendar currentCalendar];
    NSDateComponents *components = [calend components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:pastDate];
    
    NSString *strdate ;
    
    if ([components hour]>12) {
        
        strdate = [NSString stringWithFormat:@"%ld:%ld PM",([components hour]-12),[components minute]];
        
    }else{
        
        
        strdate = [NSString stringWithFormat:@"%ld:%ld AM",[components hour],[components minute]];
    }
    
    return strdate;
}





/*******************************************************************************/


#pragma mark - 距离距现在分钟差
- (NSInteger)yc_minuteToNowDate{
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitMinute fromDate:self toDate:now options:0];
    return comp.minute;
}
#pragma mark - 计算年龄
+ (NSInteger)yc_yearToNowDate:(NSString *)bdateStr
{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd";
    
    NSDate *bdate = [fmt dateFromString:bdateStr];
    
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear fromDate:bdate toDate:now options:0];
    return comp.year;
}

#pragma mark - 把时间转成12小时
+(NSString *)yc_timeTransformation:(NSString *)cousultTime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    //从沙盒去取出过去获取token时间
    NSDate *pastDate = [fmt dateFromString:cousultTime];
    NSCalendar *calend = [NSCalendar currentCalendar];
    NSDateComponents *components = [calend components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:pastDate];
    NSString *strdate ;
    if ([components hour]>12) {
        strdate = [NSString stringWithFormat:@"%ld:%ld PM",([components hour]-12),[components minute]];
    }else{
        strdate = [NSString stringWithFormat:@"%ld:%ld AM",[components hour],[components minute]];
    }
    return strdate;
}

#pragma mark - 增加几天后的日期
- (NSDate *)yc_dateByAddingDays: (NSInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - 减少几天后的日期
- (NSDate *)yc_dateBySubtractingDays: (NSInteger) dDays
{
    return [self yc_dateByAddingDays: (dDays * -1)];
}

#pragma mark - 几小时后的日期
- (NSDate *)yc_dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - 几小时前的日期
- (NSDate *)yc_dateBySubtractingHours: (NSInteger) dHours
{
    return [self yc_dateByAddingHours: (dHours * -1)];
}

#pragma mark - 几分钟后的日期
- (NSDate *)yc_dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
#pragma mark - 几分钟前的日期
- (NSDate *)yc_dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self yc_dateByAddingMinutes: (dMinutes * -1)];
}
#pragma mark - 距离今天几天后的日期
+ (NSDate *)yc_dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] yc_dateByAddingDays:days];
}
#pragma mark - 距离今天几天前的日期
+ (NSDate *)yc_dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] yc_dateBySubtractingDays:days];
}
#pragma mark - 明天日期
+ (NSDate *)yc_dateTomorrow
{
    return [NSDate yc_dateWithDaysFromNow:1];
}

#pragma mark - 昨天日期
+ (NSDate *)yc_dateYesterday
{
    return [NSDate yc_dateWithDaysBeforeNow:1];
}
#pragma mark - 两个日期进行比较
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}
#pragma mark - 是不是今天
- (BOOL)yc_isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

#pragma mark - 是不是明天
- (BOOL)yc_isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate yc_dateTomorrow]];
}

#pragma mark - 是不是昨天
- (BOOL)yc_isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate yc_dateYesterday]];
}

#pragma mark - 是不是相同的星期
- (BOOL)yc_isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

#pragma mark - 是不是本周
- (BOOL)yc_isThisWeek
{
    return [self yc_isSameWeekAsDate:[NSDate date]];
}

#pragma mark - 是不是下周
- (BOOL)yc_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yc_isSameWeekAsDate:newDate];
}

#pragma mark - 是不是上周
- (BOOL)yc_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yc_isSameWeekAsDate:newDate];
}

#pragma mark - 是不是相同月份
- (BOOL)yc_isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}
#pragma mark - 是不是本月
- (BOOL)yc_isThisMonth
{
    return [self yc_isSameMonthAsDate:[NSDate date]];
}

#pragma mark - 是不是相同的年份
- (BOOL)yc_isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

#pragma mark - 是不是今年
- (BOOL) yc_isThisYear
{
    // Thanks, baspellis
    return [self yc_isSameYearAsDate:[NSDate date]];
}

#pragma mark - 是不是明年
- (BOOL) yc_isNextYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

#pragma mark - 是不是去年
- (BOOL) yc_isLastYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

#pragma mark - 早于某个日期
- (BOOL) yc_isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

#pragma mark - 晚于某个日期
- (BOOL) yc_isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

#pragma mark - 是不是将来的某一天
- (BOOL) yc_isInFuture
{
    return ([self yc_isLaterThanDate:[NSDate date]]);
}

#pragma mark - 是不是过去的某一天
- (BOOL) yc_isInPast
{
    return ([self yc_isEarlierThanDate:[NSDate date]]);
}

#pragma mark - 是不是周末
- (BOOL) yc_isTypicallyWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

#pragma mark - 是不是工作日
- (BOOL) yc_isTypicallyWorkday
{
    return ![self yc_isTypicallyWeekend];
}

#pragma mark - 小时
- (NSInteger) yc_hour
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.hour;
}

#pragma mark - 分钟
- (NSInteger) yc_minute
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.minute;
}

#pragma mark - 秒
- (NSInteger) yc_seconds
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.second;
}

#pragma mark - 天
- (NSInteger) yc_day
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.day;
}

#pragma mark - 月
- (NSInteger) yc_month
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.month;
}

#pragma mark - 星期
- (NSInteger) yc_weekday
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    if (components.weekday==1) {
        return 7;
    }
    return components.weekday-1;
}

#pragma mark - 该年第几周
- (NSInteger) yc_weekOfYear
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekOfYear;
}

#pragma mark - 年份
- (NSInteger) yc_year
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.year;
}

/*
 （ps: weekOfMonth是指该日期是本月的第几周。一周从星期日开始。
 weekdayOrdinal是指该日期是本月的第几个星期几。有点混乱啊。结合weekOfMonth举个例子：
 如果本月是从周二开始的，即1号是周二，2号是周三，6号是周日，7号是周一，8号是第二个周二。
 那么如果日期设定为1，2，3，4，5号的话，则weekOfMonth和weekdayOrdinal都是1。
 那么如果日期设定为6，7号的话，则weekOfMonth是2，但是weekdayOrdinal却是1，因为6号虽然是第二周，但是却是本月第一个周日，同样7号虽然也是第二周，但是却是本月第一个周一。
 ）
 
 */
#pragma mark - :获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒“
- (NSDateComponents *)yc_componentsOfDay
{
    static NSDateComponents *dateComponents = nil;
    static NSDate *previousDate = nil;
    
    if (!previousDate || ![previousDate isEqualToDate:self]) {
        previousDate = self;
        dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSWeekCalendarUnit| NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    }
    return dateComponents;
}

#pragma mark - 当天的起始时间(00:00:00）
- (NSDate *)yc_beginingOfDay
{
    [[self yc_componentsOfDay] setHour:0];
    [[self yc_componentsOfDay] setMinute:0];
    [[self yc_componentsOfDay] setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:[self yc_componentsOfDay]];
}
#pragma mark - 获取当天的结束时间（23:59:59）
- (NSDate *)yc_endOfDay
{
    [[self yc_componentsOfDay] setHour:23];
    [[self yc_componentsOfDay] setMinute:59];
    [[self yc_componentsOfDay] setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:[self yc_componentsOfDay]];
}
#pragma mark - 当月的第一天
- (NSDate *)yc_firstDayOfTheMonth
{
    [[self yc_componentsOfDay] setDay:1];
    return [[NSCalendar currentCalendar] dateFromComponents:[self yc_componentsOfDay]];
}
#pragma mark - 当月的最后一天
- (NSDate *)yc_lastDayOfTheMonth
{
    [[self yc_componentsOfDay] setDay:[self yc_numberOfDaysInMonth]];
    return [[NSCalendar currentCalendar] dateFromComponents:[self yc_componentsOfDay]];
}
#pragma mark - 前一个月的第一天
- (NSDate *)yc_firstDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] yc_firstDayOfTheMonth];
}
#pragma mark - 下一个月的第一天
- (NSDate *)yc_firstDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] yc_firstDayOfTheMonth];
}
#pragma mark - 当月的天数
- (NSUInteger)yc_numberOfDaysInMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}
#pragma mark - 获取当月的周数
- (NSUInteger)yc_numberOfWeeksInMonth
{
    NSUInteger weekOfFirstDay = [[self yc_firstDayOfTheMonth] yc_componentsOfDay].weekday;
    NSUInteger numberDaysInMonth = [self yc_numberOfDaysInMonth];
    
    return ((weekOfFirstDay - 1 + numberDaysInMonth) % 7) ? ((weekOfFirstDay - 1 + numberDaysInMonth) / 7 + 1): ((weekOfFirstDay - 1 + numberDaysInMonth) / 7);
}
#pragma mark - 这一周的第一天
- (NSDate *)yc_firstDayOfTheWeek
{
    NSDate *firstDay = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit startDate:&firstDay interval:NULL forDate:self]) {
        return firstDay;
    }
    
    return firstDay;
}
#pragma mark - 前一周的第一天
- (NSDate *)yc_firstDayOfThePreviousWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self yc_firstDayOfTheWeekInTheMonth];
    if ([firstDayOfTheWeekInTheMonth yc_componentsOfDay].weekday > 1) {
        return nil;
    } else {
        if ([firstDayOfTheWeekInTheMonth yc_componentsOfDay].day > 7) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.day = -7;
            return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
        } else if ([firstDayOfTheWeekInTheMonth yc_componentsOfDay].day > 1) {
            return [self yc_firstDayOfTheMonth];
        } else {
            return nil;
        }
    }
}
#pragma mark - 当月中，这一周的第一天
- (NSDate *)yc_firstDayOfTheWeekInTheMonth
{
    NSDate *firstDayOfTheWeek = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit startDate:&firstDayOfTheWeek interval:NULL forDate:self]) {
        NSDate *firstDayOfTheMonth = [self yc_firstDayOfTheMonth];
        if ([firstDayOfTheWeek yc_componentsOfDay].month == [firstDayOfTheMonth yc_componentsOfDay].month) {
            return firstDayOfTheWeek;
        } else {
            return firstDayOfTheMonth;
        }
    }
    
    return firstDayOfTheWeek;
}
#pragma mark - 当天是当月的第几周
- (NSUInteger)yc_weekOfDayInMonth
{
    NSDate *firstDayOfTheMonth = [self yc_firstDayOfTheMonth];
    NSUInteger weekdayOfFirstDayOfTheMonth = [firstDayOfTheMonth yc_componentsOfDay].weekday;
    NSUInteger day = [self yc_componentsOfDay].day;
    
    return ((day + weekdayOfFirstDayOfTheMonth - 1)%7) ? ((day + weekdayOfFirstDayOfTheMonth - 1)/7) + 1: ((day + weekdayOfFirstDayOfTheMonth - 1)/7);
}
#pragma mark - 获取前一周中与当天对应的日期
- (NSDate *)yc_associateDayOfThePreviousWeek
{
    NSUInteger day = [self yc_componentsOfDay].day;
    NSUInteger weekday = [self yc_componentsOfDay].weekday;
    
    if (day > 7) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = -7;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else if (day > weekday) {
        
        return [self yc_firstDayOfTheMonth];
    } else {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = -1;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[self yc_firstDayOfTheWeekInTheMonth] options:0];
    }
}
#pragma mark - 后一周中与当天对应的日期
- (NSDate *)yc_associateDayOfTheFollowingWeek
{
    NSUInteger numberOfDaysInMonth = [self yc_numberOfDaysInMonth];
    NSUInteger day = [self yc_componentsOfDay].day;
    NSUInteger weekday = [self yc_componentsOfDay].weekday;
    if (day + 7 <= numberOfDaysInMonth) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 7;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else if ((day + (7 - weekday + 1)) <= numberOfDaysInMonth) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = numberOfDaysInMonth - day;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else {
        return [self yc_firstDayOfTheFollowingMonth];
    }
}
#pragma mark - 忽略年月日
- (NSDate *)yc_dateRemoveYMD
{
    NSDate *lastDate = nil;
    @try {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self];
        [components setYear:2014];
        lastDate = [calendar dateFromComponents:components];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] exception:\n%@",__PRETTY_FUNCTION__, __LINE__,exception);
    }
    return lastDate;
}

#pragma mark - 加上时区偏移
- (NSDate *)yc_changeZone
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    return [self  dateByAddingTimeInterval: interval];
}

#pragma mark - 毫秒数
- (NSTimeInterval)yc_millisecondSince1970
{
    return [self timeIntervalSince1970] * 1000;
}
#pragma mark - 年月
- (NSString *)yc_yearMonthString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:self];
    return [NSString stringWithFormat:@"%d年%d月",components.year,components.month];
}
#pragma mark - 月日
- (NSString *)yc_monthDayString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    return [NSString stringWithFormat:@"%d月%d日",components.month,components.day];
}
#pragma mark - 时分
- (NSString *)yc_hourMinuteString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self];
    return [NSString stringWithFormat:@"%d:%02d",components.hour,components.minute];
}
#pragma mark - 月份的英文表示
+ (NSString *)yc_getEnglishMonth:(int)month
{
    NSArray *array = @[@"",@"Jau",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
    return array[month];
}
#pragma mark - 格式化日期 精确到天
- (NSDate *)yc_dateAccurateToDay
{
    NSDate *current = nil;
    @try {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        current = [calendar dateFromComponents:components];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] exception:\n%@",__PRETTY_FUNCTION__, __LINE__,exception);
    }
    return current;
}
#pragma mark - 格式化日期 精确到小时
- (NSDate *)yc_dateAccurateToHour
{
    NSDate *current = nil;
    @try {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit) fromDate:self];
        components.minute = 0;
        components.second = 0;
        current = [calendar dateFromComponents:components];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] exception:\n%@",__PRETTY_FUNCTION__, __LINE__,exception);
    }
    return current;
}
#pragma mark - 格式化日期 精确到月份
- (NSDate *)yc_dateAccurateToMonth
{
    NSDate *current = nil;
    @try {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:self];
        components.day = 1;
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        current = [calendar dateFromComponents:components];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] exception:\n%@",__PRETTY_FUNCTION__, __LINE__,exception);
    }
    return current;
}

#pragma mark - 一年的开始
- (NSDate *)yc_beginningOfYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit fromDate:self];
    
    return [calendar dateFromComponents:components];
}
#pragma mark - 一年的结束
- (NSDate *)yc_endOfYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self yc_beginningOfYear] options:0] dateByAddingTimeInterval:-1];
}
#pragma mark - 获取当前是星期
+ (NSString*)yc_weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

/*
 YcFormatterStyleYYYYMMddHHmmss ,//YYYY-MM-dd HH:mm:ss
 YcFormatterStyleYYYYMMddD,//YYYY.MM.dd
 YcFormatterStyleMdHm ,//MM-dd HH:mm
 YcFormatterStyleYMdHm ,//YYYY年MM月dd日 HH:mm
 YcFormatterStyleMdHmC ,//MM月dd日 HH:mm
 YcFormatterStyleYMdC ,//YYYY年MM月dd日
 YcFormatterStyleYMd ,//YYYY-MM-dd
 */
#pragma mark -  以下是获取制定格式的时间字符串
- (NSString *)stringOfDateWithFormat:(YcFormatterStyle)style
{
    return [[[YCNSDateFormatter shareFormatter] defaultDateFormatterWithStyle:style] stringFromDate:self];
}

//style  应该和 dateString的格式是一一对应的
+(NSDate*)dateOfStringWithFormat:(YcFormatterStyle)style WithDateString:(NSString *)dateString{
    

   return  [[[YCNSDateFormatter shareFormatter] defaultDateFormatterWithStyle:style] dateFromString:dateString];
    
}
-(NSDate*)dateOfStringWithFormat:(YcFormatterStyle)style WithDateString:(NSString *)dateString{
    
    
    return  [[[YCNSDateFormatter shareFormatter] defaultDateFormatterWithStyle:style] dateFromString:dateString];
    
}
@end
