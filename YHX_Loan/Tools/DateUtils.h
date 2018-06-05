//
//  DateUtils.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/21.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, DateAddCompType) {
    AddCompYear = 0,
    AddCompMonth,
    AddCompDay,
    AddCompHour,
    AddCompWeekday
};

@interface DateUtils : NSObject

+ (NSString *)dateFormatter:(NSString *)dataStr beforePattren:(NSString*)beforePt afterPattren:(NSString*)afterPt;

+ (NSDate *)DateWithString:(NSString*)dateStr pattren:(NSString*)pattren;
// 时间戳转时间格式字符串
+(NSString*)timesFormatString:(NSString *)times Pattren:(NSString*)pattren;

// 获取当前时间
+ (NSString *)getDate:(NSString*)pattren;

+(BOOL)compareDate:(NSString *)dateStr1 Date1Pattren:(NSString *)pt1 date2:(NSString*)dateStr2 Date2Pattren:(NSString *)pt2;

+ (NSString *)dateCalendar:(NSDate*)date addType:(DateAddCompType)type count:(NSInteger)cout pattern:(NSString *)pattern;

@end
