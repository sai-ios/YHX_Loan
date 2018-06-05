//
//  RepayHistory.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RepayHistory;
@interface RepayHistory : NSObject

// ID
@property(nonatomic, strong)  NSString *id;
 // 进件单号
@property(nonatomic, strong)  NSString *busCode;
 // 平台流水号
@property(nonatomic, strong)  NSString *chnseq;

 // 还款日期
@property(nonatomic, strong)  NSString *repayDate;

 // 交易流水号
@property(nonatomic, strong)  NSString *transSeq;

 // 还款模式
@property(nonatomic, strong)  NSString *mtdmodel;

 // 还款类型 01 指定金额还款 02全部还款 mtdmodel='FS'时使用02， 其余还款模式下默认01 还款模式为归还欠款时，还款类型必填
@property(nonatomic, strong)  NSString *mtdtyp;

// 还款总额
@property(nonatomic, assign)  double mtdamt;

 // 是否发送清算
@property(nonatomic, strong)  NSString *clearflag;

 // 交易类型 IN存入OUT转出
@property(nonatomic, strong)  NSString *tradetype;

 // 违约金
@property(nonatomic, assign)  double thirdLiqAmt;

 // 0:成功  1:失败 2:处理中
@property(nonatomic, strong)  NSString *repayStatus;

 // 响应结果
@property(nonatomic, strong)  NSString *respMsg;

 // 说明
@property(nonatomic, strong)  NSString *remark;

 // 系统更新时间
@property(nonatomic, strong)  NSString *sysUpdateTime;

+(instancetype)historyWithDic:(NSDictionary *)dic;
+(NSArray *)historyArrayWithDic:(NSArray *)array;
@end













