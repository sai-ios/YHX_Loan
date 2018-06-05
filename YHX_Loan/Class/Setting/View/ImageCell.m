//
//  ImageCell.m
//  ZLPhotoBrowser
//
//  Created by long on 2017/6/20.
//  Copyright © 2017年 long. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.frame = self.contentView.bounds;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        
        self.playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-15, self.bounds.size.height/2-15, 30, 30)];
        self.playImageView.image = [UIImage imageNamed:@"playVideo"];
        [self.contentView addSubview:self.playImageView];
    }
    return self;
}

+ (instancetype) imageCellWithView:(UICollectionView *)collectionView path:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell_image";
    
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BankCardCell" owner:nil options:nil]firstObject];
        
    }
    
    return cell;
}

@end
