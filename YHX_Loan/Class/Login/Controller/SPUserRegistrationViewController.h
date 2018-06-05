//
//  SPUserRegistrationViewController.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>
#define   TYPE_getCode      1
#define   TYPE_register     2
#define   TYPE_forgetPwd    3

@interface SPUserRegistrationViewController : SNBaseViewController

/** 界面操作类型  注册(register) 或者 忘记密码 (forgotPassword)*/
@property(nonatomic, strong) NSString *operationType;

@end
