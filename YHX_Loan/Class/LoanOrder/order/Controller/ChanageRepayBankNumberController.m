//
//  ChanageRepayBankNumberController.m
//  YHX_Loan
//  修改还款账户
//  Created by 张磊 on 2018/5/10.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "ChanageRepayBankNumberController.h"
#import "BankCardCell.h"
@interface ChanageRepayBankNumberController ()
@property (weak, nonatomic) IBOutlet UILabel *loanNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowBankNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *chanageBankNuberBt;
@property (weak, nonatomic) IBOutlet UIButton *chanageSubmitBt;

@property(nonatomic, strong) NSDictionary *loanAboutDict;
// 申请状态
@property(nonatomic, strong) NSDictionary *applyStatusDict;

/*** VTM产品类型*/
@property(nonatomic, strong) NSDictionary *applyProductType;

/*** 用于兴业进件专案 */
@property(nonatomic, strong) NSDictionary *applyPromnoType;

// 银行卡Sheet
@property(nonatomic, strong) NSArray<AWRActionSheetItem*> *bankActionArray;
// 贷款银行卡
@property(nonatomic, strong) BankCard *loanBankCard;

//
@property(nonatomic, strong) NSDictionary *bankCodeDict;
@end

@implementation ChanageRepayBankNumberController

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

-(NSDictionary *)loanAboutDict{
    if(!_loanAboutDict){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"loanAbout.plist" ofType:nil];
        _loanAboutDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _loanAboutDict;
}

-(NSDictionary *)bankCodeDict{
    if(!_bankCodeDict){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"bankCode.plist" ofType:nil];
        _bankCodeDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _bankCodeDict;
}

-(NSDictionary *)applyStatusDict{
    if(!_applyStatusDict){
        _applyStatusDict = [self.loanAboutDict objectForKey:@"applyStatus"];
    }
    return _applyStatusDict;
}

-(NSDictionary *)applyProductType{
    if(!_applyProductType){
        _applyProductType = [self.loanAboutDict objectForKey:@"vtmProduct"];
    }
    return _applyProductType;
}

-(NSDictionary *)applyPromnoType{
    if(!_applyPromnoType){
        _applyPromnoType = [self.loanAboutDict objectForKey:@"xyapplyPromno"];
    }
    return _applyPromnoType;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // NAME
    /* 贷款类型*/
    if(_loan.productType!= nil){
        if(![_loan.productType isEqualToString:@""]) {
            NSString *loan = [self.applyProductType objectForKey:_loan.productType];
            _loanNameLabel.text = loan;
        }else{
            _loanNameLabel.text =[self.applyProductType objectForKey:@"1001"];
        }
    }
    /* 订单编号*/
    _orderIdLabel.text = _loan.customerCode;
    _nowBankNumberLabel.text = [NSString stringWithFormat:@"%@(%@)",_loan.loanBankName,[_loan.loanBankCardNO substringFromIndex:_loan.loanBankCardNO.length-4]];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改还款账户";
}


- (IBAction)onViewClicked:(id)sender {

    if(sender == _chanageBankNuberBt){

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
                [_chanageBankNuberBt setTitle:actionItem.title forState:UIControlStateNormal];
                
            }
         ];
        
    }else if(sender == _chanageSubmitBt){
        //  提交修改
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        session.requestSerializer=[AFJSONRequestSerializer serializer];
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        UserModel *user = [DataManage share].userModel;
        NSString *bankCode = [self getBankCode:_loanBankCard.bankName];
        [parames setObject:user.realName  forKey:@"realName"];
        [parames setObject:user.idCardNumber  forKey:@"idCard"];
        [parames setObject:bankCode  forKey:@"acctbankcde"];
        [parames setObject:_loan.transSeq  forKey:@"chnseq"];
        [parames setObject:_loanBankCard.bankCardNumber  forKey:@"cardno"];
        [parames setObject:_loanBankCard.bankCardPLMobile  forKey:@"phoneno"];
        
        NSLog(@"请求数据-->%@",[STools dictJsonString: parames]);
        
        [EasyShowLodingView showLodingText:@"请稍等"];
        
        [session POST:url_repayAccChange parameters:parames progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSLog(@"success--%@",[STools dictJsonString: responseObject]);
                  [EasyShowLodingView hidenLoding];  // 关闭HUD
                  NSString *respCode = [responseObject objectForKey:@"respCode"];
                  NSString *respMsg = [responseObject objectForKey:@"respMsg"];
                  if([respCode isEqualToString:@"000000"]){
                      [self showAlertHint:@"处理结果" message:@"修改成功!" buttonTitle:@"确定" handler:^(UIAlertAction *action) {
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
                  }else{
                      [self showAlertHint:@"处理失败" message:respMsg buttonTitle:@"确定" handler:^(UIAlertAction *action) {
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  [EasyShowLodingView hidenLoding];
                  [EasyShowTextView showText:@"请求失败!"];
                  NSLog(@"failure--%@",error);
              }];
    } 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSString *)getBankCode:(NSString *)name{
    for(NSString *key in self.bankCodeDict){
        if([name containsString:[self.bankCodeDict objectForKey:key]]){
            return key;
        }
    }
    return @"0000";
}

@end
