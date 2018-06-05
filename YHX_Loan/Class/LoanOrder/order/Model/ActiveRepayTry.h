//
//  ActiveRepayTry.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Fee,FeeArray;
@interface ActiveRepayTry : NSObject

@property(nonatomic, assign)  double prcp_amt;        //归还本金
@property(nonatomic, assign)  double norm_int;        //归还利息
@property(nonatomic, assign)  double od_int;          //归还罚息
@property(nonatomic, assign)  double comm_int;        //归还复利
@property(nonatomic, assign)  double fee_amt;         //归还费用
@property(nonatomic, assign)  double actv_norm_int;   //当前利息
@property(nonatomic, assign)  double actv_prcp;       //当前本金
@property(nonatomic, assign)  double rel_perd_cnt;    //相对缩期期数
//费率汇总字段
@property(nonatomic, assign)  double  payFeeAmt;         //实际费用金额
@property(nonatomic, assign)  double  thirdLiqAmt;         //违约金实际费用金额
@property(nonatomic, strong)  NSArray<FeeArray *> *feeArray;  //费用列表数组

+(instancetype)tryWithDic:(NSDictionary *)dic;
@end

@interface FeeArray : NSObject

@property(nonatomic, strong)  Fee *structs;
+(instancetype)feeArrayWithDic:(NSDictionary *)dic;
@end
