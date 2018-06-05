//
//  STools.h
//  IOS-基础学习
//
//  Created by 张磊 on 2018/3/12.
//  Copyright © 2018年 niusaibing. All rights reserved.
//
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#import <Foundation/Foundation.h>
//  (1)验证电话号码：（”^(\\d{3,4}-)\\d{7,8}$”）
static NSString * const PATTERN_Phone = @"^1[1|3|4|5|7|8][0-9]{9}$";
//  (2)验证Email地址：(“^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\.\\w+([-.]\\w+)*$”)；
static NSString * const PATTERN_Email = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*$";
//  (3)整数或者小数：^[0-9]+([.]{0,1}[0-9]+){0,1}$
static NSString * const PATTERN_float = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
//  (4)只能输入数字：”^[0-9]*$”。
static NSString * const PATTERN_number = @"^[0-9]*$";
//  (5)只能输入由26个英文字母组成的字符串：”^[A-Za-z]+$”。
static NSString * const PATTERN_Letter = @"^[A-Za-z]+$";
//  (6)验证是否含有^%&’,;=?$\”等字符：”[^%&',;=?$\x22]+”。
static NSString * const PATTERN_special = @"[^%&',;=?$\x22]+";
//  (7)只能输入汉字：”^[\u4e00-\u9fa5]{0,}$”。
static NSString * const PATTERN_China = @"^[\u4e00-\u9fa5]{0,}$";
//　(11)匹配空白行的正则表达式：\n\s*\r   注：可以用来删除空白行
static NSString * const PATTERN_space = @"\\n\\s*\\r";
//　(12)匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$ 注：表单验证时很实用
static NSString * const PATTERN_userName = @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";
//　(13)匹配腾讯QQ号：[1-9][0-9]\{4,\}  注：腾讯QQ号从10 000 开始
static NSString * const PATTERN_QQ = @"[1-9][0-9]\{4,}";
//　(14)匹配中国邮政编码：[1-9]\\d{5}(?!\d) 注：中国邮政编码为6位数字
static NSString * const PATTREN_code = @"[1-9]\\d{5}(?!\\d)";
//　(15)匹配ip地址：((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)。
static NSString * const PATTREN_IP = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
#pragma mark replace
static NSString * const replace_number = @"[^0-9]"; // 或者\D --"\\D"

@interface STools : NSObject
+(BOOL)compile:(NSString *)st pattern:(NSString *)pat;

/**
 *  去除正则内的字符
 */
+(NSString *)replaceAll:(NSString *)str regex:(NSString *)regex replacecement:(NSString *)replacement;

+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

+ (NSString *)dictJsonString:(NSDictionary *)dic;

+ (NSString *)hidetel:(NSString *)tel;

@end
