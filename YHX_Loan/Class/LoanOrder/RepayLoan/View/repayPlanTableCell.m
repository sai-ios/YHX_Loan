//
//  repayPlanTableCell.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/9.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "repayPlanTableCell.h"
@interface repayPlanTableCell ()

// check
@property (weak, nonatomic) IBOutlet UIButton *takeUpBt;
// 还款金额
@property (weak, nonatomic) IBOutlet UILabel *psInstmAmtLabel;
// 逾期图标
@property (weak, nonatomic) IBOutlet UILabel *yuqiInd;
// 期数
@property (weak, nonatomic) IBOutlet UILabel *psPerdNoLabel;
//
@property (weak, nonatomic) IBOutlet UIView *topView;
// body
@property (weak, nonatomic) IBOutlet UIView *bodytView;
//
@property (weak, nonatomic) IBOutlet UIButton *setlIndBtn;
// 本金
@property (weak, nonatomic) IBOutlet UILabel *psPrcpAmtLabel;
// 利息
@property (weak, nonatomic) IBOutlet UILabel *psNormIntAmtLabel;
// 还款时间
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

@property(nonatomic, strong) NSIndexPath *indexPath;

// tableView
@property(nonatomic, weak) UITableView *selfTable;

//check
@property(nonatomic, assign) BOOL check;
@end

@implementation repayPlanTableCell

- (void)setRepayPlanData:(XYRepayPlan *)plan;
{
    if(plan == nil)
    return;
    @try {
      
        //显示期数
        _psPerdNoLabel.text= [NSString stringWithFormat:@"第%@期",plan.ps_perd_no];
        //计算兴业利息
        double nowNormIntAmt = plan.ps_norm_int_amt + plan.ps_od_int_amt + plan.ps_comm_od_int + plan.ps_fee
        - (plan.setl_norm_int + plan.setl_od_int_amt + plan.setl_comm_od_int + plan.setl_fee + plan.ps_wv_nm_int + plan.ps_wv_od_int + plan.ps_wv_comm_int );
        //显示利息
        _psNormIntAmtLabel.text = [NSString stringWithFormat:@"%.2f元",nowNormIntAmt];
        //计算手续费
        double psFeeAmt = plan.ps_fee_amt2 - plan.setl_fee_amt2 - plan.rdu01Amt + plan.fee_amt - plan.setl_fee_amt - plan.rdu06Amt + plan.ps_comm_amt - plan.setl_comm_amt;
        //显示还款本金,期供金额4
        _psPrcpAmtLabel.text = [NSString stringWithFormat:@"%.2f元",plan.ps_prcp_amt];
        //计算应还款金额
        double allAmt = plan.ps_prcp_amt + nowNormIntAmt + psFeeAmt;
        // 显示应还金额
        _psInstmAmtLabel.text = [NSString stringWithFormat:@"%.2f",allAmt];
        
        if ([plan.setl_ind isEqualToString:@"N"]){
            [_setlIndBtn setTitle:@"待还" forState: UIControlStateNormal];
            [self defulateBtn];
            if ([DateUtils compareDate:[DateUtils getDate:@"yyyyMMdd"] Date1Pattren:@"yyyyMMdd" date2:plan.ps_due_dt Date2Pattren:@"yyyyMMdd"]){
                _yuqiInd.hidden = YES;
                
            }else {
                _yuqiInd.hidden = NO;
            }
        }
        if ([plan.setl_ind isEqualToString:@"Y"]){
            [_setlIndBtn setTitle:@"已还" forState: UIControlStateNormal];
            [self grayBtn];
        }
        
        // 还款时间
        _endDateLabel.text = [DateUtils dateFormatter:plan.ps_due_dt beforePattren:@"yyyy-MM-dd" afterPattren:@"yyyy-MM-dd"];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
        
    }
    
    
}

- (void)setcellForRowAtIndexPath:(NSIndexPath *)indexPath table:(UITableView *)table{
    self.indexPath = indexPath;
    self.selfTable = table;
}


- (IBAction)checkClick:(id)sender {
//    [_selfTable beginUpdates];
//    NSLog(@"open  colse =======>");
//    if(_check){
//        _check = false;
//        _bodytView.hidden = YES;
//        [_takeUpBt setImage:[UIImage imageNamed:@"refund_icon_more_smal_normal"] forState:UIControlStateNormal];
//    }else{
//        _check = true;
//        _bodytView.hidden = NO;
//        [_takeUpBt setImage:[UIImage imageNamed:@"refund_icon_more_smal_select"] forState:UIControlStateNormal];
//    }
//    [_selfTable endUpdates];
    
}


+ (instancetype) repayCellWithTableView:(UITableView *)table{
    static NSString *ID = @"cell_repayPlan";
   
    repayPlanTableCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"repayPlanTableCell" owner:nil options:nil]firstObject];
    }
    
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self defulateBtn];
    [self bottonBg];
    _check = true;
}

-(void)grayBtn{
    [self.setlIndBtn.layer setMasksToBounds:YES];
    [self.setlIndBtn.layer setCornerRadius:5.0]; //设置矩圆角半径
    [self.setlIndBtn.layer setBorderWidth:0.5];   //边框宽度
    self.setlIndBtn.layer.borderColor = [UIColor grayColor].CGColor;//边框颜色
    [self.setlIndBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
-(void)defulateBtn{
    [self.setlIndBtn.layer setMasksToBounds:YES];
    [self.setlIndBtn.layer setCornerRadius:5.0]; //设置矩圆角半径
    [self.setlIndBtn.layer setBorderWidth:0.5];  //边框宽度
    self.setlIndBtn.layer.borderColor = XZRGB(0xffFE5102).CGColor;
     [self.setlIndBtn setTitleColor:XZRGB(0xffFE5102) forState:UIControlStateNormal];
}


- (void)bottonBg{
    self.bodytView.layer.cornerRadius = 5.f;
    self.bodytView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
