//
//  AppConfig.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/17.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h
#import <Foundation/Foundation.h>

// 域名
#if DEBUG
static NSString *const NET_HOME = @"http://218.66.56.2:19082";
#else
static NSString *const NET_HOME = @"http://192.168.211.2:9080";
#endif

#define HOME_APP_URL [NET_HOME stringByAppendingString:@"/vtmp/App/Api"]
#define HOME_SIGN_URL [NET_HOME stringByAppendingString:@"/vtmp/Sign/Api"]
#define HOME_BR_URL [NET_HOME stringByAppendingString:@"/vtmp/BR/Api"]

// 登录
#define url_login [HOME_APP_URL stringByAppendingString:@"/Login"]
// 注册
#define url_register [HOME_APP_URL stringByAppendingString:@"/Register"]
// 获取短信验证码
#define url_getSmsCode [HOME_APP_URL stringByAppendingString:@"/GetRegSmsCode"]
// 忘记密码
#define url_forgetPwd [HOME_APP_URL stringByAppendingString:@"/ForgetPwd"]
// 修改密码
#define url_updatePwd [HOME_APP_URL stringByAppendingString:@"/UpdatePwd"]
// 实名头像上传
#define url_uploadFile [HOME_APP_URL stringByAppendingString:@"/UploadFile"]
// 实名认证 --  人脸识别
#define url_RealName [HOME_APP_URL stringByAppendingString:@"/FaceValidate"]
// 基础信息提交
#define url_EssentialInfo [HOME_APP_URL stringByAppendingString:@"/SaveBasicInfo"]
// 工作信息提交
#define url_WorkInfo [HOME_APP_URL stringByAppendingString:@"/SaveWorkInfo"]
// 紧急联系人 同步手机通讯录
#define url_syncContact [HOME_APP_URL stringByAppendingString:@"/syncContact"]
// 银行卡绑定
#define url_bindBankCard [HOME_APP_URL stringByAppendingString:@"/LoanBankValidate"]
// 小额贷申请
#define url_applyLoan [HOME_APP_URL stringByAppendingString:@"/LoanApplication"]
// 贷款记录列表
#define url_getLoanList [HOME_APP_URL stringByAppendingString:@"/GetLoanInfoList"]
// 小额贷状态数据查询
#define url_GetApplyInfo [HOME_APP_URL stringByAppendingString:@"/GetApplyInfo"]
// 贷款设备防欺诈
#define url_LoanAntiFraud [HOME_APP_URL stringByAppendingString:@"/LoanAntiFraud"]
// 兴业银行卡还款账户变更
#define url_repayAccChange [HOME_APP_URL stringByAppendingString:@"/repayAccChange"]
// 兴业银行主动还款试算
#define url_activeRepaymentTry [HOME_APP_URL stringByAppendingString:@"/activeRepaymentTry"]
// 兴业银行主动还款
#define url_activeRepay [HOME_APP_URL stringByAppendingString:@"/activeRepay"]
// 兴业银行主动还款状态查询
#define url_activeRepaStatus [HOME_APP_URL stringByAppendingString:@"/activeRepaStatus"]
// 兴业银行欠款查询
#define url_queryArrears [HOME_APP_URL stringByAppendingString:@"/queryArrears"]
// 兴业银行查选还款记录
#define url_queryRepayList [HOME_APP_URL stringByAppendingString:@"/queryRepayList"]
// 更新下载地址
///////////////////////////////////////////////////////////

#endif /* AppConfig_h */
