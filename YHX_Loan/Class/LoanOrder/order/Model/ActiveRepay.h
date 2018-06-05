//
//  ActiveRepay.h
//  YHX_Loan
//  主动还款接口 数据
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActiveRepay : NSObject
//平台渠道进件编号NM归还欠款，  FS全部还款， TQ溢缴款还款
@property(nonatomic, strong)  NSString *chnseq;
 //还款模式 01 指定金额还款，02全部还款， mtdmodel='FS'时使用02，，其余还款模式下默认01，还款模式为归还欠款时，还款类型必填
@property(nonatomic, strong)  NSString *mtdmodel;
//还款类型，mtdmodel='NM’或'FS',mtdtyp='02'此字段非必填否则必填;
@property(nonatomic, strong)  NSString *mtdtyp;
@property(nonatomic, assign)  double mtdamt;      //还款总额
@property(nonatomic, strong)  NSString *remark;   //备注
@property(nonatomic, assign)  double thirdLiqAmt; //违约金

+(instancetype)activeRepayWithDic:(NSDictionary *)dic;
@end
