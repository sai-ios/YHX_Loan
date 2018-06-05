//
//  SPLoginViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//
#import "SPLoginViewController.h"
#import "SPToolBox.h"
#import "SPUserRegistrationViewController.h"
#import <EasyShowView.h>
#import "MeTableViewController.h"
#import "UserModel.h"
#import "STools.h"
#define BranchCode @"0170205395"
@interface SPLoginViewController ()<UITextFieldDelegate>
//账号
@property (weak, nonatomic) IBOutlet UITextField *loginNameField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
//登录
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
//视图
@property (weak, nonatomic) IBOutlet UIView *idNumberView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
/** 账号 */
@property(nonatomic, strong)NSString *userName;
/** 密码 */
@property(nonatomic, strong) NSString *userPwd;

@end

@implementation SPLoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //登录按钮
    _loginBtn.enabled = false;
    self.idNumberView.layer.borderColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.0f].CGColor;
    self.idNumberView.layer.borderWidth = 1;
    self.pwdView.layer.borderColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.0f].CGColor;
    self.pwdView.layer.borderWidth = 1;
    
    NSString *loginName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    NSString *loginPwd =  [[NSUserDefaults standardUserDefaults] objectForKey:USER_PWDS];
    
    if(loginName!=nil)
        self.loginNameField.text = loginName;
    if(loginPwd!=nil){
        self.pwdField.text = loginPwd;
        _loginBtn.enabled = true;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航条设置
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = @"登录";
    self.loginNameField.delegate = self;
    self.pwdField.delegate = self;
    self.pwdField.secureTextEntry = YES;
    [self.loginNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.view.backgroundColor = pcBackgroundColor;
    
}

/**
 *  监听textField 变化，限制长度输入 ，非空、不满足条件时限制button键使用
 */
- (void)textFieldDidChange:(UITextField *)textField{
  
    if (_loginNameField.text.length != 11 || _pwdField.text.length < 6) {
        _loginBtn.enabled = false;
    }else{
        _loginBtn.enabled = true;
    }
    
    if(textField == _loginNameField){
        if(_loginNameField.text.length >= 11){
            _loginNameField.text = [textField.text substringToIndex:11];
        }
    }
    if(textField == _pwdField){
        if(_pwdField.text.length > 16){
           _pwdField.text = [textField.text substringToIndex:16];
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
        return [textField resignFirstResponder];
}

- (IBAction)loginBtnClick:(id)sender {
    _userName = [_loginNameField.text trim];
    _userPwd = [_pwdField.text trim];
    //手机号是否正确
    if (![STools compile:_userName pattern:PATTERN_Phone] ) {
       [EasyShowTextView showText:@"手机号可能不正确!"];
    }else{
        _loginBtn.userInteractionEnabled = false;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        session.requestSerializer=[AFJSONRequestSerializer serializer];
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        paramesAddDictionary(parames);
        [parames setObject:[_loginNameField.text trim] forKey:@"loginName"];
        [parames setObject:[_pwdField.text trim] forKey:@"userPwd"];
        
        NSLog(@"请求数据-->%@",[STools dictJsonString: parames]);
        
        [EasyShowLodingView showLodingText:@"登录中..."];
        
        [session POST:url_login parameters:parames progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   NSLog(@"success--%@",[STools dictJsonString: responseObject]);
                   // 关闭HUD
                  [EasyShowLodingView hidenLoding];
                 _loginBtn.userInteractionEnabled = true;
                  if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                      // 显示登录成功toast
                      [EasyShowTextView showSuccessText:@"登录成功!"];
                      NSDictionary *result = [responseObject objectForKey:@"result"];
                      // 保存用户信息（ 静态数据保存 ）
                      [DataManage share].userModel = [UserModel userWithDic:result];
//                      UserModel  *userModel = [UserModel userWithDic:result];
                      NSLog(@"user work data ====>%@",[DataManage share].userModel.workInfo.companyName);
                      [parames description];
                      NSLog(@"user-静态数据保存->%@",[[DataManage share].userModel yy_modelToJSONString]);
                      // 关闭页面
//                      for (UIViewController *temp in self.navigationController.viewControllers) {
//                          if ([temp isKindOfClass:[MeTableViewController class]]) {
//                              [self.navigationController popToViewController:temp animated:YES];
//                              theVc = true;
//                          }
//                      }
                      [self.navigationController popViewControllerAnimated:YES];

                  }else{
                       [EasyShowTextView showErrorText:@"登录失败!"];
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  [EasyShowLodingView hidenLoding];
                  [EasyShowTextView showText:@"请求失败!"];
                  _loginBtn.userInteractionEnabled = true;
                  NSLog(@"failure--%@",error);
        }];

        [self saveUserLoginData];
    }
}

- (void) saveUserLoginData{
    [[NSUserDefaults standardUserDefaults]setObject:[_loginNameField.text trim] forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:[_pwdField.text trim] forKey:USER_PWDS];
    [[NSUserDefaults standardUserDefaults]synchronize];//同步、保存
}

//注册(register) 或者 忘记密码 (forgotPassword)
- (IBAction)userRegistrationClick:(id)sender {
    SPUserRegistrationViewController *user = [[SPUserRegistrationViewController alloc] init];
    user.operationType = @"register";
    [self.navigationController pushViewController:user animated:YES];
}

- (IBAction)forgetPasswordClick:(id)sender {
    SPUserRegistrationViewController *pwd = [[SPUserRegistrationViewController alloc] init];
    pwd.operationType = @"forgotPassword";
    [self.navigationController pushViewController:pwd animated:YES];
}
@end
