//
//  UserModel.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserBasicInfo,WorkInfo,BankCard,Relation;
@interface UserModel : NSObject
@property(nonatomic, strong) NSString *loginName;           // 用户名
@property(nonatomic, strong) NSString *realName ;           // 真实姓名
@property(nonatomic, strong) NSString *idCardNumber ;       // 身份证
@property(nonatomic, strong) NSString *phoneNo;             // loginName;//手机
@property(nonatomic, assign) Boolean  realNameState ;       // 实名认证标记
@property(nonatomic, assign) NSInteger bankBindState;        // 银行卡认证标记
@property(nonatomic, assign) Boolean  basicInfoState;       // 基础信息标记
@property(nonatomic, assign) Boolean  workState ;           // 工作信息标记
@property(nonatomic, assign) Boolean  contactsState ;       // 联系人标记

@property(nonatomic, strong) NSString *frontPicPath;        // 身份证正面路径
@property(nonatomic, strong) NSString *backPicPath;         // 身份证背面路径

@property(nonatomic, strong) NSString *sex;                 // 性别
@property(nonatomic, strong) NSString *birthday;            // 出生年月
@property(nonatomic, strong) NSString *ethnic;              // 民族
@property(nonatomic, strong) NSString *signdate;            // 身份证有效期开始
@property(nonatomic, strong) NSString *expirydate;          // 身份证有效期结束
@property(nonatomic, strong) NSString *residenceAddress;    // 户籍地址

@property(nonatomic, strong) NSString *regprovince;         //  户籍地址（省）
@property(nonatomic, strong) NSString *regcity;             // 户籍地址（市）
@property(nonatomic, strong) NSString *regarea;             // 户籍地址（区）
@property(nonatomic, strong) NSString *regaddr;             // 籍地址（详细地址

@property(nonatomic, strong) WorkInfo      *workInfo;       // 用户工作信息
@property(nonatomic, strong) UserBasicInfo *userBasicInfo;  // 用户基础信息

@property(nonatomic, strong) NSMutableArray<BankCard *> *bankCardArray; // 银行卡集合
@property(nonatomic, strong) NSMutableArray<Relation *> *relationArray; // 紧急联系人

+(instancetype)userWithDic:(NSDictionary *)dic;
//+ (instancetype)share;
@end

@interface UserBasicInfo : NSObject
@property(nonatomic, strong) NSString *email;               // 电子邮箱
@property(nonatomic, strong) NSString *maritalStatus;       // 婚姻状态 //婚姻状况    indivmtrital
@property(nonatomic, assign) NSInteger supportCount;        // 供养人数
@property(nonatomic, strong) NSString *enducationDegree;    // 教育程度、//教育程度    indivedu
@property(nonatomic, strong) NSString *nowlivingProvince;   // 现居住地址省份
@property(nonatomic, strong) NSString *nowlivingCity    ;   // 现居住地址市
@property(nonatomic, strong) NSString *nowlivingArea    ;   // 现居住地址区
@property(nonatomic, strong) NSString *nowlivingAddress;    // 现居住地址详细
@property(nonatomic, strong) NSString *nowLivingState;      // 现居住房性质
@end

@interface WorkInfo : NSObject
@property(nonatomic, strong) NSString *companyName;                 // 工作单位
@property(nonatomic, strong) NSString *companyType;                 // 单位性质
@property(nonatomic, assign) NSInteger jobYear;                     // 工作年限
@property(nonatomic, strong) NSString *workState;                   // 工作状态：离职、在职、兼职、其他
@property(nonatomic, strong) NSString *companyTel;                  // 单位电话
@property(nonatomic, strong) NSString *companyDept;                 // 任职部门
@property(nonatomic, strong) NSString *companyDuty;                 // 职位
@property(nonatomic, assign) double   companySalaryOfMonth;         // 个人月收入
@property(nonatomic, strong) NSString *companyTotalWorkingTerms;    // 总工作年限
@property(nonatomic, strong) NSString *companyAddress;              // 单位地址

@property(nonatomic, strong) NSString *proftyp;                    // 职业类型
@property(nonatomic, strong) NSString *indivempprovince;           // 现单位地址（省）
@property(nonatomic, strong) NSString *indivempcity;               // 现单位地址（市）
@property(nonatomic, strong) NSString *indivemparea;               // 现单位地址（区）
@property(nonatomic, strong) NSString *indivempaddr;               // 现单位地址（详细信息）
@property(nonatomic, strong) NSString *indivemptyp;                // 现单位性质
@property(nonatomic, strong) NSString *indivindtrytyp;             // 现单位行业性质
@end

@interface BankCard : NSObject
@property(nonatomic, strong) NSString *mobile;              // 手机号(登录名)
@property(nonatomic, strong) NSString *realName;            // 真实姓名
@property(nonatomic, strong) NSString *idCardNumber;        // 身份证号
@property(nonatomic, strong) NSString *bankName;            // 开户行
@property(nonatomic, strong) NSString *bankCardNumber;      // 银行卡号
@property(nonatomic, strong) NSString *bankCardPLMobile;    // 银行卡预留电话
@property(nonatomic, strong) NSString *cardType;            // 行卡类型"CC：贷记卡  DC：借记卡

+(instancetype)bankWithDic:(NSDictionary *)dic;
@end

@interface Relation : NSObject

@property(nonatomic, strong) NSString *rowNo;                       // 序号
@property(nonatomic, strong) NSString *relationCustomerName;        // 联系人姓名
@property(nonatomic, strong) NSString *relationCustomerMobile;      // 手机号码
@property(nonatomic, strong) NSString *relationName;                // 与借款人关系
@property(nonatomic, strong) NSString *relationCustomerIdCardNumber;// 身份正
@property(nonatomic, strong) NSString *relationCustomerTel;         // 住宅电话

@end
