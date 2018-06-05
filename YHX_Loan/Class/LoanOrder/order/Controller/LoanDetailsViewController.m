//
//  LoanDetailsViewController.m
//  YHX_Loan
//  借款订单的详请，展示订单的类别，时间、状态、借款金额、查看还款计划表等交易详情
//  可在兴业银行订单的情况下修改还款账号，发起提前还款。
//  Created by 张磊 on 2018/5/9.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "LoanDetailsViewController.h"
#import "ChanageRepayBankNumberController.h"
#import "RepayPlanTableController.h"
@interface LoanDetailsViewController ()
/* 贷款结果*/
@property (weak, nonatomic) IBOutlet UILabel *loanStatueText;
/* 贷款结果提示*/
@property (weak, nonatomic) IBOutlet UILabel *loanTipsText;

/* 贷款类型*/
@property (weak, nonatomic) IBOutlet UILabel *loanTypeText;
/* 贷款金额*/
@property (weak, nonatomic) IBOutlet UILabel *loanMoneyText;
/* 贷款期数*/
@property (weak, nonatomic) IBOutlet UILabel *loanTermCountText;
/* 到账卡*/
@property (weak, nonatomic) IBOutlet UILabel *loanBankNumberText;
/* 还款卡号*/
@property (weak, nonatomic) IBOutlet UIButton *repayBankNumberBtn;
/* 订单时间*/
@property (weak, nonatomic) IBOutlet UILabel *orderDateText;
/* 订单编号*/
@property (weak, nonatomic) IBOutlet UILabel *orderNoText;

/* 还款bt按键*/
@property (weak, nonatomic) IBOutlet UIButton *repayBt;
@property(nonatomic, strong) NSDictionary *loanAboutDict;
// 申请状态
@property(nonatomic, strong) NSDictionary *applyStatusDict;

/*** VTM产品类型*/
@property(nonatomic, strong) NSDictionary *applyProductType;

/*** 用于兴业进件专案 */
@property(nonatomic, strong) NSDictionary *applyPromnoType;
@end

@implementation LoanDetailsViewController

#pragma mark 数据加载
-(NSDictionary *)loanAboutDict{
    if(!_loanAboutDict){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"loanAbout.plist" ofType:nil];
        _loanAboutDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _loanAboutDict;
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
   
    _repayBankNumberBtn.userInteractionEnabled = NO;
    NSInteger applyStatus = [_loanBasicInfo.applyStatus integerValue];
 
    /* 状态*/
    if(applyStatus < 400){
        /* 贷款结果*/
        _loanStatueText.text =  @"贷款申请状态";
        /* 贷款结果提示*/
        _loanTipsText.text = [self.applyStatusDict objectForKey:_loanBasicInfo.applyStatus];
        if (![[_loanBasicInfo.flowStatus trim] isEqualToString:@""]) {
            _loanTipsText.text = _loanBasicInfo.flowStatus;
        }
    }else{
        /* 贷款结果*/
        _loanStatueText.text = [self.applyStatusDict objectForKey:_loanBasicInfo.applyStatus];
        if (![[_loanBasicInfo.flowStatus trim] isEqualToString:@""]) {
            _loanStatueText.text = _loanBasicInfo.flowStatus;
        }
        if([_loanBasicInfo.applyStatus isEqualToString:@"400"]){
            _loanTipsText.text = @"放款完成，请及时关注还款";
        }else{
            /* 贷款结果提示*/
            _loanTipsText.text = @"请关注贷款信息";
        }
    }
   
    /* 贷款类型*/
    if(_loanBasicInfo.productType!= nil){
        if(![_loanBasicInfo.productType isEqualToString:@""]) {
            NSString *loan = [self.applyProductType objectForKey:_loanBasicInfo.productType];
            _loanTypeText.text = loan;
        }else{
            _loanTypeText.text =[self.applyProductType objectForKey:@"1001"];
        }
    }
    /* 订单时间*/
    NSString *time = [NSString stringWithFormat:@"%@",[DateUtils timesFormatString:_loanBasicInfo.originalLoanRegDate Pattren:@"yyyy-MM-dd HH:mm:ss"]];
    _orderDateText.text = time;
    /* 贷款金额*/
    if (_loanBasicInfo.loanMoneyAmount != nil) {
        _loanMoneyText.text =[NSString stringWithFormat:@"%.2f",[_loanBasicInfo.loanMoneyAmount doubleValue]];
    } else if (_loanBasicInfo.originalLoanMoneyAmount != nil || ![_loanBasicInfo.originalLoanMoneyAmount isEqualToString:@""] ) {
        _loanMoneyText.text = [NSString stringWithFormat:@"%.2f",[_loanBasicInfo.originalLoanMoneyAmount doubleValue]];
    }
    
    /* 贷款期数*/
    if(_loanBasicInfo.loanTermCount!=nil){
        _loanTermCountText.text = [NSString stringWithFormat:@"%@期",_loanBasicInfo.loanTermCount];
    }else if(_loanBasicInfo.originalLoanTermCount!=nil){
      _loanTermCountText.text = [NSString stringWithFormat:@"%@期",_loanBasicInfo.originalLoanTermCount];
    }
   
    /* 到账卡*/
    
    _loanBankNumberText.text = [NSString stringWithFormat:@"%@(%@)",_loanBasicInfo.loanBankName,[_loanBasicInfo.loanBankCardNO substringFromIndex:_loanBasicInfo.loanBankCardNO.length-4]];
    
    /* 还款卡号*/
   NSString *text = [NSString stringWithFormat:@"%@(%@)",_loanBasicInfo.loanBankName,[_loanBasicInfo.loanBankCardNO substringFromIndex:_loanBasicInfo.loanBankCardNO.length-4]];
    [_repayBankNumberBtn setTitle:text forState:UIControlStateNormal];
    
    /* 订单编号*/
    _orderNoText.text = _loanBasicInfo.customerCode;
    
    // 添加限制条件
    if([_loanBasicInfo.applyStatus isEqualToString: @"400"] || [_loanBasicInfo.applyStatus isEqualToString: @"500"]){
//        _repayBt.hidden = NO;
    }else{
//       _repayBt.hidden = YES;
    }
    
    if (_loanBasicInfo.channel == nil || [_loanBasicInfo.busCode isEqualToString:@""] ||
        [_loanBasicInfo.transSeq isEqualToString:@""]) {
         _repayBankNumberBtn.userInteractionEnabled = NO;
    }else{
        
        if([_loanBasicInfo.channel isEqualToString:@"10040"]){
           _repayBankNumberBtn.userInteractionEnabled = YES;
        }else{
          _repayBankNumberBtn.userInteractionEnabled = NO;
        }
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贷款详情";
    
   
}


/** 还款按键事件处理*/
- (IBAction)repayBtOnClick:(id)sender {
    RepayPlanTableController *repayVc = [[RepayPlanTableController alloc]init];
    repayVc.loan = _loanBasicInfo;
    [self.navigationController pushViewController:repayVc animated:YES];
    
}

/** 疑问bt事件处理*/
- (IBAction)doubtBtOnClick:(id)sender {
    RepayPlanTableController *repayVc = [[RepayPlanTableController alloc]init];
    repayVc.loan = _loanBasicInfo;
    [self.navigationController pushViewController:repayVc animated:YES];
}

/** 修改还款银行卡*/
- (IBAction)changeRepayBankCard:(id)sender {
    ChanageRepayBankNumberController *chanageRepaybankNumberVc =  [[ChanageRepayBankNumberController alloc]init];
    chanageRepaybankNumberVc.loan = _loanBasicInfo;
    [self.navigationController pushViewController:chanageRepaybankNumberVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
