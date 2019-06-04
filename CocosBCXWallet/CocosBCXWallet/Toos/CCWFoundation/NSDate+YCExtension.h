//
//  NSDate+YCExtension.h
//  YCPublicCocosHDWallet
//
//  Created by Mac on 2017/5/17.
//  Copyright © 2017年 xinhuanwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCNSDateFormatter.h"

@interface NSDate (YCExtension)
//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string;
#pragma mark - ISO 8601格式转NSDate
- (NSString *)formatterToISO8601;
/**
 *  计算分钟
 */
-(NSInteger)minuteToNowDate;

//计数网路反回来时间和当前系统反时间差；
+(NSInteger)minuteToNowDateFromCreatedDate:(NSString *)createdDate;

//截取时间字符串
+(NSString *)weekDayfromCreatedDate:(NSString *)strDate;

//截取时间字符串（2015-10-30 周五 17:25）(扣电)
+(NSString *)weekDayForKDfromCreatedDate:(NSString *)strDate;

// 传入日期和 X分钟，计算X分钟后的日期，返回计算后的日期
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMinute:(int)minute;
/**
 *  计算天数
 */
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day;



//计算年龄
+ (NSInteger)yearToNowDate:(NSString *)bdateStr;

/*
 * 获取几天前的日期
 */

+ (NSString *)getYesterdayDate:(int)dayAgo;

//把时间转成12小时

+(NSString *)timeTransformation:(NSString *)cousultTime;


//以下是新增方法


#pragma mark - 距离距现在分钟差
- (NSInteger)yc_minuteToNowDate;
#pragma mark - 计算年龄
+ (NSInteger)yc_yearToNowDate:(NSString *)bdateStr;

#pragma mark - 把时间转成12小时
+(NSString *)yc_timeTransformation:(NSString *)cousultTime;

#pragma mark - 增加几天后的日期
- (NSDate *)yc_dateByAddingDays: (NSInteger) dDays;

#pragma mark - 减少几天后的日期
- (NSDate *)yc_dateBySubtractingDays: (NSInteger) dDays;

#pragma mark - 几小时后的日期
- (NSDate *)yc_dateByAddingHours: (NSInteger) dHours;

#pragma mark - 几小时前的日期
- (NSDate *)yc_dateBySubtractingHours: (NSInteger) dHours;

#pragma mark - 几分钟后的日期
- (NSDate *)yc_dateByAddingMinutes: (NSInteger) dMinutes;

#pragma mark - 几分钟前的日期
- (NSDate *)yc_dateBySubtractingMinutes: (NSInteger) dMinutes;

#pragma mark - 距离今天几天后的日期
+ (NSDate *)yc_dateWithDaysFromNow: (NSInteger) days;

#pragma mark - 距离今天几天前的日期
+ (NSDate *)yc_dateWithDaysBeforeNow: (NSInteger) days;

#pragma mark - 明天日期
+ (NSDate *)yc_dateTomorrow;

#pragma mark - 昨天日期
+ (NSDate *)yc_dateYesterday;

#pragma mark - 两个日期进行比较
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

#pragma mark - 是不是今天
- (BOOL)yc_isToday;

#pragma mark - 是不是明天
- (BOOL)yc_isTomorrow;

#pragma mark - 是不是昨天
- (BOOL)yc_isYesterday;

#pragma mark - 是不是相同的星期
- (BOOL)yc_isSameWeekAsDate: (NSDate *) aDate;

#pragma mark - 是不是本周
- (BOOL)yc_isThisWeek;

#pragma mark - 是不是下周
- (BOOL)yc_isNextWeek;

#pragma mark - 是不是上周
- (BOOL)yc_isLastWeek;

#pragma mark - 是不是相同月份
- (BOOL)yc_isSameMonthAsDate: (NSDate *) aDate;

#pragma mark - 是不是本月
- (BOOL)yc_isThisMonth;

#pragma mark - 是不是相同的年份
- (BOOL)yc_isSameYearAsDate: (NSDate *) aDate;

#pragma mark - 是不是今年
- (BOOL) yc_isThisYear;

#pragma mark - 是不是明年
- (BOOL) yc_isNextYear;

#pragma mark - 是不是去年
- (BOOL) yc_isLastYear;

#pragma mark - 早于某个日期
- (BOOL) yc_isEarlierThanDate: (NSDate *) aDate;

#pragma mark - 晚于某个日期
- (BOOL) yc_isLaterThanDate: (NSDate *) aDate;

#pragma mark - 是不是将来的某一天
- (BOOL) yc_isInFuture;

#pragma mark - 是不是过去的某一天
- (BOOL) yc_isInPast;

#pragma mark - 是不是周末
- (BOOL) yc_isTypicallyWeekend;

#pragma mark - 是不是工作日
- (BOOL) yc_isTypicallyWorkday;

#pragma mark - 小时
- (NSInteger) yc_hour;

#pragma mark - 分钟
- (NSInteger) yc_minute;

#pragma mark - 秒
- (NSInteger) yc_seconds;

#pragma mark - 天
- (NSInteger) yc_day;

#pragma mark - 月
- (NSInteger) yc_month;

#pragma mark - 星期
- (NSInteger) yc_weekday;

#pragma mark - 该年第几周
- (NSInteger) yc_weekOfYear;

#pragma mark - 年份
- (NSInteger) yc_year;

#pragma mark - :获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒“
- (NSDateComponents *)yc_componentsOfDay;

#pragma mark - 当天的起始时间(00:00:00）
- (NSDate *)yc_beginingOfDay;

#pragma mark - 获取当天的结束时间（23:59:59）
- (NSDate *)yc_endOfDay;

#pragma mark - 当月的第一天
- (NSDate *)yc_firstDayOfTheMonth;

#pragma mark - 当月的最后一天
- (NSDate *)yc_lastDayOfTheMonth;

#pragma mark - 前一个月的第一天
- (NSDate *)yc_firstDayOfThePreviousMonth;

#pragma mark - 下一个月的第一天
- (NSDate *)yc_firstDayOfTheFollowingMonth;

#pragma mark - 当月的天数
- (NSUInteger)yc_numberOfDaysInMonth;

#pragma mark - 获取当月的周数
- (NSUInteger)yc_numberOfWeeksInMonth;

#pragma mark - 这一周的第一天
- (NSDate *)yc_firstDayOfTheWeek;

#pragma mark - 前一周的第一天
- (NSDate *)yc_firstDayOfThePreviousWeekInTheMonth;

#pragma mark - 当月中，这一周的第一天
- (NSDate *)yc_firstDayOfTheWeekInTheMonth;

#pragma mark - 当天是当月的第几周
- (NSUInteger)yc_weekOfDayInMonth;

#pragma mark - 获取前一周中与当天对应的日期
- (NSDate *)yc_associateDayOfThePreviousWeek;

#pragma mark - 后一周中与当天对应的日期
- (NSDate *)yc_associateDayOfTheFollowingWeek;

#pragma mark - 忽略年月日
- (NSDate *)yc_dateRemoveYMD;

#pragma mark - 加上时区偏移
- (NSDate *)yc_changeZone;

#pragma mark - 毫秒数
- (NSTimeInterval)yc_millisecondSince1970;

#pragma mark - 年月
- (NSString *)yc_yearMonthString;

#pragma mark - 月日
- (NSString *)yc_monthDayString;

#pragma mark - 时分
- (NSString *)yc_hourMinuteString;

#pragma mark - 月份的英文表示
+ (NSString *)yc_getEnglishMonth:(int)month;

#pragma mark - 格式化日期 精确到天
- (NSDate *)yc_dateAccurateToDay;

#pragma mark - 格式化日期 精确到小时
- (NSDate *)yc_dateAccurateToHour;

#pragma mark - 格式化日期 精确到月份
- (NSDate *)yc_dateAccurateToMonth;

#pragma mark - 一年的开始
- (NSDate *)yc_beginningOfYear;

#pragma mark - 一年的结束
- (NSDate *)yc_endOfYear;

#pragma mark - 获取当前是星期
+ (NSString*)yc_weekdayStringFromDate:(NSDate*)inputDate;

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
- (NSString *)stringOfDateWithFormat:(YcFormatterStyle)style;


//style  应该和 dateString的格式是一一对应的
+(NSDate*)dateOfStringWithFormat:(YcFormatterStyle)style WithDateString:(NSString *)dateString;

-(NSDate*)dateOfStringWithFormat:(YcFormatterStyle)style WithDateString:(NSString *)dateString;


@end
