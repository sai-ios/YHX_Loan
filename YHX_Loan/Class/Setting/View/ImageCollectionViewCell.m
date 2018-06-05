//
//  ImageCollectionViewCell.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/6/1.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
}

+ (instancetype) imageCellWithView:(UICollectionView *)collectionView path:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell_image";
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageCollectionViewCell" owner:nil options:nil]firstObject];
        
    }
    
    return cell;
}

-(void)setImage:(UIImage *)image{
    [self.imageView setImage:image];
}

@end
