//
//  LoanApplyModel.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Relation;
@interface LoanApplyModel : NSObject

@property(nonatomic, strong) NSString *locationAddress;//当前位置
@property(nonatomic, strong) NSString *sysType;         // String(50) 是  系统类型
@property(nonatomic, strong) NSString *deviceId;        //   String(50) 是  设备序号
@property(nonatomic, strong) NSString *appVer;          // String(50) 是  app版本
@property(nonatomic, strong) NSString *sysVer;          // String(50) 是  系统版本
@property(nonatomic, strong) NSString *loginName;       //  String(50) 是  登陆名

@property(nonatomic, strong) NSString *realName;        //   String(50) 是  姓名
@property(nonatomic, strong) NSString *sex;             //   String 是  性别 1男0女
@property(nonatomic, strong) NSString *idCardNumber;    //  String(50) 是  身份证号

@property(nonatomic, strong) NSString *birthday;        //   Datetime   否  出生日期（yyyyMMdd格式，如：19830812）
@property(nonatomic, strong) NSString *mobile;          // String(50) 是  手机号码
@property(nonatomic, strong) NSString *homeTel;         //   String(50) 是  住宅电话
@property(nonatomic, strong) NSString *email;           // String(50) 是  电子邮箱
@property(nonatomic, strong) NSString *maritalStatus;   // String(5)  是  婚姻状态
@property(nonatomic, assign) NSInteger supportCount;          //  Int    是  供养人数
@property(nonatomic, strong) NSString *nowLivingAddress;//  String(200)    是  常住地址
@property(nonatomic, strong) NSString *enducationDegree;//   String(10)     是  教育程度
@property(nonatomic, strong) NSString *companyName;     //   String(200)    是  工作单位
@property(nonatomic, strong) NSString *companyType;     //   String(50) 是  单位性质
@property(nonatomic, strong) NSString *workState;       //工作状态
@property(nonatomic, strong) NSString *companyAddress;  // String(200)    是  单位地址
@property(nonatomic, strong) NSString *companyTel;    // String(50)     是  单位电话

@property(nonatomic, strong) NSString *companyDept;   //   String(200)    是  任职部门
@property(nonatomic, strong) NSString *companyDuty;   //   String(50)     是  职位

@property(nonatomic, assign) double   companySalaryOfMonth;             //  Decimal(18,2)  是  个人月收入
@property(nonatomic, strong) NSString *productID;                       // String(50) 是  产品编号
@property(nonatomic, strong) NSString *idCardNumberEffectPeriodOfStart; //   String(50) 是  身份证有效期（开始）
@property(nonatomic, strong) NSString *idCardNumberEffectPeriodOfEnd;   //  String(50) 是  身份证有效期（结束）
@property(nonatomic, strong) NSString *residenceAddress;                //   String(50) 是  户籍地址

@property(nonatomic, strong) NSString *bankName;                        //  String(50) 是  开户行支行
@property(nonatomic, strong) NSString *bankCardNumber;                  // String(50) 是  银行卡账号
@property(nonatomic, strong) NSString *bankCardPLMobile;                //  String(50) 是  银行预留手机号
@property(nonatomic, strong) NSString *nowLivingState;                  // String(50) 是  现居住房性质

@property(nonatomic, assign) NSInteger jobYear;                               //  Int    是  工作年限
@property(nonatomic, strong) NSString *companyTotalWorkingTerms;        //   String(50) 是  总工作年限
@property(nonatomic, strong) NSString *image3dcheck;                    //  String(MAX)    是  活体识别数据包BASE65

/**新增字段*/
@property(nonatomic, strong) NSString *promno;                      // 进件代码
@property(nonatomic, strong) NSString *purpose;                     // 贷款用途
@property(nonatomic, strong) NSString *mtdcde;                      // 还款方式
@property(nonatomic, strong) NSString *typfreqcde;                  // 还款间隔
@property(nonatomic, strong) NSString *regprovince;                 // 户籍地址（省）
@property(nonatomic, strong) NSString *regcity;                     // 户籍地址（市）
@property(nonatomic, strong) NSString *regarea;                     // 户籍地址（区）
@property(nonatomic, strong) NSString *regaddr;                     // 籍地址（详细地址
@property(nonatomic, strong) NSString *proftyp;                     // 职业类型
@property(nonatomic, strong) NSString *indivempprovince;            // 现单位地址（省）
@property(nonatomic, strong) NSString *indivempcity;                // 现单位地址（市）
@property(nonatomic, strong) NSString *indivemparea;                // 现单位地址（区）
@property(nonatomic, strong) NSString *indivempaddr;                // 现单位地址（详细信息）
@property(nonatomic, strong) NSString *indivemptyp;                 //现单位性质
@property(nonatomic, strong) NSString *indivindtrytyp;              //现单位行业性质

@property(nonatomic, assign) double    loanMoneyAmount;                // 借款金额
@property(nonatomic, assign) NSInteger loanTermCount;                     // 借款期数
@property(nonatomic, strong) NSArray<Relation *> *relationInfos;//List   是  联系人列表


+ (instancetype)share;

@end
