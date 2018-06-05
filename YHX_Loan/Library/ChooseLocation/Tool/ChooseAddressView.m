//
//  ChooseAddressView.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/22.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "ChooseAddressView.h"
@interface ChooseAddressView ()<NSURLSessionDelegate,UIGestureRecognizerDelegate>

@end
static  ChooseAddressView *cover = nil;
@implementation ChooseAddressView

+(instancetype)addressInit{
    if (!self) {
         cover  = [[ChooseAddressView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [cover addSubview:cover.chooseLocationViews];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)];
        [cover addGestureRecognizer:tap];
        tap.delegate = cover;
        cover.hidden = YES;
    }
    return cover;
 
}

#pragma mark - Singleton

-(void)show:(void (^ __nullable)(NSString* address))handler{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform =CGAffineTransformMakeScale(1, 1);
    }];
    self.hidden = !self.hidden;
    self.chooseLocationView.hidden = self.hidden;
    __weak typeof (self) weakSelf = self;
    _chooseLocationView.chooseFinish = ^{
        [UIView animateWithDuration:0.25 animations:^{
           
            weakSelf.transform = CGAffineTransformIdentity;
            weakSelf.hidden = YES;
             handler(weakSelf.chooseLocationView.address);
        }];
    };
}


- (ChooseLocationView *)chooseLocationViews{
    
    if (!_chooseLocationView) {
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 350, [UIScreen mainScreen].bounds.size.width, 350)];     
    }
    return _chooseLocationView;
}


- (void)tapCover:(UITapGestureRecognizer *)tap{
    
    if (_chooseLocationView.chooseFinish) {
        _chooseLocationView.chooseFinish();
    }
}
# pragma mark 数据源方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(_chooseLocationView.frame, point)){
        return NO;
    }
    return YES;
}


@end
