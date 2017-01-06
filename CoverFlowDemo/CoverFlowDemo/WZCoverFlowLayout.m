//
//  WZCoverFlowLayout.m
//  CoverFlowDemo
//
//  Created by songbiwen on 2017/1/6.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZCoverFlowLayout.h"

@implementation WZCoverFlowLayout
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //获取cell对应的Attributes对象
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    //计算整体的中心点的位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    //修改Attributes对象
    for (UICollectionViewLayoutAttributes *attr in arr) {
        //计算每个cell与中心点的距离
        CGFloat distance = ABS(attr.center.x - centerX);
        CGFloat scale = 1/ (1 + distance * 0.005) ;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    //计算整体的中心点的位置
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    CGRect frame = self.collectionView.frame;
    frame.origin.x = proposedContentOffset.x;
    frame.origin.y = proposedContentOffset.y;
    
    //获取当时可视区域的cell的Attributes对象
    NSArray *attr_arr = [self layoutAttributesForElementsInRect:frame];
    
    //设置距离中心点最近的为第一个
    int minIndex = 0;
    UICollectionViewLayoutAttributes *min_attr = attr_arr[minIndex];
    
    for (int i = 1; i < attr_arr.count; i ++) {
        UICollectionViewLayoutAttributes *attr = attr_arr[i];
        //计算最近的cell与中心点的距离
        CGFloat minDistance = ABS(min_attr.center.x - centerX);
        
        //计算当前的cell与中心点的距离
        CGFloat currentDiatance = ABS(attr.center.x - centerX);
        
        if (currentDiatance < minDistance) {
            minIndex = i;
            min_attr = attr;
        }
    }
    
    CGFloat minDistance = min_attr.center.x - centerX;
    
    return CGPointMake(proposedContentOffset.x + minDistance, proposedContentOffset.y);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end
