//
//  ImageCollectionViewCell.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/6/1.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
+ (instancetype) imageCellWithView:(UICollectionView *)collectionView path:(NSIndexPath *)indexPath;
-(void)setImage:(UIImage *)image;
@end
