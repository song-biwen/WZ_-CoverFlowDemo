//
//  WZMainController.m
//  CoverFlowDemo
//
//  Created by songbiwen on 2017/1/6.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZMainController.h"
#import "WZCoverFlowLayout.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define OrginalY 50
#define CollecionViewHeight 150
#define ItemCount 39

static NSString *cellIdentifier = @"Cell";

@interface WZMainController ()
<UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation WZMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
    
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        WZCoverFlowLayout *layout = [[WZCoverFlowLayout alloc] init];
        //设置cell的大小
        layout.itemSize = CGSizeMake(100, 100);
        //设置cell滚动的方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, OrginalY, ScreenWidth, CollecionViewHeight) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        //注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
@end
