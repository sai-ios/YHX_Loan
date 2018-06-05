//
//  BankCardCell.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/23.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "BankCardCell.h"

@interface BankCardCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bankIcon;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankType;
@property (weak, nonatomic) IBOutlet UILabel *bankNumber;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *iconBg;
@end

@implementation BankCardCell

- (void)setCellBankInfo:(BankCard*)bankcard{
    [self setBNumber:bankcard.bankCardNumber];
    [self setBName:bankcard.bankName];
    [self setBType:bankcard.cardType];
}

+ (instancetype) bankCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell_bank";
   
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BankCardCell" owner:nil options:nil]firstObject];
        
    }
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setBIconImage:(UIImage *)icon{
    [self.bankIcon setImage:icon];
}

- (void)setBName:(NSString *)bankName{
    self.bankName.text = bankName;
    // 根据用户名设置背景图和icon
    if([bankName containsString:@"工商"]||[bankName containsString:@"招商"]|| [bankName containsString:@"人民"]||
       [bankName containsString:@"中信"]|| [bankName containsString:@"中国银行"])
    {
        UIImage *image = [UIImage imageNamed:@"bank_manage_pic_color2"];
        self.bgView.layer.contents = (id) image.CGImage;
    }else if([bankName containsString:@"建设"]||[bankName containsString:@"广发"]|| [bankName containsString:@"交通"]||
             [bankName containsString:@"兴业"]){
        UIImage *image = [UIImage imageNamed:@"bank_manage_pic_color1"];
        self.bgView.layer.contents = (id) image.CGImage;
        
    }else {
        UIImage *image = [UIImage imageNamed:@"bank_manage_pic_color0"];
        self.bgView.layer.contents = (id) image.CGImage;
    }
    
    self.bgView.layer.backgroundColor = [UIColor clearColor].CGColor;
    //    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    
    UIImage *bankIcon = [BankCardCell bankIconWithName:bankName];
    if (!bankIcon) { // 为空时
        self.iconBg.layer.backgroundColor=[UIColor clearColor].CGColor;
        [self.bankIcon setImage:[UIImage imageNamed:@""]];
    }else{
        [self setBIconImage:bankIcon];
    }
 
}

- (void)setBType:(NSString *)type{
    self.bankType.text = [type isEqualToString:@"DC"]?@"储蓄卡":@"信用卡";
}

- (void)setBNumber:(NSString *)number{
    NSString *endNumber = [number substringFromIndex:number.length-4];
    self.bankNumber.text = [@"**** **** " stringByAppendingString:endNumber];
}

+(UIImage *)bankIconWithName:(NSString*)bankName{
    
    if([bankName containsString:@"工商"])
      return [UIImage imageNamed:@"logo_banck_gongshang.png"];
    else if([bankName containsString:@"招商"])
      return [UIImage imageNamed:@"logo_banck_zhaoshang.png"];
    else if( [bankName containsString:@"人民"])
      return [UIImage imageNamed:@"logo_banck_zgrenmin"];
    else if(  [bankName containsString:@"中信"])
      return [UIImage imageNamed:@"logo_banck_zhongxin"];
    else if( [bankName containsString:@"中国银行"])
      return [UIImage imageNamed:@"logo_bank_of_china"];
    else if([bankName containsString:@"建设"])
      return [UIImage imageNamed:@"logo_banck_jianhang"];
    else if([bankName containsString:@"广发"])
      return [UIImage imageNamed:@"logo_banck_pufa"];
    else if( [bankName containsString:@"交通"])
      return [UIImage imageNamed:@"logo_bank_jiaotong"];
    else if([bankName containsString:@"兴业"])
      return [UIImage imageNamed:@"logo_banck_xingye"];
    else if([bankName containsString:@"农业"])
      return [UIImage imageNamed:@"logo_bank_nongye"];
    else if([bankName containsString:@"邮政"])
      return [UIImage imageNamed:@"logo_banck_youzhen"];
    else if( [bankName containsString:@"民生"])
      return [UIImage imageNamed:@"logo_banck_minsheng"];
    else if([bankName containsString:@"农村信用社"])
      return [UIImage imageNamed:@"logo_banck_ncxinyongshe"];
    
    return [UIImage imageNamed:@""];
}



@end
