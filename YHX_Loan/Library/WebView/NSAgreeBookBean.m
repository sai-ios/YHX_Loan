//
//  NSAgreeBookBean.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/29.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "NSAgreeBookBean.h"
#import "NUmberToCN.h"
@implementation NSAgreeBookBean

-(instancetype)setBookData:(LoanApplyModel *)loan{
    self.customerName = loan.realName;//客户名称
    self.customerCardNo = loan.idCardNumber;//身份证号：
    self.customerMobile = loan.loginName;//联系电话：
    self.loanMoneyAmount = loan.loanMoneyAmount;//1、借款本金计人民币
    self.loanMoneyAmountCapital = [NUmberToCN numberToCN:[NSString stringWithFormat:@"%.2f", loan.loanMoneyAmount] ];//元（大写：
    self.loanTermCount = loan.loanTermCount;//2、借款期限：
    
    self.loanBankCardNO = loan.bankCardNumber;//3、银行卡号
    self.loanBankName = loan.bankName; //2、开户行：
    self.originalLoanRegDate = [DateUtils getDate:@"yyyy年MM月dd日"];//起/签约时间
    
    self.finishDate = [DateUtils dateCalendar:[NSDate date] addType:AddCompMonth count: loan.loanTermCount pattern:@"yyyy年MM月dd日"];//截止日期
    return self;
}
@end
