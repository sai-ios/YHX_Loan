//
//  RepayHistoryCell.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/31.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepayHistory.h"
@interface RepayHistoryCell : UITableViewCell

-(void)setHistoryData:(RepayHistory*)data;

+(instancetype)historyCellWithtableView:(UITableView *)table;

@end
