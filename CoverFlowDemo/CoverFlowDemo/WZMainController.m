//
//  WZMainController.m
//  CoverFlowDemo
//
//  Created by songbiwen on 2017/1/6.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZMainController.h"
#import "WZCoverFlowLayout.h"
#import "WZCollectionViewCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define OrginalY 50
#define CollecionViewHeight 300
#define CollecionViewCellHeight 200
#define CollecionViewCellWidth 220
#define ItemCount 39

static NSString *cellIdentifier = @"Cell";
static CGFloat ImageViewTag = 100;

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
    
    WZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [cell.contentView viewWithTag:ImageViewTag];
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.tag = ImageViewTag;
        [cell.contentView addSubview:imageView];
    }
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd",indexPath.row % 3]];
    
    CAReplicatorLayer *layer = (CAReplicatorLayer *)cell.layer;
    layer.instanceCount = 2;
    
    // 先Y轴偏移
    CATransform3D transform =  CATransform3DMakeTranslation(0, cell.bounds.size.height, 0);
    
    // 在旋转
    transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
    
    // 设置复制层的形变
    layer.instanceTransform = transform;
    
    // 设置颜色通道偏移量，相等上一个一点偏移量，就是阴影效果
    layer.instanceRedOffset = -0.1;//红色偏移量
    layer.instanceBlueOffset = -0.1;//蓝色
    layer.instanceGreenOffset = -0.1;//绿色
    layer.instanceAlphaOffset = -0.7;//透明度偏移量
    return cell;
    
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        WZCoverFlowLayout *layout = [[WZCoverFlowLayout alloc] init];
        //设置cell的大小
        layout.itemSize = CGSizeMake(CollecionViewCellWidth, CollecionViewCellHeight);
        //设置cell滚动的方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, OrginalY, ScreenWidth, CollecionViewHeight) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        //注册cell
        [_collectionView registerClass:[WZCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


@end
