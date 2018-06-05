//
//  STools.m
//  IOS-基础学习
//
//  Created by 张磊 on 2018/3/12.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "STools.h"
@interface STools()<NSStreamDelegate>

@property(nonatomic, strong)NSInputStream *inputStream;
@property(nonatomic, strong)NSOutputStream *outStream;

@end

@implementation STools

+(BOOL)compile:(NSString *)st pattern:(NSString *)pat{
//    NSString *pattern = @"^1[3|4|5|7|8][0-9]{9}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pat];
    return [pred evaluateWithObject:st];
}

 //@"[a-zA-Z.-]"
+(NSString *)replaceAll:(NSString *)string regex:(NSString *)regex replacecement:(NSString *)replacement{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:NULL];
    
    NSString *result = [regular stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:replacement];
    return result;
}

+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return data;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return data;
}

+ (NSString *)dictJsonString:(NSDictionary *)dic{
    NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)hidetel:(NSString *)tel{
    NSString *telHead = [tel substringToIndex:3];
    NSString *telend = [tel substringFromIndex:tel.length-4];
    return [telHead stringByAppendingString:[NSString stringWithFormat:@" *** %@",telend]];
}

@end
