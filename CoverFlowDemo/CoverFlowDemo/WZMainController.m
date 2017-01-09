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
    
    UIImage *balloon = [UIImage imageNamed:[NSString stringWithFormat:@"%zd",indexPath.row % 3]];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [[cell.contentView layer] setBackgroundColor:[[UIColor blackColor] CGColor]];                 //改一下图片名就行了
    
    CALayer *topLayer = [[CALayer alloc] init];
    
    CGRect frame = cell.contentView.bounds;
    [topLayer setBounds:frame];
    [topLayer setPosition:CGPointMake(frame.size.width * 0.5,frame.size.height * 0.5)];
    
    [topLayer setContents:(id)[balloon CGImage]];
    
    [[cell.contentView layer] addSublayer:topLayer];
    
    CALayer *reflectionLayer = [[CALayer alloc] init];
    
    CGRect frame2 = cell.contentView.bounds;
    frame2.size.height += 80;
    [reflectionLayer setBounds:frame2];
    
    [reflectionLayer setPosition:CGPointMake(frame.size.width * 0.5,frame.size.height * 1.5)];
    
    [reflectionLayer setContents:[topLayer contents]];
    
    [reflectionLayer setValue:[NSNumber numberWithFloat:180.0] forKeyPath:@"transform.rotation.x"];
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    
    [gradientLayer setBounds:[reflectionLayer bounds]];
    
    [gradientLayer setPosition:CGPointMake([reflectionLayer bounds].size.width/2, [reflectionLayer bounds].size.height/2)];
    
    [gradientLayer setColors:[NSArray arrayWithObjects: (id)[[UIColor clearColor] CGColor],(id)[[UIColor blackColor] CGColor], nil]];
    
    [gradientLayer setStartPoint:CGPointMake(0.1,0.1)];
    
    [gradientLayer setEndPoint:CGPointMake(0.5,1.0)];
    
    [reflectionLayer setMask:gradientLayer];
//
    [[cell.contentView layer] addSublayer:reflectionLayer];
    
//    UIImageView *imageView = [cell.contentView viewWithTag:ImageViewTag];
//    if (imageView == nil) {
//        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
//        imageView.tag = ImageViewTag;
//        [cell.contentView addSubview:imageView];
//    }
//    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd",indexPath.row % 3]];
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
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
