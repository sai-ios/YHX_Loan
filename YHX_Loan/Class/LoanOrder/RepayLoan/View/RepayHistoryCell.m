//
//  RepayHistoryCell.m
//  YHX_Loan
//  h 还款历史
//  Created by 张磊 on 2018/5/31.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "RepayHistoryCell.h"

@interface RepayHistoryCell()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UILabel *repayMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@end


@implementation RepayHistoryCell


-(void)setHistoryData:(RepayHistory*)data{
    _numberLabel.text = data.transSeq;
   
    _repayMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",data.mtdamt];
    _dateLabel.text = [DateUtils dateFormatter:data.repayDate beforePattren:@"yyyyMMddHHmmss" afterPattren:@"yyyy-MM-dd HH:mm:ss"];
    if(![[data.remark trim] isEqualToString:@""]){
        _remarkLabel.text = data.remark;
    }else{
        if([data.mtdmodel isEqualToString:@"TQ"]){
            _remarkLabel.text = @"部分还款";
        }else if([data.mtdmodel isEqualToString:@"NM"]){
            _remarkLabel.text = @"归还欠款";
        }else if([data.mtdmodel isEqualToString:@"FS"]){
            _remarkLabel.text = @"全部还款";
        }else{
            _remarkLabel.text = @"自动还款";
        }
    }
    // 状态
    if([data.repayStatus isEqualToString:@"0"]){
        _stateLabel.text = @"还款成功";
        _stateLabel.textColor = XZRGB(0xff666666);
    }else if([data.repayStatus isEqualToString:@"1"]){
        _stateLabel.text = @"还款失败";
        _stateLabel.textColor = XZRGB(0xffea0606);
        
    }else if([data.repayStatus isEqualToString:@"0"]){
        _stateLabel.text = @"还款成功";
        _stateLabel.textColor = XZRGB(0xff126AFF);
    }
    
    
}

+(instancetype)historyCellWithtableView:(UITableView *)table{
    static NSString *ID = @"history_cell";
    RepayHistoryCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RepayHistoryCell" owner:nil options:nil] firstObject];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
