//
//  BankCardCell.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/23.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface BankCardCell : UITableViewCell

- (void)setCellBankInfo:(BankCard *)bankDict;

+ (instancetype) bankCellWithTableView:(UITableView *)tableView;

+(UIImage *)bankIconWithName:(NSString*)bankName;
@end
