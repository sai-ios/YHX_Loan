//
//  JobInfoViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "JobInfoViewController.h"
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"
#import <objc/runtime.h>
#import "ChooseLocationController.h"
@interface JobInfoViewController ()

@property (weak, nonatomic) IBOutlet UIButton    *subimtBtn;
@property (weak, nonatomic) IBOutlet UIButton    *compAddressBt;
@property (weak, nonatomic) IBOutlet UIButton    *jobBtn;
@property (weak, nonatomic) IBOutlet UIButton    *jobTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton    *indivemptypBtn;
@property (weak, nonatomic) IBOutlet UIButton    *indivindtrytypBtn;
@property (weak, nonatomic) IBOutlet UIButton    *workStateBtn;
@property (weak, nonatomic) IBOutlet UITextField *salaryField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameField;
@property (weak, nonatomic) IBOutlet UITextField *departmentField;
@property (weak, nonatomic) IBOutlet UITextField *companyAddressField;
@property (weak, nonatomic) IBOutlet UITextField *acField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *jobYeasField;
@property (weak, nonatomic) IBOutlet UITextField *companyTotalWorkingTerms;
// 字典
@property(nonatomic, strong) NSDictionary *jobDict;
@property(nonatomic, strong) NSDictionary *jobTypeDict;
@property(nonatomic, strong) NSDictionary *indivemptypeDict;
@property(nonatomic, strong) NSDictionary *indivindtrytypeDict;
@property(nonatomic, strong) NSDictionary *workStateDict;
// code 职业类型
@property(nonatomic, strong) NSString *jobType;
// 单位性质
@property(nonatomic, strong) NSString *indivemptype;
// 单位行业性质
@property(nonatomic, strong) NSString *indivindtrytype;

@end

@implementation JobInfoViewController

#pragma mark 懒加载数据字典
-(NSDictionary *)jobDict{
    if(!_jobDict){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"job.plist" ofType:nil];
       _jobDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _jobDict;
}

-(NSDictionary *)jobTypeDict{
    if(!_jobTypeDict){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"10"forKey:@"受薪人士"];
        [dict setObject:@"20"forKey:@"自雇人士"];
        [dict setObject:@"50"forKey:@"其他"];
        _jobTypeDict = dict;
    }
    return _jobTypeDict;
}

-(NSDictionary *)indivemptypeDict{
    if(!_indivemptypeDict){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"A"forKey:@"国有机关、事业单位"];
        [dict setObject:@"B"forKey:@"国有企业"];
        [dict setObject:@"C"forKey:@"上市企业"];
        [dict setObject:@"D"forKey:@"世界500强"];
        [dict setObject:@"E"forKey:@"股份制企业"];
        [dict setObject:@"F"forKey:@"私营企业"];
        [dict setObject:@"G"forKey:@"个体工商户"];
        [dict setObject:@"H"forKey:@"自有职业者"];
        [dict setObject:@"Z"forKey:@"其他"];
        _indivemptypeDict = dict;
    }
    return _indivemptypeDict;
}

-(NSDictionary *)indivindtrytypeDict{
    if(!_indivindtrytypeDict){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"A"forKey:@"代发/银行流水（薪资）"];
        [dict setObject:@"B"forKey:@"社保/公积金/个税"];
        [dict setObject:@"C"forKey:@"房（车）贷"];
        [dict setObject:@"D"forKey:@"房产"];
        [dict setObject:@"E"forKey:@"保单"];
        [dict setObject:@"F"forKey:@"银行流水（自雇）"];
        [dict setObject:@"G"forKey:@"其他"];
        _indivindtrytypeDict = dict;
    }
    return _indivindtrytypeDict;
}

-(NSDictionary *)workStateDict{
    if(!_workStateDict){
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"A"forKey:@"离职"];
    [dict setObject:@"B"forKey:@"在职"];
    [dict setObject:@"C"forKey:@"兼职"];
    [dict setObject:@"D"forKey:@"其他"];
    _workStateDict = dict;
    }
    return _workStateDict;
}

#pragma mark viewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作信息";
    [self viewStyle];
    [self addViewData];
}


-(void)addViewData{
    WorkInfo *workInfo = [DataManage share].userModel.workInfo;
    @try {
        if(workInfo !=nil && [DataManage share].userModel.workState){
            NSArray *address =[workInfo.companyAddress componentsSeparatedByString:@"\t"];
            NSString *pcaAddress = [NSString stringWithFormat:@"%@ %@ %@",workInfo.indivempprovince,workInfo.indivempcity,workInfo.indivemparea];
            [self.compAddressBt setTitle:pcaAddress forState:UIControlStateNormal];
            if([address count] == 2){
                self.companyAddressField.text = address[1];
            }
            
            [self.jobBtn setTitle:workInfo.companyDuty forState:UIControlStateNormal];
        
//            [self getDictKey:self.jobTypeDict object:workInfo.proftyp black:^(NSString *key, NSString *value) {
//                [self.jobTypeBtn setTitle:key forState:UIControlStateNormal];
//
//
//            }];
             [self.jobTypeBtn setTitle:workInfo.proftyp forState:UIControlStateNormal];
            _jobType = workInfo.proftyp;
            [self getDictKey:self.indivemptypeDict object:workInfo.indivemptyp black:^(NSString *key, NSString *value) {
                 [self.indivemptypBtn setTitle:key forState:UIControlStateNormal];
                _indivemptype = workInfo.indivemptyp;
            }];
            
            [self getDictKey:self.indivindtrytypeDict object:workInfo.indivindtrytyp black:^(NSString *key, NSString *value) {
                  [self.indivindtrytypBtn setTitle:key forState:UIControlStateNormal];
                _indivindtrytype = workInfo.indivindtrytyp;
            }];
            
            [self.workStateBtn setTitle:workInfo.workState forState:UIControlStateNormal];
            self.salaryField.text = [ NSString stringWithFormat:@"%.f", workInfo.companySalaryOfMonth];
            self.companyNameField.text = [workInfo.companyName trim];
            self.departmentField.text = [workInfo.companyDept trim];
            if(workInfo.companyTel!=nil){
                NSArray *phone = [workInfo.companyTel componentsSeparatedByString:@"-"];
                if([phone count]==2){
                    self.acField.text = phone[0];
                    self.phoneField.text = phone[1];
                }
            }
            
            self.jobYeasField.text = [NSString stringWithFormat:@"%ld",workInfo.jobYear];
            self.companyTotalWorkingTerms.text = [workInfo.companyTotalWorkingTerms trim];

            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
    }
}

- (void)viewStyle{
    _subimtBtn.enabled = false;
    [_salaryField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.companyNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.departmentField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.companyAddressField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.acField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.jobYeasField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.companyTotalWorkingTerms addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

/**
 *  监听textField 变化，限制长度输入 ，非空、不满足条件时限制button键使用
 */
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (self.salaryField.text.length < 2 || self.companyNameField.text.length <= 0 || self.departmentField.text.length <= 0
        || self.companyAddressField.text.length < 5 || self.acField.text.length <= 0 || self.phoneField.text.length <=0
        || self.jobYeasField.text.length <= 0 || self.companyTotalWorkingTerms.text.length <= 0 ) {
        _subimtBtn.enabled = false;
    }else{
        _subimtBtn.enabled = true;
    }
   
    if(textField == self.acField){
        if(textField.text.length >= 4){
            textField.text = [textField.text substringToIndex:4];
        }
    }
    if(textField == self.phoneField){
        if(textField.text.length >= 8){
            textField.text = [textField.text substringToIndex:8];
        }
    }
    
    if(textField == self.jobYeasField || textField == self.companyTotalWorkingTerms){
        if(textField.text.length >= 2){
            textField.text = [textField.text substringToIndex:2];
        }
    }
}


// 职业
- (IBAction)jobBtnClick:(id)sender {
    [self alert:sender title:@"职业选择" dataDict:self.jobDict black:^(NSString *key, NSString *value) {
        NSLog(@"%@---%@",key ,value);
    }];
}

// 职业类型 indivempprovince
- (IBAction)jobTypeBtnClick:(id)sender {
    [self alert:sender title:@"职业类型选择" dataDict:self.jobTypeDict black:^(NSString *key, NSString *value) {
        NSLog(@"%@---%@",key ,value);
        _jobType = key;// 职业类型
    }];
}

// 现单位性质
- (IBAction)indivemptypBtnClick:(id)sender{
    [self alert:sender title:@"现单位性质选择" dataDict:self.indivemptypeDict black:^(NSString *key, NSString *value) {
        NSLog(@"%@---%@",key ,value);
        _indivemptype = value;// 单位性质
    }];
}

// 现单位行业性质
- (IBAction)indivindtrytypBtnClick:(id)sender{
   
    [self alert:sender title:@"现单位行业性质选择" dataDict:self.indivindtrytypeDict black:^(NSString *key, NSString *value) {
        NSLog(@"%@---%@",key ,value);
        _indivindtrytype = value;// 单位行业性质
    }];
}

// 工作状态
- (IBAction)workStateBtnClick:(id)sender {
    [self alert:sender title:@"工作状态选择" dataDict:self.workStateDict black:^(NSString *key, NSString *value) {
        NSLog(@"%@---%@",key ,value);
    }];
}

// 公司地址
- (IBAction)selectAddress:(id)sender {
    __weak typeof (self) weakSelf = self;
    ChooseLocationController *locationVc = [[ChooseLocationController alloc]init];
    [locationVc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    locationVc.block = ^(NSString *address,NSString *code){
       if(address !=nil)
            [weakSelf.compAddressBt setTitle:address forState:UIControlStateNormal];
    };
    [self presentViewController:locationVc animated:NO completion:nil];
   
}

#pragma mark 表单提交
- (IBAction)submitClick:(id)sender {
    if(![self checkButtonEmpty:_jobBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择职业"];
        return;
    }
    if(![self checkButtonEmpty:_jobTypeBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择职业类型"];
        return;
    }
    if(![self checkButtonEmpty:_indivemptypBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择现单位性质"];
        return;
    }
    if(![self checkButtonEmpty:_indivindtrytypBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择现单位行业性质"];
        return;
    }
    
    if(![self checkButtonEmpty:_compAddressBt default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择公司地址"];
        return;
    }
    
    if(![self checkButtonEmpty:_workStateBtn default:@"请选择"]){
        [EasyShowTextView showSuccessText:@"请选择现工作状态"];
        return;
    }
    NSString *companyAddress =[NSString stringWithFormat:@"%@\t%@",_compAddressBt.titleLabel.text,[_companyAddressField.text trim]];
    NSArray *address = [[_compAddressBt.titleLabel.text trim] componentsSeparatedByString:@" "];
    // 地址省
    NSString *indivempprovince = @"";
    // 地址市
    NSString *indivempcity = @"";
    // 区
    NSString *indivemparea = @"";
    // 详细地址
    NSString *indivempaddr = [_companyAddressField.text trim];
    
    if([address count] == 2){
        indivempprovince = address[0];
        indivempcity = address[0];
        indivemparea = address[1];
    }else if([address count] == 3){
        indivempprovince = address[0];
        indivempcity = address[1];
        indivemparea = address[2];
    }
    
    NSString *companyTel = [[[_acField.text trim] stringByAppendingString:@"-"] stringByAppendingString:[_phoneField.text trim]];
    _subimtBtn.userInteractionEnabled = false;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    paramesAddDictionary(parames);
    @try {
        [parames setObject:_companyNameField.text forKey: @"companyName"];          // 工作单位
        [parames setObject:@"1" forKey: @"companyType"];                            // 单位性质 ：1
        [parames setObject:_jobYeasField.text forKey: @"jobYear"];                  // 工作年限
        [parames setObject:_workStateBtn.titleLabel.text forKey: @"workState"];     // 工作状态：离职、在职、兼职、其他
        [parames setObject:_salaryField.text forKey: @"companySalaryOfMonth"];      // 个人月收入
        [parames setObject:_companyTotalWorkingTerms.text forKey: @"companyTotalWorkingTerms"];// 总工作年限
        [parames setObject:_jobType forKey: @"proftyp"];                            // 职业类型：查看附件1
        [parames setObject:indivempprovince forKey: @"indivempprovince"];           // 现单位地址（省
        [parames setObject:indivempcity forKey: @"indivempcity"];                   // 现单位地址（市）
        [parames setObject:indivemparea forKey: @"indivemparea"];                   // 现单位地址（区）
        [parames setObject:indivempaddr forKey: @"indivempaddr"];                   // 现单位地址（详细信息）
        [parames setObject:_indivemptype forKey: @"indivemptyp"];                   // 现单性质
        [parames setObject:_indivindtrytype forKey: @"indivindtrytyp"];             // 现单位行业性质
        [parames setObject:companyAddress forKey: @"companyAddress"];               // 单位地址
        [parames setObject:companyTel forKey: @"companyTel"];                       // 单位电话
        [parames setObject:_departmentField.text  forKey: @"companyDept"];          // 任职部门
        [parames setObject:_jobBtn.titleLabel.text forKey: @"companyDuty"];         // 职位
        
        NSLog(@"请求数据-->%@",[STools dictJsonString: parames]);
        
        [EasyShowLodingView showLodingText:@"提交中..."];
        [session POST:url_WorkInfo parameters:parames progress:nil
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
    @catch (NSException *exception) {
        NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
    }
}

#pragma mark  选择器 UIAlertController
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

-(void)getDictKey:(NSDictionary *)data object:(NSString*)str black:(void (^ __nullable)(NSString *key ,NSString *value))handler{
    
    if(str!=nil){
        for (NSString *key in data) {
            //把选择的内容返回给调用者
        if([data[key] isEqualToString:str])
            handler(key,data[key]);
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
