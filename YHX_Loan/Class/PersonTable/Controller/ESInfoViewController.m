//
//  ESInfoViewController.m
//  YHX_Loan
//  基础信息
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//  @link{1}
//

#import "ESInfoViewController.h"
#import "ChooseLocationController.h"

@interface ESInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *eduBtn;
@property (weak, nonatomic) IBOutlet UIButton *maritalBtn;
@property (weak, nonatomic) IBOutlet UIButton *nowlivingAddressBtn;
@property (weak, nonatomic) IBOutlet UITextField *nowAddressField;
@property (weak, nonatomic) IBOutlet UIButton *livingStateBtn;
@property (weak, nonatomic) IBOutlet UITextField *supportCountField;
@property (weak, nonatomic) IBOutlet UIButton *subimtBtn;
// 教育dict
@property(nonatomic, strong) NSDictionary *enducationDict;
// 婚姻 dict
@property(nonatomic, strong) NSDictionary *martalDict;
// 住房性质 dict
@property(nonatomic, strong) NSDictionary *livingStateDict;

@end

@implementation ESInfoViewController

#pragma mark 懒加载数据字典
-(NSDictionary *)enducationDict{
    if (!_enducationDict) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"01"forKey:@"初中及以下"];
        [dict setObject:@"02"forKey:@"高中/中专"];
        [dict setObject:@"02"forKey:@"大专"];
        [dict setObject:@"03"forKey:@"本科"];
        [dict setObject:@"04"forKey:@"研究生及博士"];
        _enducationDict = dict;
    }
    return _enducationDict;
}

-(NSDictionary *)martalDict{
    if (!_martalDict) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:@"10"forKey:@"未婚"];
        [dict setObject:@"21"forKey:@"初婚"];
        [dict setObject:@"22"forKey:@"再婚"];
        [dict setObject:@"30"forKey:@"丧偶"];
        [dict setObject:@"40"forKey:@"离异"];
        [dict setObject:@"40"forKey:@"分居"];
        _martalDict = dict;
    }
     return _martalDict;
}

-(NSDictionary *)livingStateDict{
    if (!_livingStateDict) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"10"forKey:@"自有"];
        [dict setObject:@"30"forKey:@"租赁"];
        [dict setObject:@"30"forKey:@"宿舍"];
        _livingStateDict = dict;
    }
     return _livingStateDict;
}

#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基础信息";
    [self viewStyle];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    @try {
        UserBasicInfo *esInfo = [DataManage share].userModel.userBasicInfo;
        if([DataManage share].userModel.basicInfoState){
            _emailField.text = esInfo.email;
            [_eduBtn setTitle:esInfo.enducationDegree forState:UIControlStateNormal];
            [_maritalBtn setTitle:esInfo.maritalStatus forState:UIControlStateNormal];
            NSString *address =[NSString stringWithFormat:@"%@ %@ %@", esInfo.nowlivingProvince,esInfo.nowlivingCity,esInfo.nowlivingArea];
            [_nowlivingAddressBtn setTitle:address forState:UIControlStateNormal];
            _nowAddressField.text = [esInfo.nowlivingAddress trim];
            [_livingStateBtn setTitle:esInfo.nowLivingState forState:UIControlStateNormal];
            _supportCountField.text = [NSString stringWithFormat:@"%ld",esInfo.supportCount];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
    }

}

- (void)viewStyle{
    _subimtBtn.enabled = false;
    _supportCountField.keyboardType = UIKeyboardTypeNumberPad;
    [self.supportCountField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.nowAddressField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [self.emailField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

/**
 *  监听textField 变化，限制长度输入 ，非空、不满足条件时限制button键使用
 */
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (_emailField.text.length < 5 || _supportCountField.text.length <= 0 || _nowAddressField.text.length <=0) {
        _subimtBtn.enabled = false;
    }else{
        _subimtBtn.enabled = true;
    }
    
    if(textField == _emailField){
        if(_emailField.text.length >= 18){
            _emailField.text = [textField.text substringToIndex:18];
        }
    }
    if(textField == _supportCountField){
        if(_supportCountField.text.length >= 2){
            _supportCountField.text = [textField.text substringToIndex:2];
        }
    }
    if(textField == _nowAddressField){
        if(_nowAddressField.text.length >= 20){
            _nowAddressField.text = [textField.text substringToIndex:20];
        }
    }
}


#pragma mark OnClick Listener
// 教育
- (IBAction)eduOnClick:(id)sender {
    [self alert:sender title:@"教育程度选择" dataDict:self.enducationDict black:^(NSString *key, NSString *value) {
        NSLog(@"%@---%@",key ,value);
    }];
}

// 婚姻
- (IBAction)martalOnClick:(id)sender {
    [self alert:sender title:@"婚姻状态选择" dataDict:self.martalDict black:^(NSString *key, NSString *value) {
        NSLog(@"%@---%@",key ,value);
    }];
}

// 地址选择
- (IBAction)selectAddressOnClick:(id)sender {
     __weak typeof (self) weakSelf = self;
    ChooseLocationController *locationVc = [[ChooseLocationController alloc]init];
    [locationVc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    locationVc.block = ^(NSString *address,NSString *code){
         if(address !=nil)
        [weakSelf.nowlivingAddressBtn setTitle:address forState:UIControlStateNormal];
    };
    [self presentViewController:locationVc animated:NO completion:nil];
}

//住房性质
- (IBAction)livingStateOnClick:(id)sender {
    [self alert:sender title:@"住房性质选择" dataDict:self.livingStateDict black:^(NSString *key, NSString *value) {
        NSLog(@"%@---%@",key ,value);
    }];
}

#pragma mark 表单提交
- (IBAction)submitClick:(id)sender {
    if(![self checkButtonEmpty:_eduBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择教育程度"];
        return;
    }
    if(![self checkButtonEmpty:_maritalBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择婚姻状况"];
        return;
    }
    if(![self checkButtonEmpty:_nowlivingAddressBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择现居住地址"];
        return;
    }
    if(![self checkButtonEmpty:_livingStateBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择住房性质"];
        return;
    }
    
    NSNumber *supportCount = [NSNumber numberWithInt:[[_supportCountField.text trim] intValue]];
    NSString *nowLivingAddress = [_nowAddressField.text trim];
    NSArray *regAddress = [[_nowlivingAddressBtn.titleLabel.text trim] componentsSeparatedByString:@" "];
    // 地址省
    NSString *nowLivingProvince = @"";
    NSString *nowLivingCity = @"";
    NSString *nowLivingArea = @"";
    // 地址市
    // 区
    if([regAddress count] == 2){
        nowLivingProvince = regAddress[0];
        nowLivingCity = regAddress[0];
        nowLivingArea = regAddress[1];
    }else if([regAddress count] == 3){
        nowLivingProvince = regAddress[0];
        nowLivingCity = regAddress[1];
        nowLivingArea = regAddress[2];
    }
    
    _subimtBtn.userInteractionEnabled = false;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    paramesAddDictionary(parames);
   
    UserModel *user = [DataManage share].userModel;
    
    [parames setObject:user.idCardNumber forKey: @"idCardNumber"];                  // 身份证号
    [parames setObject:_emailField.text forKey: @"email"];                          // 邮箱
    [parames setObject:_maritalBtn.titleLabel.text forKey: @"maritalStatus"];       // 婚姻状态
    [parames setObject:supportCount forKey: @"supportCount"];                       // 供养人数
    [parames setObject:nowLivingAddress forKey: @"nowLivingAddress"];               // 常住地址
    [parames setObject:nowLivingProvince forKey: @"nowlivingProvince"];             // 现居住地址省份
    [parames setObject:nowLivingCity forKey: @"nowlivingCity"];                     // 现居住地址市
    [parames setObject:nowLivingArea forKey: @"nowlivingArea"];                     // 现居住地址区
    [parames setObject:_eduBtn.titleLabel.text forKey: @"enducationDegree"];        // 教育程度
    [parames setObject:_livingStateBtn.titleLabel.text forKey: @"nowLivingState"];  // 现居住房性质
    
    
    NSLog(@"请求数据-->%@",[STools dictJsonString: parames]);
    
    [EasyShowLodingView showLodingText:@"提交中..."];
    [session POST:url_EssentialInfo parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[STools dictJsonString: responseObject]);
              // 关闭HUD
              [EasyShowLodingView hidenLoding];
              _subimtBtn.userInteractionEnabled = true;
              if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                  // 显示登录成功toast
                  [EasyShowTextView showSuccessText:@"提交成功!"];
                  NSDictionary *result = [responseObject objectForKey:@"result"];
                  // 保存用户信息（ 静态数据保存 ）
                  [DataManage share].userModel = [UserModel userWithDic:result];
                  [parames description];
                  NSLog(@"user-数据保存->%@",[DataManage share].userModel);
                  [self.navigationController popViewControllerAnimated:YES];

              }else{
                  [EasyShowTextView showErrorText:@"提交失败!"];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [EasyShowTextView showText:@"请求失败!"];
              _subimtBtn.userInteractionEnabled = true;
              NSLog(@"failure--%@",error);
          }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ShowAlert
-(void)alert:(UIButton *)uiButton title:(NSString *)title dataDict:(NSDictionary *)data black:(void (^ __nullable)(NSString *key ,NSString *value))handler{
    // cancel button
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@">>> Click the cancel button.");
    }];
    [alertController addAction:cancelAction];
    for (NSString *key in data) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:key style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 设置内容到控件上
            [uiButton setTitle:key forState:UIControlStateNormal];
            //把选择的内容返回给调用者
            handler(key,data[key]);
        }];
        [alertController addAction:otherAction];
    }
    //show alert controller
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
