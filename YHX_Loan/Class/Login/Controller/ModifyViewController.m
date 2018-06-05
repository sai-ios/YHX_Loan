//
//  ModifyViewController.m
//  YHX_Loan
//  修改密码
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "ModifyViewController.h"
#import "SPLoginViewController.h"
@interface ModifyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@property (weak, nonatomic) IBOutlet UITextField *pwdNew1;
@property (weak, nonatomic) IBOutlet UITextField *pwdNew2;
@end

@implementation ModifyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = pcBackgroundColor;
    self.title = @"修改密码";
    [self initViewData];
}

- (void) initViewData {
    [self.oldPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdNew1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdNew2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.pwdNew1.secureTextEntry = YES;
    self.pwdNew2.secureTextEntry = YES;
    self.oldPwd.secureTextEntry = YES;
    
    _changeBtn.enabled = false;
}

/**
 *  监听textField 变化，限制长度输入 ，非空、不满足条件时限制button键使用
 */
- (void)textFieldDidChange:(UITextField *)textField{
    
    if(textField == _oldPwd){
        if(_oldPwd.text.length > 16){
            _oldPwd.text = [textField.text substringToIndex:16];
        }
    }
    
    if(textField == _pwdNew1){
        if(_pwdNew1.text.length > 16){
            _pwdNew1.text = [textField.text substringToIndex:16];
        }
    }
    
    if(textField == _pwdNew2){
        if(_pwdNew1.text.length > 16){
            _pwdNew1.text = [textField.text substringToIndex:16];
        }
    }
    
    if( _pwdNew1.text.length <6 || _pwdNew2.text.length <6 ){
        _changeBtn.enabled = false;
    }else{
        _changeBtn.enabled = true;
    }
    
}

- (IBAction)btnOnClick:(id)sender {
    if(![_pwdNew1.text isEqualToString:_pwdNew2.text]){
        [EasyShowTextView showText:@"两次输入的密码不一致!"];
        return;
    }
    //修改密码
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    paramesAddDictionary(parames);
    [parames setObject:[_oldPwd.text trim] forKey:@"userPwd"];
    [parames setObject:[_pwdNew1.text trim] forKey:@"newPwd"];
    
    NSLog(@"请求数据-->%@",[STools dictJsonString: parames]);
    
    [EasyShowLodingView showLodingText:@"请稍等..."];
    [session POST:url_updatePwd parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[STools dictJsonString: responseObject]);
              // 关闭HUD
              [EasyShowLodingView hidenLoding];
              if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                  // 显示登录成功toast
                  [EasyShowTextView showSuccessText:@"修改成功!"];
                  // 清除用户信息
                  [DataManage share].userModel = nil;
                  [parames description];
                  // 关闭页面 重新登录
                  SPLoginViewController *loginVc = [[SPLoginViewController alloc]init];
                  [self.navigationController pushViewController:loginVc animated:YES];
                  
              }else{
                  [EasyShowTextView showErrorText:@"修改失败!"];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [EasyShowTextView showText:@"请求失败!"];
              NSLog(@"failure--%@",error);
          }];
    
}


@end
