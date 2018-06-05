//
//  SPToolBox.h
//  SynthesisPay
//
//  Created by 彭程 on 2018/1/9.
//  Copyright © 2018年 hyjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPToolBox : NSObject
//不同字号字体底部对齐
+ (NSAttributedString *)attributedText:(NSArray*)stringArray attributeAttay:(NSArray *)attributeAttay;
//设备机型
+(NSString *)iphoneType;
//符号+金额
+(NSAttributedString *)payMoneyFormatWithSymbolFont:(float)fontOne AmountFont:(float)fontTwo Symbol:(NSString *)stringOne Amount:(NSString *)stringTwo SymbolColor:(UIColor *)symbolColor AmountColor:(UIColor *)amountColor;
//金额+符号
+(NSAttributedString *)payMoneyFormatWithAmountFont:(float)fontOne SymbolFont:(float)fontTwo Amount:(NSString *)stringOne Symbol:(NSString *)stringTwo SymbolColor:(UIColor *)symbolColor AmountColor:(UIColor *)amountColor;
//nav高度
+(CGFloat)navHeight;

+(CGFloat)statueHeight;
@end
