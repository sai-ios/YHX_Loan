//
//  LoanListTableViewCell.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanApplyBasicInfo.h"
@interface LoanListTableViewCell : UITableViewCell

- (void)setCellLoanInfo:(LoanApplyBasicInfo*)loanInfo;

+ (instancetype) loanListCellWithTableView:(UITableView *)tableView;

@end
