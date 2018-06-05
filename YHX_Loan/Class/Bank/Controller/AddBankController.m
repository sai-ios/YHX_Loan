//
//  AddBankController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "AddBankController.h"
#import "DCBankController.h"
#import "BankUtils.h"
@interface AddBankController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameText;

@property (weak, nonatomic) IBOutlet UITextField *bankNumberfield;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@end

@implementation AddBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    self.nameText.text = [DataManage share].userModel.realName;
    
    _nextBtn.enabled = false;
    [self.bankNumberfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.bankNumberfield.delegate = self;
}

// 限制输入
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (_bankNumberfield.text.length < 14 ) {
        _nextBtn.enabled = false;
    }else{
        _nextBtn.enabled = true;
    }
    
    if(_bankNumberfield.text.length >= 24){
        _bankNumberfield.text = [textField.text substringToIndex:24];
    }
}

// 实现输入四个字符时空格
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL returnValue = YES;
    NSMutableString* newText = [NSMutableString stringWithCapacity:0];
    [newText appendString:textField.text];// 拿到原有text,根据下面判断可能给它添加" "(空格);
    
    NSString * noBlankStr = [textField.text stringByReplacingOccurrencesOfString:@" "withString:@""];
    NSInteger textLength = [noBlankStr length];
    if (string.length) {
        if (textLength < 25) {//这个25是控制实际字符串长度,比如银行卡号长度
            if (textLength > 0 && textLength %4 == 0) {
                newText = [NSMutableString stringWithString:[newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                [newText appendString:@" "];
                [newText appendString:string];
                textField.text = newText;
                returnValue = NO;//为什么return NO?因为textField.text = newText;text已经被我们替换好了,那么就不需要系统帮我们添加了,如果你ruturnYES的话,你会发现会多出一个字符串
            }else {
                [newText appendString:string];
            }
        }else { // 比25长的话 return NO这样输入就无效了
            returnValue =NO;
        }
    }else { // 如果输入为空,该怎么地怎么地
        [newText replaceCharactersInRange:range withString:string];
    }
    return returnValue;
}
- (IBAction)nextOnClick:(id)sender {
     NSString *noBlankStr = [_bankNumberfield.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"--->%@",noBlankStr);
    [self getBanktypeHttp:noBlankStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)getBanktypeHttp:(NSString*)bankNumber{
    
    _nextBtn.userInteractionEnabled = false;
    BankUtils *bankUtils = [BankUtils shareInstance];
    [bankUtils execute:bankNumber success:^(BankMode *bank) {
        _nextBtn.userInteractionEnabled = true;
        if ([bank.cardType isEqualToString:@"DC"]){
            // 储蓄卡实现跳转
            DCBankController *dcVc = [[DCBankController alloc]init];
            dcVc.bank = bank;
            [self.navigationController pushViewController:dcVc animated:YES];
        }else{
            // 暂时不支持信用卡绑定
            [self showAlert:@"当前只支持绑定储蓄卡，请重新更换卡片"];
        }
    
    } failed:^(NSString *message) {
        _nextBtn.userInteractionEnabled = true;
        [self showAlert:message];
    }];
   
}

- (void)showAlert:(NSString*)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@">>> Click the yes button.");
    }];
    [alertController addAction:yesAction];
   
    //show alert controller
    [self presentViewController:alertController animated:YES completion:nil];

}

@end
