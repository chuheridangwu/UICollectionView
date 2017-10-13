//
//  DifferSectionFlowLayout.m
//  UICollectionView
//
//  Created by dym on 2017/10/12.
//  Copyright © 2017年 dym. All rights reserved.
//

#import "DifferSectionFlowLayout.h"

@interface DifferSectionFlowLayout()
@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, assign) CGFloat contentHeight;
@end

@implementation DifferSectionFlowLayout

//准备方法被自动调用，以保证layout实例的正确
- (void)prepareLayout {
    [super prepareLayout];
    NSInteger section = [self.collectionView numberOfSections];
    for (int j = 0; j < section; j++) {
        for (int i = 0; i < [self.collectionView numberOfItemsInSection:j]; i++) {
            /*
             UICollectionViewLayoutAttributes的实例中包含了诸如边框，中心点，大小，形状，透明度，层次关系和是否隐藏等信息。
             1.一个cell对应一个UICollectionViewLayoutAttributes对象
             2.UICollectionViewLayoutAttributes对象决定了cell的摆设位置（frame）
             */
            UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
            [self.attributes addObject:att];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributes;
}

- (CGSize)collectionViewContentSize {
    CGFloat width = 0;
    return CGSizeMake(width, self.contentHeight + 10);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    UIEdgeInsets edge =  [self.delegate collectionView:self.collectionView insetForSectionAtIndex:indexPath.section];
    
    CGFloat edgeX = edge.left;
    CGFloat edgeY = edge.top;
    CGSize itemSize = [self.delegate itemSizeForCollectionView:self.collectionView indexPath:indexPath];
    
    CGFloat X = 0;
    CGFloat Y = 0;
    
    CGFloat maxL = [self.dic[@"maxL"] floatValue];
    CGFloat maxR = [self.dic[@"maxR"] floatValue];
    
    if (indexPath.section == self.selSection) {  //如果是瀑布流
        if (maxL <= maxR) {
            X = edgeX;
            Y = maxL + edgeY;
            if (indexPath.row == 0) {
                Y = self.contentHeight + edgeY;
                self.dic[@"maxR"] = @(self.contentHeight);
            }
            self.dic[@"maxL"] = @(Y + itemSize.height);
        } else {  //左边高度大于右边
            X = edgeX + itemSize.width + edgeX;
            Y = maxR+ edgeY;
            self.dic[@"maxR"] = @(Y + itemSize.height);
        }
        self.contentHeight = Y + itemSize.height;
    } else {
        
        NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
        if (itemSize.width == ((screenW - edgeX * (count + 1)) / count)) { // 一行多个item
            X = edgeX + (itemSize.width + edgeX) * indexPath.row ;
            Y = edgeY + maxL;
            if (indexPath.row == 0) {
                X = edgeX;
            }
            if (indexPath.row == count - 1) {
                self.contentHeight = Y + itemSize.height ;
                self.dic[@"maxL"] = @(Y + itemSize.height);
                self.dic[@"maxR"] = @(Y + itemSize.height);
            }
        }else{
            Y = ((maxL >= maxR)?maxL:maxR ) + edgeY;
            
            if (indexPath.row % 2 == 0) {
                X = edgeX;
                self.dic[@"maxL"] = @(Y + itemSize.height);
                self.dic[@"maxR"] = @(Y + itemSize.height);
            } else {
                
                X = edgeX + itemSize.width + edgeX;
                
                if (X >= screenW) {
                    X = edgeX;
                    Y = self.contentHeight + edgeY;
                    self.dic[@"maxL"] = @(Y + itemSize.height);
                    self.dic[@"maxR"] = @(Y + itemSize.height);
                } else { //一行只有一个item
                    Y = Y - itemSize.height - edgeY;
                }
            }
            self.contentHeight = Y + itemSize.height;
        }
    }
    
     // 每个item的坐标
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    att.frame = CGRectMake(X, Y, itemSize.width, itemSize.height);
    return att;
}


- (NSMutableDictionary *)dic {
    if (!_dic) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (NSMutableArray *)attributes {
    
    if (!_attributes) {
        self.attributes = [NSMutableArray array];
    }
    return _attributes;
}


@end
