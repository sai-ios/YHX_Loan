//
//  NSAgreeBookBean.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/29.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoanApplyModel.h"
@interface NSAgreeBookBean : NSObject

@property(nonatomic, strong) NSString *customerName;//客户名称
@property(nonatomic, strong) NSString *customerCardNo;//身份证号：
@property(nonatomic, strong) NSString *customerMobile;//联系电话：
@property(nonatomic, assign)  double loanMoneyAmount;//1、借款本金计人民币
@property(nonatomic, strong) NSString *loanMoneyAmountCapital;//元（大写：
@property(nonatomic, assign) NSInteger loanTermCount;//2、借款期限：

@property(nonatomic, strong) NSString *loanBankCardNO;//3、银行卡号
@property(nonatomic, strong) NSString *loanBankName; //2、开户行：
@property(nonatomic, strong) NSString *originalLoanRegDate;//起/签约时间
@property(nonatomic, strong) NSString *finishDate;//截止日期

-(instancetype)setBookData:(LoanApplyModel *)loan;

@end
