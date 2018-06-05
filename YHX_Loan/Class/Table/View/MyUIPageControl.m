//
//  MyUIPageControl.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/30.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "MyUIPageControl.h"

@implementation MyUIPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.maskView .layer.backgroundColor=[UIColor clearColor].CGColor;
        self.userInteractionEnabled = NO;
        
    }
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
   

}
 
@end
