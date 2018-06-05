//
//  DCBankController.m
//  YHX_Loan
//  储蓄卡验证添加
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "DCBankController.h"
#import "BankManageController.h"
@interface DCBankController ()
@property (weak, nonatomic) IBOutlet UILabel *banKName;
@property (weak, nonatomic) IBOutlet UILabel *bankType;
@property (weak, nonatomic) IBOutlet UILabel *bankNumber;
@property (weak, nonatomic) IBOutlet UITextField *bankMoblieField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation DCBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 更改导航返回键返回事件
    [self setBackButtonTarget:self action:@selector(clickbackButton)];
    
    self.title = @"储蓄卡绑定";
    self.banKName.text = self.bank.bankName;
    self.bankType.text = @"储蓄卡";
    self.bankNumber.text = self.bank.bankCardNumber;
     _submitBtn.enabled = false;
    [self.bankMoblieField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
 
}
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (_bankMoblieField.text.length != 11 ) {
        _submitBtn.enabled = false;
    }else{
        _submitBtn.enabled = true;
    }
    
    if(_bankMoblieField.text.length >= 11){
        _bankMoblieField.text = [textField.text substringToIndex:11];
    }
}


- (IBAction)submitClick:(id)sender {

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    paramesAddDictionary(parames);
    UserModel *user = [DataManage share].userModel;
    
    [parames setObject:user.loginName forKey:@"mobile"];
    [parames setObject:@0 forKey:@"operateType"];
    [parames setObject:user.realName forKey:@"realName"];
    [parames setObject:user.idCardNumber forKey:@"idCardNumber"];
    [parames setObject:self.bank.bankName forKey:@"bankName"];
    [parames setObject:self.bank.bankCardNumber forKey:@"bankCardNumber"];
    [parames setObject:_bankMoblieField.text forKey:@"bankCardPLMobile"];
    [parames setObject:@"DC" forKey:@"cardType"];

    NSLog(@"绑定银行卡请求数据-->%@",[STools dictJsonString: parames]);
    
    [EasyShowLodingView showLodingText:@"请稍等..."];
    [session POST:url_bindBankCard parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"绑定银行卡 success--%@",[STools dictJsonString: responseObject]);
              // 关闭HUD
              [EasyShowLodingView hidenLoding];
              if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                  // 显示登录成功toast
                  NSDictionary *result = [responseObject objectForKey:@"result"];
                  // 保存用户信息（ 静态数据保存 ）
                  [DataManage share].userModel = [UserModel userWithDic:result];
                  [self showAlert:@"绑定成功请点击返回！" close:YES];
                  [parames description];
              }else{
                  [self showAlert:@"绑定验证失败,请检查所填信息是否正确！" close:NO];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [EasyShowTextView showText:@"请求失败!"];
              NSLog(@"failure--%@",error);
          }];

    
    
    
}

// 取消返回管理界面
- (void)clickbackButton{
    [self popToViewControllerOfClass:[BankManageController class] animated:YES];
}

- (void)showAlert:(NSString*)message close:(Boolean)isClose{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"信息提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@">>> Click the yes button.");
        if(isClose){
        [self clickbackButton];
        }
    }];

    [alertController addAction:yesAction];
  
    
    //show alert controller
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
