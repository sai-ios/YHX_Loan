//
//  LoanContactViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/8.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "LoanContactViewController.h"
#import "SelectLoanAmountController.h"
#import <ContactsUI/ContactsUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Permission.h"
@interface LoanContactViewController ()<CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstRealName;
@property (weak, nonatomic) IBOutlet UIButton *firstPhoneBt;
@property (weak, nonatomic) IBOutlet UIButton *firstRelationBt;

@property (weak, nonatomic) IBOutlet UITextField *realName2;
@property (weak, nonatomic) IBOutlet UIButton *phone2Bt;
@property (weak, nonatomic) IBOutlet UIButton *relation2Bt;

@property (nonatomic , strong) CNContactPickerViewController *contactPicker;
// sign
@property(nonatomic, assign) int selectId;
// 第一联系人dict
@property(nonatomic, strong) NSDictionary *firstRelationDict;
@property(nonatomic, strong) NSDictionary *relationDict;
@end

@implementation LoanContactViewController
#pragma mark 数据加载
- (CNContactPickerViewController *)contactPicker{
    
    if (_contactPicker == nil) {
        _contactPicker = [[CNContactPickerViewController alloc] init];
        _contactPicker.delegate = self;
    }
    return _contactPicker;
    
}

-(NSDictionary *)firstRelationDict{
    if(!_firstRelationDict){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"loanAbout.plist" ofType:nil];
        _firstRelationDict = [[NSDictionary dictionaryWithContentsOfFile:path]objectForKey:@"firstRelation"];
    }
    return _firstRelationDict;
}

-(NSDictionary *)relationDict{
    if(!_relationDict){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"loanAbout.plist" ofType:nil];
        _relationDict = [[NSDictionary dictionaryWithContentsOfFile:path]objectForKey:@"relation"];
    }
    return _relationDict;
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系人";
    _selectId = 0;
    [self setBackButtonTarget:self action:@selector(popRootVcCilck)];
}

-(void)popRootVcCilck{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 表单按键选择事件处理
- (IBAction)selectPhoneBt:(id)sender {

    if(sender == _firstPhoneBt){
        NSLog(@"_firstPhoneBt");
         _selectId = 0;
        [self PermissionContactAuthorSelect];
    }
    
    if(sender == _firstRelationBt){
        NSLog(@"_firstRelationBt");
        [self showAlertList:dictValueInTitle title:@"联系人关系" dataDict:self.firstRelationDict black:^(NSString *key, NSString *value) {
             [_firstRelationBt setTitle:value forState:UIControlStateNormal];
        }];
    }
    
    if(sender == _phone2Bt)
    {   _selectId = 1;
        NSLog(@"_phone2Bt");
        [self PermissionContactAuthorSelect];
    }
    if(sender == _relation2Bt)
    {
        NSLog(@"_relation2Bt");
        [self showAlertList:dictValueInTitle title:@"联系人关系" dataDict:self.relationDict black:^(NSString *key, NSString *value) {
            [_relation2Bt setTitle:value forState:UIControlStateNormal];
        }];
    }
}

#pragma mark 贷款信息保存
- (IBAction)submit:(id)sender {
    if(![self checkFieldEmpty:_firstRealName] || ![self checkFieldEmpty:_realName2]){
        [EasyShowTextView showInfoText:@"请填写联系人真实姓名"];
        return;
    }
    if(![self checkButtonEmpty:_firstPhoneBt default:@"请选择"]||![self checkButtonEmpty:_phone2Bt default:@"请选择"]){
        [EasyShowTextView showInfoText:@"请选择联系人"];
        return;
    }
    if(![self checkButtonEmpty:_firstRelationBt default:@"请选择"]||![self checkButtonEmpty:_relation2Bt default:@"请选择"]){
        [EasyShowTextView showInfoText:@"请选择联系人关系"];
        return;
    }
    Relation *relation1 = [[Relation alloc]init];
    relation1.rowNo = @"1";
    relation1.relationCustomerName = _firstRealName.text;
    relation1.relationCustomerMobile = _firstPhoneBt.titleLabel.text;
    relation1.relationName =_firstRelationBt.titleLabel.text;
    Relation *relation2 = [[Relation alloc]init];
    relation2.rowNo = @"2";
    relation2.relationCustomerName = _realName2.text;
    relation2.relationCustomerMobile = _phone2Bt.titleLabel.text;
    relation2.relationName =_relation2Bt.titleLabel.text;
    
    NSMutableArray *relationArray = [NSMutableArray array];
    
    [relationArray addObject: relation1];
    [relationArray addObject: relation2];
    [LoanApplyModel share].relationInfos = relationArray;
    
    SelectLoanAmountController *selectLoanAmountVc = [[SelectLoanAmountController alloc]init];
    [self.navigationController pushViewController:selectLoanAmountVc animated:YES];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 代理方法
// 控制器点击取消的时候调用
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
   
    NSLog(@"点击了取消");
}
#pragma mark contact 代理方法返回
// 点击了联系人的时候调用, 如果实现了这个方法, 就无法进入联系人详情界面
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    [EasyShowLodingView hidenLoingInView:self.view];
    // contact属性就是联系人的信息
    NSLog(@"%@---%@", contact.familyName, contact.givenName);// 姓 --- 名字
    NSLog(@"%@",contact.jobTitle);
    __weak typeof(self) weakSelf = self;
    // 获取联系人的电话号码
    NSArray<CNLabeledValue<CNPhoneNumber*>*> *phoneNumbers = contact.phoneNumbers;

    // 注意, 由于这个数组规定了泛型, 所以要使用遍历器来取出每一个特定类型的对象, 才能取到里面的属性
    [phoneNumbers enumerateObjectsUsingBlock:^(CNLabeledValue<CNPhoneNumber*> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSLog(@"phoneNumber = %@",obj.value.stringValue);//电话
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName, contact.givenName];
       
        NSString *phone = obj.value.stringValue;
        //可以把-、+86、空格 、特殊符号这些过滤掉
        NSString *phoneStr = [phone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        phoneStr = [STools replaceAll:phoneStr regex:@"[^0-9]" replacecement:@""];
        if([STools compile:phoneStr pattern:PATTERN_Phone]){
             NSLog(@"手机号正确");
            if(weakSelf.selectId == 0){
                [weakSelf.firstRealName setText:nameStr];
                [weakSelf.firstPhoneBt setTitle:phoneStr forState:UIControlStateNormal];
            
            }else if(weakSelf.selectId == 1){
                [weakSelf.realName2 setText:nameStr];
                [weakSelf.phone2Bt setTitle:phoneStr forState:UIControlStateNormal];
            }
            
        }else{
            NSLog(@"手机号有误");
            [self showAlertHint:@"请选择手机号" message:@"手机号不正确，请重新选择11位正确的手机号" buttonTitle:@"确定" handler:^(UIAlertAction *action) {
            }];
//            [EasyShowTextView showText:@"请选择正确的手机号"];
        }
    }];
}

-(void)presentContactPicker{
    [self presentViewController:self.contactPicker  animated:YES completion:^{

    }];
}

#pragma  mark 访问通讯录

-(BOOL)PermissionContactAuthorSelect{
    [EasyShowLodingView showLodingText:@"加载中..." inView:self.view];
    //创建CNContactStore对象,用与获取和保存通讯录信息
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        //首次访问通讯录会调用
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) return;
            if (granted) {//允许
                NSLog(@"授权访问通讯录");
                //调用通讯录
                [self presentContactPicker];
              
            }else{//拒绝
                NSLog(@"拒绝访问通讯录");//访问通讯录
                 [self openPermissionSetting];
            }
        }];
        return YES;
    }
    else if([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
        //调用通讯录
        [self presentContactPicker];
    }else{
        //无权限访问
        [self openPermissionSetting];
        return YES;
       
    }
    return NO;
}

-(void)showAlertHint:(NSString *)title message:(NSString *)data buttonTitle:(NSString*)btntitle handler:(void (^ __nullable)(UIAlertAction *action))handler{
    // cancel button
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:data preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:btntitle style:UIAlertActionStyleCancel handler:handler];
    [alertController addAction:cancelAction];
    //show alert controller
    
    [self dismissViewControllerAnimated:NO completion:^{
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
}

#pragma 引导打开权限
-(void)openPermissionSetting{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无权限选择联系人" message:@"因为缺少权限，所以不能选择联系人，您可以去设置界面打开“联系人”权限。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@">>> Click the cancel button.");
    }];
    [alertController addAction:cancelAction];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"去打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [Permission CanOpenURLToSetting:^(BOOL success) {
            if(success)
                NSLog(@"CanOpenURLToSetting==>YES");
            else
                NSLog(@"CanOpenURLToSetting==>NO");
        }];
        
    }];
    [alertController addAction:yesAction];
    //show alert controller
    [self presentViewController:alertController animated:YES completion:nil];
}
   

@end
