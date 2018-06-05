//
//  LoanListTableViewCell.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "LoanListTableViewCell.h"
@interface LoanListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *loanName;
@property (weak, nonatomic) IBOutlet UILabel *loanMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanStatusLabel;

@property(nonatomic, strong) NSDictionary *loanAboutDict;
// 申请状态
@property(nonatomic, strong) NSDictionary *applyStatusDict;
/**
 * VTM产品类型
 */
@property(nonatomic, strong) NSDictionary *applyProductType;

/**
 * 用于兴业进件专案
 */
@property(nonatomic, strong) NSDictionary *applyPromnoType;

@end

@implementation LoanListTableViewCell

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

#pragma mark TableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setCellLoanInfo:(LoanApplyBasicInfo*)loanInfo{
    NSLog(@"LoanListTableViewCell===================================>\n %@ \n",[loanInfo yy_modelToJSONString]);
    if(loanInfo.productType!= nil){
        if(![loanInfo.productType isEqualToString:@""]) {
            NSString *loan = [self.applyProductType objectForKey:loanInfo.productType];
            _loanName.text = loan;
        }else{
           _loanName.text =[self.applyProductType objectForKey:@"1001"];
        }
    }
    @try {
        //申请时间
        NSString *time = [NSString stringWithFormat:@"%@",[DateUtils timesFormatString:loanInfo.originalLoanRegDate Pattren:@"yyyy-MM-dd HH:mm:ss"]];
        _loanDateLabel.text = time;
        NSLog(@"loanMoneyAmount = %@ ;originalLoanMoneyAmount = %@",loanInfo.loanMoneyAmount,loanInfo.originalLoanMoneyAmount);
        if (loanInfo.loanMoneyAmount != nil) {
            _loanMoneyLabel.text =[NSString stringWithFormat:@"%.2f",[loanInfo.loanMoneyAmount doubleValue]];
        } else if (loanInfo.originalLoanMoneyAmount != nil || ![loanInfo.originalLoanMoneyAmount isEqualToString:@""] ) {
            _loanMoneyLabel.text = [NSString stringWithFormat:@"%.2f",[loanInfo.originalLoanMoneyAmount doubleValue]];
        }
        // 设置申请状态
        NSLog(@"申请状态 applyStatus==》key:%@  value:%@",loanInfo.applyStatus, [self.applyStatusDict objectForKey:loanInfo.applyStatus]);
        NSLog(@"申请状态 flowStatus==》%@ ",loanInfo.flowStatus);
        
        _loanStatusLabel.text = [self.applyStatusDict objectForKey:loanInfo.applyStatus];
       
        if (![[loanInfo.flowStatus trim] isEqualToString:@""]) {
           NSLog(@"申请状态xy ==》%@",loanInfo.flowStatus);
            _loanStatusLabel.text = loanInfo.flowStatus;
        }
   
        if([loanInfo.applyStatus isEqualToString:@"006"]||[loanInfo.applyStatus isEqualToString:@"200"]||
           [loanInfo.applyStatus isEqualToString:@"300"]||[loanInfo.applyStatus isEqualToString:@"303"]){
            [_loanStatusLabel setTextColor:[UIColor greenColor]];
        }else if([loanInfo.applyStatus isEqualToString:@"101"]||[loanInfo.applyStatus isEqualToString:@"201"]||[loanInfo.applyStatus isEqualToString:@"402"]){
             NSLog(@"申请状态Color ==》%@",[UIColor redColor]);
            [_loanStatusLabel setTextColor:[UIColor redColor]];
        }else if([loanInfo.applyStatus isEqualToString:@"400"]){
             NSLog(@"申请状态Color ==》%@",XZRGB(0xfff3b20d));
            [_loanStatusLabel setTextColor:XZRGB(0xfff3b20d)];
        }else{
             NSLog(@"申请状态Color ==》%@",[UIColor darkGrayColor]);
            [_loanStatusLabel setTextColor:[UIColor darkGrayColor]];
        }
    } @catch (NSException *exception) {
        NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
    }
    
    NSLog(@"=============================================================\n\n\n");
}

+ (instancetype) loanListCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell_loanlist";
    
    LoanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LoanListTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
