//
//  ChooseLocationController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/22.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "ChooseLocationController.h"
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"
#import <objc/runtime.h>

#define DeviceHeight [[UIScreen mainScreen] bounds].size.height
#define DeviceWidth [[UIScreen mainScreen] bounds].size.width

@interface ChooseLocationController ()<NSURLSessionDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) ChooseLocationView *chooseLocationView;
@property (nonatomic,strong) UIView  *cover;

@end

@implementation ChooseLocationController

/**
 *设置位置宽高
 */

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [self.view addSubview:self.cover];
    // 打开地址选择器
    [self openChooseView];
    
}
-(void)openChooseView{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform =CGAffineTransformMakeScale(1, 1);
    }];
    self.cover.hidden = !self.cover.hidden;
    self.chooseLocationView.hidden = self.cover.hidden;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma mark   懒加载 cover ChooseLocationView

- (ChooseLocationView *)chooseLocationView{
    
    if (!_chooseLocationView) {
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 350, [UIScreen mainScreen].bounds.size.width, 350)];

    }
    return _chooseLocationView;
}

- (UIView *)cover{
    
    if (!_cover) {
        _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_cover addSubview:self.chooseLocationView];
        __weak typeof (self) weakSelf = self;
        _chooseLocationView.chooseFinish = ^{
            [UIView animateWithDuration:0.25 animations:^{
            weakSelf.block(weakSelf.chooseLocationView.address,weakSelf.chooseLocationView.selectAreaCode);
                NSLog(@"%@ %@",weakSelf.chooseLocationView.address,weakSelf.chooseLocationView.selectAreaCode );
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                weakSelf.view.transform = CGAffineTransformIdentity;
                weakSelf.cover.hidden = YES;
            }];
        };
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)];
        [_cover addGestureRecognizer:tap];
        tap.delegate = self;
        _cover.hidden = YES;
    }
    return _cover;
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
