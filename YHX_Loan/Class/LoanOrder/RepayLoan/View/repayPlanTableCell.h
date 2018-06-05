//
//  repayPlanTableCell.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/9.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYRepayPlan.h"
@interface repayPlanTableCell : UITableViewCell

- (void)setRepayPlanData:(XYRepayPlan *)planDict;

- (void)setcellForRowAtIndexPath:(NSIndexPath *)indexPath table:(UITableView *)table;

+ (instancetype) repayCellWithTableView:(UITableView *)table;

@end
