//
//  NSWebViewController.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/29.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSWebViewController : SNBaseViewController
// url
@property(nonatomic, strong) NSString *url;
// date --json string
@property(nonatomic, strong) NSString *jsonData;

@end
