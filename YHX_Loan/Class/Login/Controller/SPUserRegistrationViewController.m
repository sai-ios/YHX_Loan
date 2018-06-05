//
//  SPUserRegistrationViewController.m
//  YHX_Loan
//  注册、忘记密码界面
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "SPUserRegistrationViewController.h"
#import "STools.h"
#import "NSWebViewController.h"
@interface SPUserRegistrationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *registerPhoneField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *authenicCodeField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField1;
@property (weak, nonatomic) IBOutlet UITextField *pwdField2;
@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (assign, nonatomic) Boolean check;
//验证码
@property(nonatomic, strong) NSString *msgAuthCode;
@end

@implementation SPUserRegistrationViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([self.operationType isEqualToString:@"register"]){
        [_registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        self.title = @"新用户注册";
    }else if([self.operationType isEqualToString:@"forgotPassword"]){
        [_registerBtn setTitle: @"重置密码" forState:UIControlStateNormal];
        self.title = @"忘记密码";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = pcBackgroundColor;
    [self initViewData];
    _msgAuthCode = @"";
}

- (void) initViewData {
    [self.registerPhoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdField1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.authenicCodeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _registerBtn.enabled = false;
    _sendCodeBtn.userInteractionEnabled = false;
    [self.sendCodeBtn setTitleColor:XZRGB(0xFF979797) forState:UIControlStateNormal];
    
    self.pwdField1.secureTextEntry = YES;
    self.pwdField2.secureTextEntry = YES;
    _check = false;
}

/**
 *  监听textField 变化，限制长度输入 ，非空、不满足条件时限制button键使用
 */
- (void)textFieldDidChange:(UITextField *)textField{
 
    if(textField == _registerPhoneField){
        //手机判断
        if (_registerPhoneField.text.length != 11 ) {
            _sendCodeBtn.userInteractionEnabled = false;
            [self.sendCodeBtn setTitleColor:XZRGB(0xFF979797) forState:UIControlStateNormal];
        }else {
            [self.sendCodeBtn setTitleColor:XZRGB(0xFFFB8557) forState:UIControlStateNormal];
            self.sendCodeBtn.userInteractionEnabled = YES;
        }
        
        if(textField.text.length > 11){
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if(textField == _pwdField1){
        if(_pwdField1.text.length > 16){
            _pwdField1.text = [textField.text substringToIndex:16];
        }
    }
    
    if(textField == _pwdField2){
        if(_pwdField2.text.length > 16){
            _pwdField2.text = [textField.text substringToIndex:16];
        }
    }
    
    if(textField == _authenicCodeField){
        if(_authenicCodeField.text.length > 6){
            _authenicCodeField.text = [textField.text substringToIndex:6];
        }
    }
    
    if(_registerPhoneField.text.length != 11 || _pwdField1.text.length <6 || _pwdField2.text.length <6 || _authenicCodeField.text.length<3){
        _registerBtn.enabled = false;
    }else{
       _registerBtn.enabled = true;
    }
    
}

- (IBAction)checkLister:(id)sender {
    if(!_check){
        _check = true;
        [_checkBtn setImage:[UIImage imageNamed:@"loan_icon_deal_select.png"] forState:UIControlStateNormal];
    }else{
       _check = false;
        [_checkBtn setImage:[UIImage imageNamed:@"loan_icon_deal_normal.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnOnClick:(id)sender {
    //用户协议
    if(sender == _agreementBtn){
        NSWebViewController *web = [[NSWebViewController alloc]init];
        web.url = @"yonghuxieyi.html";
        [self.navigationController pushViewController:web animated:YES];
    
    }else if(sender == _sendCodeBtn){//发送短信验证码，开启倒计时效果
       
        if (![STools compile:_registerPhoneField.text pattern:PATTERN_Phone] ) {
                [EasyShowTextView showText:@"手机号可能不正确!"];
            }else{
                NSMutableDictionary *parames = [NSMutableDictionary dictionary];
                [parames setObject:_registerPhoneField.text forKey:@"mobile"];
                paramesAddDictionary(parames);
                [self AFHTTPManager:url_getSmsCode questType:TYPE_getCode parameters:parames];
        }
       
    }else if(![_pwdField2.text isEqualToString:_pwdField1.text]){
         [EasyShowTextView showText:@"两次输入的密码不一致!"];
       
    }
    
 
    
    //注册按键
   else if(sender == _registerBtn){
        
        if(!_check){
            [EasyShowTextView showText:@"请同意用户协议!"];
            return;
        }
        //注册时
        if([self.operationType isEqualToString:@"register"]){
            NSMutableDictionary *parames = [NSMutableDictionary dictionary];
            [parames setObject:_registerPhoneField.text forKey:@"loginName"];
            [parames setObject:_pwdField2.text forKey:@"userPwd"];
            [parames setObject:_authenicCodeField.text forKey:@"smsCode"];
            [parames setObject:_registerPhoneField.text forKey:@"smsKey"];
            paramesAddDictionary(parames);
            [self AFHTTPManager:url_register questType:TYPE_register parameters:parames];
        }
        //忘记密码时
        if([self.operationType isEqualToString:@"forgotPassword"]){
            NSMutableDictionary *parames = [NSMutableDictionary dictionary];
            [parames setObject:_registerPhoneField.text forKey:@"loginName"];
            [parames setObject:_pwdField2.text forKey:@"newPwd"];
            [parames setObject:_authenicCodeField.text forKey:@"smsCode"];
            [parames setObject:_registerPhoneField.text forKey:@"smsKey"];
            paramesAddDictionary(parames);
            [self AFHTTPManager:url_forgetPwd questType:TYPE_forgetPwd parameters:parames];
        }
    }
}

#pragma mark 网络请求服务协议
- (void)AFHTTPManager:(NSString *)url questType:(int)type parameters:(id)parames{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSLog(@"%@",[parames yy_modelToJSONString]);
    [EasyShowLodingView showLodingText:@"请稍等..."];
    [session POST:url parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[responseObject yy_modelToJSONString]);
              // 关闭HUD
              [EasyShowLodingView hidenLoding];
              
              if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                  if(type == TYPE_getCode){
                      [EasyShowTextView showSuccessText:@"发送成功!"];
                      [self openCountdown];
                  }else if(type == TYPE_register){
                      [EasyShowTextView showSuccessText:@"注册成功!"];
                      [[NSUserDefaults standardUserDefaults]setObject:_registerPhoneField.text forKey:USER_NAME];
                      [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_PWDS];
                      [[NSUserDefaults standardUserDefaults]synchronize];//同步、保存
                      // 关闭页面
                      [self.navigationController popViewControllerAnimated:YES];
                      
                  }else if(type == TYPE_forgetPwd){
                      [EasyShowTextView showSuccessText:@"密码重置成功!"];
                      [[NSUserDefaults standardUserDefaults]setObject:_registerPhoneField.text forKey:USER_NAME];
                      [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_PWDS];
                      [[NSUserDefaults standardUserDefaults]synchronize];//同步、保存
                      // 关闭页面
                      [self.navigationController popViewControllerAnimated:YES];
                  }
              }else if([[responseObject objectForKey:@"respCode"] isEqualToString:@"01"]){
                  [EasyShowTextView showErrorText:@"用户也存在!"];
              }else{
                  [EasyShowTextView showErrorText:@"操作失败!"];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [EasyShowTextView showText:@"请求失败!"];
              NSLog(@"failure--%@",error);
          }];

}



#pragma mark 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.sendCodeBtn setTitleColor:XZRGB(0xFFFB8557) forState:UIControlStateNormal];
                self.sendCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"剩余%.2d秒", seconds] forState:UIControlStateNormal];
                [self.sendCodeBtn setTitleColor:XZRGB(0xFF979797) forState:UIControlStateNormal];
                self.sendCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


@end
