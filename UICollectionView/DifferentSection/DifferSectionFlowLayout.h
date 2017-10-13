//
//  DifferSectionFlowLayout.h
//  UICollectionView
//
//  Created by dym on 2017/10/12.
//  Copyright © 2017年 dym. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DifferSectionFlowLayoutDelegate <NSObject>
- (CGSize)itemSizeForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath*)indexPath;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView insetForSectionAtIndex:(NSInteger)section;
@end

@interface DifferSectionFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<DifferSectionFlowLayoutDelegate> delegate;
@property (nonatomic,assign) NSInteger selSection;
@end
