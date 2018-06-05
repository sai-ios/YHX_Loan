//
//  XYRepayPlan.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYRepayPlan;
@interface XYRepayPlan : NSObject
@property(nonatomic, strong)  NSString *ps_perd_no;             //期号
@property(nonatomic, strong)  NSString *ps_due_dt;              //到期日
@property(nonatomic, assign)  double ps_instm_amt;              //期供金额
@property(nonatomic, assign)  double ps_prcp_amt;               //本金
@property(nonatomic, assign)  double ps_norm_int_amt;           //利息
@property(nonatomic, assign)  double ps_od_int_amt;             //罚息
@property(nonatomic, assign)  double ps_comm_od_int;            //复利
@property(nonatomic, assign)  double ps_rem_prcp;               //剩余本金
@property(nonatomic, strong)  NSString *tran_seq;               //平台渠道进件编号
@property(nonatomic, assign)  double setl_prcp;                 //已还本金
@property(nonatomic, assign)  double setl_norm_int;             //已还利息
@property(nonatomic, assign)  double setl_od_int_amt;           //已还罚息
@property(nonatomic, assign)  double setl_comm_od_int;          //已还复利
@property(nonatomic, assign)  double ps_fee;                    //应还滞纳金
@property(nonatomic, assign)  double setl_fee;                  //已还滞纳金
@property(nonatomic, assign)  double ps_fee_amt2;               //应还账户管理费
@property(nonatomic, assign)  double setl_fee_amt2;             //已还账户管理费
@property(nonatomic, assign)  double rdu01Amt;                  //已减免账户管理费
@property(nonatomic, assign)  double ps_wv_nm_int;              //减免利息
@property(nonatomic, assign)  double ps_wv_od_int;              //减免罚息
@property(nonatomic, assign)  double ps_wv_comm_int;            //减免复利
@property(nonatomic, assign)  double fee_amt;                   //分期手续费
@property(nonatomic, assign)  double setl_fee_amt;              //已还分期手续费
@property(nonatomic, assign)  double rdu06Amt;                  //减免手续费
@property(nonatomic, strong)  NSString *setl_ind;               //结清标志
@property(nonatomic, assign)  double setl_comm_amt;             //已还佣金
@property(nonatomic, assign)  double ps_comm_amt;               //应还佣金

+ (instancetype)xyRepayWithDic:(NSDictionary *)dic;

// 将还款计划数组字典转换成模型数组
+ (NSMutableArray *)repayPlanArrayWithDic:(NSArray *)array;
@end


