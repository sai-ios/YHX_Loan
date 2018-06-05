//
//  LoanApplyModel.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "LoanApplyModel.h"
// 创建静态对象 防止外部访问
static LoanApplyModel * _manage;

@implementation LoanApplyModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    // 一次函数
    dispatch_once(&onceToken, ^{
        if (_manage == nil) {
            _manage = [super allocWithZone:zone];
            _manage.locationAddress = @"";
            _manage.loginName= @"";
            _manage.realName= @"";
            _manage.sex= @"";
            _manage.idCardNumber = @"";
            _manage.birthday = @"";
            _manage.mobile = @"";
            _manage.homeTel = @"";
            _manage.email = @"";
            _manage.maritalStatus = @"";
            _manage.supportCount = 0;
            _manage.nowLivingAddress = @"";
            _manage.enducationDegree = @"";
            _manage.companyName = @"";
            _manage.companyType = @"";
            _manage.workState = @"";
            _manage.companyAddress = @"";
            _manage.companyTel   = @"";
            _manage.companyDept   = @"";
            _manage.companyDuty   = @"";
            _manage.companySalaryOfMonth = 0.0;
            _manage.productID = @"";
            _manage.idCardNumberEffectPeriodOfStart = @"";
            _manage.idCardNumberEffectPeriodOfEnd = @"";
            _manage.residenceAddress = @"";
            _manage.bankName = @"";
            _manage.bankCardNumber = @"";
            _manage. bankCardPLMobile = @"";
            _manage.nowLivingState = @"";
            _manage.jobYear = 0;
            _manage.companyTotalWorkingTerms = @"";
            _manage.image3dcheck = @"";
            _manage.promno = @"";
            _manage. purpose = @"";
            _manage. mtdcde = @"";
            _manage.typfreqcde = @"";
            _manage.regprovince = @"";
            _manage.regcity = @"";
            _manage. regarea = @"";
            _manage.regaddr = @"";
            _manage.proftyp = @"";
            _manage.indivempprovince = @"";
            _manage.indivempcity = @"";
            _manage.indivemparea = @"";
            _manage.indivempaddr = @"";
            _manage.indivemptyp = @"";
            _manage.indivindtrytyp = @"";
            _manage.loanMoneyAmount= 0.0;
            _manage.loanTermCount = 12;
        }
    });
    
    return _manage;
}

+ (instancetype)share{
    
    return  [[self alloc] init];
}



@end
