//
//  SPToolBox.m
//  SynthesisPay
//
//  Created by 彭程 on 2018/1/9.
//  Copyright © 2018年 hyjf. All rights reserved.
//

#import "SPToolBox.h"
#import <sys/utsname.h>

@implementation SPToolBox

+ (NSAttributedString *)attributedText:(NSArray*)stringArray attributeAttay:(NSArray *)attributeAttay{
    NSString * string = [stringArray componentsJoinedByString:@""];
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:string];
    for(NSInteger i = 0; i < stringArray.count; i++){
        [result setAttributes:attributeAttay[i] range:[string rangeOfString:stringArray[i]]];
    }
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

+(NSString *)iphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone5,1"])
        return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])
        return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])
        return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])
        return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])
        return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])
        return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])
        return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])
        return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])
        return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])
        return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])
        return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])
        return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])
        return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"])
        return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"])
        return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"])
        return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"])
        return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"])
        return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"])
        return@"iPhone X";
    
    if([platform isEqualToString:@"i386"])
        return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])
        return@"iPhone Simulator";
    
    return platform;
    
}

//符号+金额
+ (NSAttributedString *)payMoneyFormatWithSymbolFont:(float)fontOne AmountFont:(float)fontTwo Symbol:(NSString *)stringOne Amount:(NSString *)stringTwo SymbolColor:(UIColor *)symbolColor AmountColor:(UIColor *)amountColor{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle =kCFNumberFormatterCurrencyStyle;
    NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithDouble:stringTwo.doubleValue]];
    NSString *money = [newAmount stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    NSDictionary *attributesExtra = @{NSFontAttributeName:[UIFont systemFontOfSize:fontOne],//字号15
                                      NSForegroundColorAttributeName:symbolColor};
    NSDictionary *attributesPrice = @{NSFontAttributeName:[UIFont systemFontOfSize:fontTwo],//字号21
                                      NSForegroundColorAttributeName:amountColor};
    NSAttributedString *attributedString = [SPToolBox attributedText:@[stringOne,money]
                                                      attributeAttay:@[attributesExtra,attributesPrice,attributesExtra]];
    return attributedString;
}
//金额+符号
+(NSAttributedString *)payMoneyFormatWithAmountFont:(float)fontOne SymbolFont:(float)fontTwo Amount:(NSString *)stringOne Symbol:(NSString *)stringTwo SymbolColor:(UIColor *)symbolColor AmountColor:(UIColor *)amountColor{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle =kCFNumberFormatterCurrencyStyle;
    NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithDouble:stringOne.doubleValue]];
    NSString *money = [newAmount stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    NSDictionary *attributesExtra = @{NSFontAttributeName:[UIFont systemFontOfSize:fontOne],//字号15
                                      NSForegroundColorAttributeName:amountColor};
    NSDictionary *attributesPrice = @{NSFontAttributeName:[UIFont systemFontOfSize:fontTwo],//字号21
                                      NSForegroundColorAttributeName:symbolColor};
    NSAttributedString *attributedString = [SPToolBox attributedText:@[money,stringTwo]
                                                      attributeAttay:@[attributesExtra,attributesPrice,attributesExtra]];
    return attributedString;
}

//导航条高度切换（iPhoneX）
+(CGFloat)navHeight{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone10,3"]){
        return 89;
    }
    if([platform isEqualToString:@"iPhone10,6"]){
        return 89;
    }
//    if([platform isEqualToString:@"x86_64"]){
//        return 89;
//    }
    return 64;
}

//状态条高度切换（iPhoneX）
+(CGFloat)statueHeight{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone10,3"]){
        return 50;
    }else if([platform isEqualToString:@"iPhone10,6"]){
        return 50;
    }
    //    if([platform isEqualToString:@"x86_64"]){
    //        return 89;
    //    }
    return 20;
}


@end
