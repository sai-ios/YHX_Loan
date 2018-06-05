//
//  DateUtils.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/21.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils
// 将字符串格式时间转换成其他格式的时间字符串
+ (NSString *)dateFormatter:(NSString *)dataStr beforePattren:(NSString*)beforePt afterPattren:(NSString*)afterPt{
    
    NSDateFormatter* beforeFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [beforeFormat setDateFormat:beforePt];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[beforeFormat dateFromString:dataStr];
    //最后需要转换的类型
    NSDateFormatter* afterFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [afterFormat setDateFormat:afterPt];//设定时间格式,这里可以设置成自己需要的格式
    
    return  [afterFormat stringFromDate:date];
    
}

+(NSString*)timesFormatString:(NSString *)times Pattren:(NSString*)pattren{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[times doubleValue] / 1000.0;
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [format setDateFormat:pattren];//设定时间格式,这里可以设置成自己需要的格式
    return [format stringFromDate:date];
}

// 字符串转化成时间
+ (NSDate *)DateWithString:(NSString*)dateStr pattren:(NSString*)pattren{
    NSDateFormatter* format = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [format setDateFormat:pattren];//设定时间格式,这里可以设置成自己需要的格式
   return [format dateFromString:dateStr];
}

// 获取当前时间
+ (NSString *)getDate:(NSString*)pattren{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:pattren];
    NSDate *date = [NSDate date];
    return [formatter stringFromDate:date];
}

/*
 * 判断两个时间A>B ? true : fasle
 * true：A在B前面
 * fasle：A在B后面
 */
+(BOOL)compareDate:(NSString *)dateStr1 Date1Pattren:(NSString *)pt1 date2:(NSString*)dateStr2 Date2Pattren:(NSString *)pt2{
    
    NSDate *date1 = [self DateWithString:dateStr1 pattren:pt1];
    NSDate *date2 = [self DateWithString:dateStr2 pattren:pt2];
    
    return [date1 compare:date2] == NSOrderedDescending;
    
}

/**
 * 计算特定时间 几年 几月 几日 后的时间
 *
 */
+ (NSString *)dateCalendar:(NSDate*)date addType:(DateAddCompType)type count:(NSInteger)cout pattern:(NSString *)pattern{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    if(type == AddCompDay){
        long day = [lastDayComp day];
        [lastDayComp setDay:day+cout];
    }
    
    if(type == AddCompYear){
        long year = [lastDayComp year];
        [lastDayComp setYear:year+cout];
    }
    if(type == AddCompMonth){
        long month = [lastDayComp month];
        [lastDayComp setMonth:month+cout];
    }
    if(type == AddCompHour){
        long hour = [lastDayComp hour];
        [lastDayComp setHour:hour+cout];
    }
    
    if(type == AddCompWeekday){
        long day = [lastDayComp day];
        [lastDayComp setDay:day+cout*7];
    }
    
    NSDate *lastDate = [calendar dateFromComponents:lastDayComp];
    NSDateFormatter* format = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [format setDateFormat:pattern];//设定时间格式,这里可以设置成自己需要的格式
    return [format stringFromDate:lastDate];
    
}



@end
