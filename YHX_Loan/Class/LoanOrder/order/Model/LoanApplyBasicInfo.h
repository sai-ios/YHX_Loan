//
//  LoanApplyBasicInfo.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanApplyBasicInfo : NSObject

@property(nonatomic, strong)  NSString *docID;
@property(nonatomic, strong)  NSString *productType;                 // 产品类型
@property(nonatomic, strong)  NSString *productTypeName;             // 产品类型名称
@property(nonatomic, strong)  NSString *productSubType;              // 产品名称
@property(nonatomic, strong)  NSString *productSubTypeName;          // 产品名称名称
@property(nonatomic, strong)  NSString *customerCode;                // 客户编号
@property(nonatomic, strong)  NSString *customerName;                // 客户名称   (name)
@property(nonatomic, strong)  NSString *customerMobile;              // 手机号码      (mobile)
@property(nonatomic, strong)  NSString *customerMR;                  // 维护人
@property(nonatomic, strong)  NSString *customerMRName;              // 维护人名称
@property(nonatomic, strong)  NSString *trackingPersonInfo;          // 客户经理
@property(nonatomic, strong)  NSString *trackingPersonInfoName;      // 客户经理名称
@property(nonatomic, strong)  NSString *trackingPersonInfoWorkNo;    // 客户经理工号
@property(nonatomic, strong)  NSString *customerCardType;            // 证件类型
@property(nonatomic, strong)  NSString *customerCardTypeName;        // 证件类型名称
@property(nonatomic, strong)  NSString *customerCardNo;              // 证件号码  (idCardNumber)
@property(nonatomic, strong)  NSString *companyName;                 // 公司名称(companyName)
@property(nonatomic, strong)  NSString *hireType;                    // 雇佣类型
@property(nonatomic, strong)  NSString *hireTypeName;                // 雇佣类型名称
@property(nonatomic, strong)  NSString *loanRegDate;                 // 签约时间
@property(nonatomic, assign)  NSString *loanMoneyAmount;              // 批复金额
@property(nonatomic, assign)  NSNumber *loanTermCount;                // 批复期数
@property(nonatomic, strong)  NSString *loanRegPurpose;              // 借款信息贷款目的   (loanPurpose)
@property(nonatomic, strong)  NSString *loanRegPurposeName;          // 贷款用途名称
@property(nonatomic, strong)  NSString *preBusinessStage;            // 上一业务所处阶段
@property(nonatomic, strong)  NSString *currBusinessStage;           // 当前业务流程所处阶段
@property(nonatomic, strong)  NSString *currBusinessStageStatus;     // 当前业务流程所处阶段状态
@property(nonatomic, strong)  NSString *currBusinessStageDate;       // 当前业务流程
@property(nonatomic, strong)  NSString *finishedStatus;              // 最终状态
@property(nonatomic, strong)  NSString *remark;                      // 备注
@property(nonatomic, strong)  NSString *auditOpCommentType;          // 审计类型
@property(nonatomic, strong)  NSString *auditOpCommentTypeComment;   // 审计类型注释
@property(nonatomic, strong)  NSString *auditOpStartDate;            // 审核启动日期
@property(nonatomic, assign)  NSNumber *auditOpBeAffectedDays;        // 处理周期
@property(nonatomic, strong)  NSString *submitedDate;                // 提交时间  (new Date())
@property(nonatomic, strong)  NSString *loanBankCardOfOpenBank;      // 开户行
@property(nonatomic, strong)  NSString *loanBankCardOfCity;          // 开户市/县
@property(nonatomic, strong)  NSString *loanBankName;                // 开户行支行全称   (bankName)
@property(nonatomic, strong)  NSString *loanBankCardNO;              // 银行账号  (bankCardNumber)
@property(nonatomic, strong)  NSString *returnMoneyMethod;           // 还款方式
@property(nonatomic, strong)  NSString *returnMoneyMethodName;       // 还款方式名称
@property(nonatomic, strong)  NSString *createdOn;                   // 创建日期
@property(nonatomic, strong)  NSString *createdBy;                   // 创建人
@property(nonatomic, strong)  NSString *modifiedOn;                  // 修改日期  (new Date())
@property(nonatomic, strong)  NSString *originalLoanRegDate;         // 申请时间
@property(nonatomic, assign)  NSString *originalLoanMoneyAmount;      // 申请金额   (loanMoneyAmount)
@property(nonatomic, assign)  NSNumber *originalLoanTermCount;        // 申请期数  (loanTermsCount)
@property(nonatomic, strong)  NSString *businessType;                // 业务类型
@property(nonatomic, strong)  NSString *businessTypeName;            // 业务类型名称
@property(nonatomic, assign)  NSString *customerVerifyScore;          // 评分值
@property(nonatomic, strong)  NSString *applyStatus;                 // 申请状况   (applyStatus)
@property(nonatomic, strong)  NSString *reAduditStaff;               // 申请人
@property(nonatomic, strong)  NSString *loanRate;                    // 贷款利息
@property(nonatomic, strong)  NSString *loanManagementFee;           // 贷款管理费
@property(nonatomic, strong)  NSString *loanArrangementFee;          // 贷款手续费
@property(nonatomic, strong)  NSString *email;                       // 邮箱
@property(nonatomic, strong)  NSString *applyNo;                     // 签约编号
@property(nonatomic, strong)  NSString *sex;                         // 性别
@property(nonatomic, strong)  NSString *flowStatus;                  // 兴业流程状态
@property(nonatomic, strong)  NSString *statusdesc;                  // 兴业流程状态描述
@property(nonatomic, strong)  NSString *transSeq;                    // 兴业流水号
@property(nonatomic, strong)  NSString *channel;                     // 渠道
@property(nonatomic, strong)  NSString *busCode;                     // 兴业进件单号

+(instancetype)loanRepayWithDic:(NSDictionary *)dic;
+(NSMutableArray *)loanListWithDic:(NSArray *)array;
@end
