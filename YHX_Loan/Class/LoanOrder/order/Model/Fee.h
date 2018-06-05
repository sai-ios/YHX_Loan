//
//  Fee.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Fee : NSObject

@property(nonatomic, strong)  NSString *fee_cde;         //费用代码
@property(nonatomic, strong)  NSString *base_amt;        //基准金额
@property(nonatomic, strong)  NSString *fee_amt;         //费用金额
@property(nonatomic, strong)  NSString *pay_amt;         //实际费用金额
@property(nonatomic, strong)  NSString *fee_waive;       //减免金额
@property(nonatomic, strong)  NSString *chrg_pct;        //费率
@property(nonatomic, strong)  NSString *fee_desc;        //费用描述
@property(nonatomic, strong)  NSString *fee_typ;         //费用类型
@property(nonatomic, strong)  NSString *loan_no;         //借据号
@property(nonatomic, strong)  NSString *setl_dt;         //结算日期
@property(nonatomic, strong)  NSString *hold_fee_ind;    //
@property(nonatomic, strong)  NSString *fee_src;         //
@property(nonatomic, strong)  NSString *recv_pay_ind;    //

+(instancetype)feeWithDic:(NSDictionary *)dic;
@end


