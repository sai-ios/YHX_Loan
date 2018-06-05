//
//  ORCIDCardModel.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORCIDCardModel : NSObject

// 户籍地址
@property(nonatomic, strong) NSString *address;
// 身份证号
@property(nonatomic, strong) NSString *idNumber;
// 出生日期
@property(nonatomic, strong) NSString *birthday;
// 姓名
@property(nonatomic, strong) NSString *name;
// 性别
@property(nonatomic, strong) NSString *sex;
// 民族
@property(nonatomic, strong) NSString *ethnic;
// 签发日期
@property(nonatomic, strong) NSString *signDate;
// 失效日期
@property(nonatomic, strong) NSString *expiryDate;
// 签发机关
@property(nonatomic, strong) NSString *issueAuthority;

+(ORCIDCardModel *)orcIdCardWithDic :(ORCIDCardModel*)idCard dict:(NSDictionary *)dict;

@end
/*
 {
 "log_id" : 8296041629350471628,
 "words_result_num" : 6,
 "image_status" : "normal",
 "words_result" : {
 "姓名" : {
 "words" : "牛赛兵",
 "location" : {
 "top" : 67,
 "width" : 42,
 "height" : 17,
 "left" : 91
 }
 },
 "出生" : {
 "words" : "19930117",
 "location" : {
 "top" : 120,
 "width" : 98,
 "height" : 15,
 "left" : 91
 }
 },
 "公民身份号码" : {
 "words" : "530322199301170732",
 "location" : {
 "top" : 213,
 "width" : 188,
 "height" : 20,
 "left" : 149
 }
 },
 "性别" : {
 "words" : "男",
 "location" : {
 "top" : 98,
 "width" : 9,
 "height" : 12,
 "left" : 89
 }
 },
 "住址" : {
 "words" : "云南省曲靖市陆良县板桥镇河东村委会北头村35号",
 "location" : {
 "top" : 147,
 "width" : 143,
 "height" : 35,
 "left" : 92
 }
 },
 "民族" : {
 "words" : "汉",
 "location" : {
 "top" : 96,
 "width" : 8,
 "height" : 10,
 "left" : 159
 }
 }
 },
 "direction" : 0
 } 
 {
 "log_id" : 7710910597710612231,
 "words_result_num" : 3,
 "image_status" : "normal",
 "words_result" : {
 "失效日期" : {
 "words" : "20271009",
 "location" : {
 "top" : 216,
 "width" : 68,
 "height" : 13,
 "left" : 269
 }
 },
 "签发日期" : {
 "words" : "20171009",
 "location" : {
 "top" : 216,
 "width" : 69,
 "height" : 13,
 "left" : 189
 }
 },
 "签发机关" : {
 "words" : "陆良县公安局",
 "location" : {
 "top" : 186,
 "width" : 79,
 "height" : 12,
 "left" : 189
 }
 }
 },
 "direction" : 0
 } 
 */
