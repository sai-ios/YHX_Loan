//
//  SelectLoanAmountController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/29.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "SelectLoanAmountController.h"
#import "NSLoanAuthorizedViewController.h"
#import "BankCardCell.h"
#import "NSWebViewController.h"
#import "NSAgreeBookBean.h"
#define MinMoney 1000
#define MaxMoney 20000
#define MaxLoanErrorCount 4
#define DarkGoldColor [UIColor colorWithRed:248/255.0 green:181/255.0 blue:81/255.0 alpha:1]
@interface SelectLoanAmountController ()

@property (weak, nonatomic) IBOutlet UILabel *maxLoanMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *applyMoneyField;
@property (weak, nonatomic) IBOutlet UIButton *applyCountBt;
// 还款日
@property (weak, nonatomic) IBOutlet UIButton *repayBt;
// 还款日
@property (weak, nonatomic) IBOutlet UILabel *repayDateLabel;
// 还款方式
@property (weak, nonatomic) IBOutlet UIButton *mtdcdeBt;
// 用途
@property (weak, nonatomic) IBOutlet UIButton *purposeBtn;
// 银行卡选择
@property (weak, nonatomic) IBOutlet UIButton *bankBtn;
// 贷款协议
@property (weak, nonatomic) IBOutlet UIButton *agreeBook1;
// 自动扣款协议
@property (weak, nonatomic) IBOutlet UIButton *agreeBook2;
// agree
@property (weak, nonatomic) IBOutlet UIButton *agreeCheck;
@property(nonatomic, assign) BOOL agreeBool;
@property (weak, nonatomic) IBOutlet UIButton *submitApplyBtn;

// 银行卡Sheet
@property(nonatomic, strong) NSArray<AWRActionSheetItem*> *bankActionArray;
// 贷款银行卡
@property(nonatomic, strong) BankCard *loanBankCard;
// 贷款期数
@property(nonatomic, strong) NSDictionary *loanCountDict;
@property(nonatomic, assign) NSInteger loanCount;
// 还款方式
@property(nonatomic, strong) NSDictionary *mtdcdeDict;
@property(nonatomic, strong) NSString *mtdcde;
// 用途
@property(nonatomic, strong) NSDictionary *purposeDict;
// 错误次数统计，如有超过四次者，推出本次申请
@property(nonatomic,assign) int loanErrorCount;
@end

@implementation SelectLoanAmountController

#pragma mark 数据加载
-(NSArray *)bankActionArray{
 
    if(!_bankActionArray){
        NSMutableArray *array = [NSMutableArray array];
       NSArray *bankArray =  [DataManage share].userModel.bankCardArray;
        for (NSDictionary *dict in bankArray) {
            BankCard *bankCard = [BankCard bankWithDic:dict];
            AWRActionSheetItem *item = [[AWRActionSheetItem alloc]init];
            item.userData = dict;
            item.iconImage = [BankCardCell bankIconWithName:bankCard.bankName];
            item.title = [NSString stringWithFormat:@"%@ (%@)",bankCard.bankName,[bankCard.bankCardNumber substringFromIndex:bankCard.bankCardNumber.length-4]];
            
            [array addObject:item];
            
        }
        _bankActionArray = array;
    }
    return _bankActionArray;
}

-(NSDictionary *)loanCountDict{
    if(!_loanCountDict){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"12期" forKey:@"12"];
        [dict setObject:@"18期" forKey:@"18"];
        [dict setObject:@"24期" forKey:@"24"];
        _loanCountDict = dict;
        
    }
    return _loanCountDict;
}

-(NSDictionary *)mtdcdeDict{
    if(!_mtdcdeDict){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"等额本息" forKey:@"DEBX"];
        _mtdcdeDict = dict;
        
    }
    return _mtdcdeDict;
}

-(NSDictionary *)purposeDict{
    if(!_purposeDict){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"装修" forKey:@"1"];
        [dict setObject:@"教育" forKey:@"2"];
        [dict setObject:@"婚庆" forKey:@"3"];
        [dict setObject:@"家用电器" forKey:@"4"];
        [dict setObject:@"贬值耐用" forKey:@"5"];
        [dict setObject:@"手机数码" forKey:@"6"];
        [dict setObject:@"保值耐用" forKey:@"7"];
        [dict setObject:@"其他" forKey:@"8"];
        _purposeDict = dict;
        
    }
    return _purposeDict;
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    _loanErrorCount = 0;
    [self loadData];
}

-(void)loadData{
    _agreeBool = false;
    self.title = @"额度选择";
    self.repayDateLabel.text = @"";
    self.mtdcde = @"DEBX";
    self.loanCount = 12;
    _submitApplyBtn.enabled = false;
    [self.mtdcdeBt setTitle:@"等额本息" forState:UIControlStateNormal];
    [self.applyMoneyField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
  
}

/**
 *  监听textField 变化，限制长度输入 ，非空、不满足条件时限制button键使用
 */
- (void)textFieldDidChange:(UITextField *)textField{
    
    if ([textField.text integerValue] < MinMoney) {
        _submitApplyBtn.enabled = false;
    }else{
        _submitApplyBtn.enabled = true;
    }
    
    if([textField.text integerValue] > MaxMoney){
        textField.text = [NSString stringWithFormat:@"%d",MaxMoney];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 点击事件
// 期数
- (IBAction)LoanCountClick:(id)sender {
    [self showAlertList:dictValueInTitle title:@"期数选择" dataDict:self.loanCountDict black:^(NSString *key, NSString *value) {
        _loanCount = [key integerValue];
        [_applyCountBt setTitle:value forState:UIControlStateNormal];
    }];
    
}

// 还款日提示
- (IBAction)repayHintClick:(id)sender {
    [self showAlertHint:@"还款日" message:@"此专案还款日，请根据最终审批后的还款计划表还款！" buttonTitle:@"确定" handler:^(UIAlertAction *action) {
    }];
    
}

// 还款方式
- (IBAction)mtdcdeCilck:(id)sender {
    [self showAlertList:dictValueInTitle title:@"还款方式选择" dataDict:self.mtdcdeDict black:^(NSString *key, NSString *value) {
        _mtdcde = key;
        [_mtdcdeBt setTitle:value forState:UIControlStateNormal];
    }];
}

// 用途
- (IBAction)purposeClcik:(id)sender {
    [self showAlertList:dictValueInTitle title:@"用途选择" dataDict:self.purposeDict black:^(NSString *key, NSString *value) {

        [_purposeBtn setTitle:value forState:UIControlStateNormal];
    }];

}

// 到账卡
- (IBAction)bankClick:(id)sender {
    
    AWRActionSheetView *actionSheet =[[AWRActionSheetView alloc] initWithTitle:@"请选择到账卡"
                                                                       message:@""
                                                                   actionItems:self.bankActionArray
                                                                    cancelText:@"取消"];
    //END actionSheet show
    [actionSheet show:^{
            NSLog(@"You chose to cancel.");
        }
        selectedBlock:^(NSInteger selectedIndex, AWRActionSheetItem *actionItem) {
             NSLog(@"You selected index:%ld, title:%@", (long)selectedIndex, actionItem.title);
            _loanBankCard = [BankCard bankWithDic:actionItem.userData];
            [_bankBtn setTitle:actionItem.title forState:UIControlStateNormal];
           
        }
     ];

}

// 协议书
- (IBAction)agreeBookClick:(id)sender {
    if([self addLoanData]){
        NSWebViewController *webVC = [[NSWebViewController alloc]init];
        if(sender == _agreeBook1){
            webVC.url = @"jiekuanxieyi.html";
        }else if(sender == _agreeBook2){
            webVC.url = @"daikouxieyi.html";
        }
         webVC.jsonData = [[[[NSAgreeBookBean alloc]init] setBookData:[LoanApplyModel share]] yy_modelToJSONString];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (BOOL)addLoanData{
   
    if(![self checkButtonEmpty:_applyCountBt default:@"请选择"]){
        [EasyShowTextView showInfoText:@"请选择贷款期数"];
        return false;
    }
    
    if(![self checkButtonEmpty:_mtdcdeBt default:@"请选择"]){
        [EasyShowTextView showInfoText:@"请选择还款方式"];
        return false;
    }
    
    if(![self checkButtonEmpty:_purposeBtn default:@"请选择"]){
        [EasyShowTextView showInfoText:@"请选择使用方式"];
        return false;
    }
    
    if(![self checkButtonEmpty:_applyCountBt default:@"请选择"]){
        [EasyShowTextView showInfoText:@"请选择到账银行卡"];
        return false;
    }
   
    
    UserModel *user = [DataManage share].userModel;
    [LoanApplyModel share].loginName = user.loginName;          // String 登陆名
    [LoanApplyModel share].realName = user.realName;            // String 姓名
    [LoanApplyModel share].sex = user.sex;                      // String 性别 1男0女
    [LoanApplyModel share].idCardNumber = user.idCardNumber;    // String 身份证号
    [LoanApplyModel share].birthday = user.birthday;            // Datetime 出生日期（yyyyMMdd格式，如：19830812）
    [LoanApplyModel share].mobile = user.loginName;             // String 手机号码
    [LoanApplyModel share].homeTel = @"";                       // String 住宅电话
    
    UserBasicInfo *basicInfo = user.userBasicInfo;
    [LoanApplyModel share].email = basicInfo.email;                         // String 电子邮箱
    [LoanApplyModel share].maritalStatus = basicInfo.maritalStatus;         // String 婚姻状态
    [LoanApplyModel share].supportCount = basicInfo.supportCount;           // Int  供养人数
    [LoanApplyModel share].nowLivingAddress = basicInfo.nowlivingAddress;   // String 常住地址
    [LoanApplyModel share].enducationDegree = basicInfo.enducationDegree;   // String  教育程度
    
    WorkInfo *workInfo = user.workInfo;
    [LoanApplyModel share].companyName = workInfo.companyName;          // String 工作单位
    [LoanApplyModel share].companyType = workInfo.companyType;          // String 单位性质
    [LoanApplyModel share].workState   = workInfo.workState;            // 工作状态
    [LoanApplyModel share].companyAddress = workInfo.companyAddress;    // String 单位地址
    [LoanApplyModel share].companyTel  = workInfo.companyTel;           // String 单位电话
    
    [LoanApplyModel share].companyDept  = workInfo.companyDept;         // String 任职部门
    [LoanApplyModel share].companyDuty  = workInfo.companyDuty;         // String 职位
    
    [LoanApplyModel share].companySalaryOfMonth =  workInfo.companySalaryOfMonth; // Decimal 个人月收入
    [LoanApplyModel share].idCardNumberEffectPeriodOfStart = user.signdate;       // String 身份证有效期（开始）
    [LoanApplyModel share].idCardNumberEffectPeriodOfEnd = user.expirydate;       // String 身份证有效期（结束）
    [LoanApplyModel share].residenceAddress = user.residenceAddress;              // String 户籍地址
    
    [LoanApplyModel share].bankName = _loanBankCard.bankName;                  // String 开户行支行
    [LoanApplyModel share].bankCardNumber = _loanBankCard.bankCardNumber;      // String 银行卡账号
    [LoanApplyModel share].bankCardPLMobile = _loanBankCard.bankCardPLMobile;  // String 银行预留手机号
    [LoanApplyModel share].nowLivingState = basicInfo.nowLivingState;          // String 现居住房性质
    
    [LoanApplyModel share].jobYear = workInfo.jobYear;                                  // Int 工作年限
    [LoanApplyModel share].companyTotalWorkingTerms = workInfo.companyTotalWorkingTerms;// 总工作年限
    
    /**新增字段*/
    [LoanApplyModel share].purpose = _purposeBtn.titleLabel.text;           // 贷款用途
    [LoanApplyModel share].mtdcde = _mtdcdeBt.titleLabel.text;              // 还款方式
    [LoanApplyModel share].typfreqcde = @"1M";                              // 还款间隔
    [LoanApplyModel share].regprovince = user.regprovince;                  // 户籍地址（省）
    [LoanApplyModel share].regcity = user.regcity;                          // 户籍地址（市）
    [LoanApplyModel share].regarea = user.regarea;                          // 户籍地址（区）
    [LoanApplyModel share].regaddr = user.regaddr;                          // 籍地址（详细地址
    [LoanApplyModel share].proftyp = workInfo.proftyp;                      // 职业类型
    [LoanApplyModel share].indivempprovince = workInfo.indivempprovince;    // 现单位地址（省）
    [LoanApplyModel share].indivempcity = workInfo.indivempcity;            // 现单位地址（市）
    [LoanApplyModel share].indivemparea = workInfo.indivemparea;            // 现单位地址（区）
    [LoanApplyModel share].indivempaddr = workInfo.indivempaddr;            // 现单位地址（详细信息）
    [LoanApplyModel share].indivemptyp = workInfo.indivemptyp;              // 现单位性质
    [LoanApplyModel share].indivindtrytyp = workInfo.indivindtrytyp;        // 现单位行业性质
    
    [LoanApplyModel share].loanMoneyAmount = [_applyMoneyField.text doubleValue]; // 借款金额
    [LoanApplyModel share].loanTermCount = _loanCount;                            // 借款期数
    NSLog(@"%@", [STools dictJsonString:[[LoanApplyModel share] yy_modelToJSONObject]]);
    return true;
}

// check button
- (IBAction)checkClick:(id)sender {
    if(!_agreeBool){
        _agreeBool = true;
        [_agreeCheck setImage:[UIImage imageNamed:@"loan_icon_deal_select.png"] forState:UIControlStateNormal];
    }else{
        _agreeBool = false;
        [_agreeCheck setImage:[UIImage imageNamed:@"loan_icon_deal_normal.png"] forState:UIControlStateNormal];
    }
}

#pragma mark 申请提交
- (IBAction)next:(id)sender {
    if(!_agreeBool){
        [EasyShowTextView showInfoText:@"请查看并同意协议"];
        return;
    }
    if(![self addLoanData]){
        return;
    }
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSDictionary *parames = [[LoanApplyModel share] yy_modelToJSONObject];
    NSLog(@"请求数据--%@",[STools dictJsonString: parames]);
   
    [EasyShowLodingView showLodingText:@"申请提交中"];
   
    [session POST:url_applyLoan parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[STools dictJsonString: responseObject]);
              [EasyShowLodingView hidenLoding];  // 关闭HUD
              NSString *resCode = responseObject[@"respCode"];
              NSString *respMsg = responseObject[@"respMsg"];
              if([resCode isEqualToString:@"00"]){
                  NSLoanAuthorizedViewController *authorzedVc = [[NSLoanAuthorizedViewController alloc]init];
                  [self.navigationController pushViewController:authorzedVc animated:YES];
              }else if([resCode isEqualToString:@"99"]||[resCode isEqualToString:@"-99"]){
                  [self showAlertHint:@"申请提交失败" message:@"如多次尝试未成功，请联系管理员"
                          buttonTitle:@"确定" handler:^(UIAlertAction *action) {}];
                  
              }else if([resCode isEqualToString:@"05"]||[resCode isEqualToString:@"96"]){
                  NSString *msg = [NSString stringWithFormat:@"申请受限，本次申请结束：\n%@",respMsg];
                  [self showAlertHint:@"申请失败" message:msg buttonTitle:@"确定" handler:^(UIAlertAction *action) {
                      [self.navigationController popToRootViewControllerAnimated:YES];
                  }];
                  
              }else{
                  _loanErrorCount ++;
                  if(_loanErrorCount<=4){
                      [self showAlertHint:@"申请失败" message:[NSString stringWithFormat:@"%@错误次数 +%d", respMsg,_loanErrorCount]
                              buttonTitle:@"确定" handler:^(UIAlertAction *action) {}];
                  }else{
                      [self showAlertHint:@"申请失败" message:@"申请次数超限，本次申请结束" buttonTitle:@"确定" handler:^(UIAlertAction *action) {
                          [self.navigationController popToRootViewControllerAnimated:YES];
                      }];
                  }
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [EasyShowTextView showText:@"请求失败!"];
              NSLog(@"failure--%@",error);
          }];
    
}

@end
