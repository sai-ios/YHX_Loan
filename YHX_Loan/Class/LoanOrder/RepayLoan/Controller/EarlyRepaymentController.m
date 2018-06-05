//
//  EarlyRepaymentController.m
//  YHX_Loan
//  按照还款计划还款：主要实现功能，查询本期账单是否还完，是否逾期；逾期归还欠款和本金等；
//  提前还款：还款模式为TQ：溢缴款 NM ：归还欠款 FS ：全部还款
//  Created by 张磊 on 2018/5/10.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "EarlyRepaymentController.h"

@interface EarlyRepaymentController ()
@property (weak, nonatomic) IBOutlet UITextField *repayMoneyTextField;
@property (weak, nonatomic) IBOutlet UILabel *psMoneyLabel;
// 本金
@property (weak, nonatomic) IBOutlet UILabel *prcpAmtLable;
// 利息
@property (weak, nonatomic) IBOutlet UILabel *normIntAmtLabel;
// 手续费
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIView *feeLayView;
// 逾期费
@property (weak, nonatomic) IBOutlet UILabel *yuqiFeeLabel;
@property (weak, nonatomic) IBOutlet UIView *yuqiLayView;
// bank
@property (weak, nonatomic) IBOutlet UIImageView *bankIcon;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *repayBtn;

@end

@implementation EarlyRepaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)onClick:(id)sender {
}


@end
