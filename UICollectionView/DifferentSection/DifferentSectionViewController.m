//
//  DifferentSectionViewController.m
//  UICollectionView
//
//  Created by dym on 2017/10/12.
//  Copyright © 2017年 dym. All rights reserved.
//

#import "DifferentSectionViewController.h"
#import "DifferSectionFlowLayout.h"

@interface DifferentSectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DifferSectionFlowLayoutDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *heightArray;

@end

@implementation DifferentSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"UICollectionView";
     self.heightArray = [@[@"80",@"130",@"40",@"150",@"60",@"170",@"80",@"190",@"80",@"200"] mutableCopy];
    [self.view addSubview:self.collectionView];
   
}

#pragma mark --

- (CGSize)itemSizeForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if (indexPath.section == 2) {
        NSString *he = [self.heightArray objectAtIndex:indexPath.row];
        return CGSizeMake((width - 30) * 0.5, [he floatValue]);
    } else if (indexPath.section == 0) {
        return CGSizeMake((width - 20), 60);
    } else if(indexPath.section == 1){
        CGFloat sizeWidth = (width - 6 * 10) / 5;
        return CGSizeMake(sizeWidth, sizeWidth);
    }else{
        return CGSizeMake((width - 30) * 0.5, 60);

    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 2) {
        return self.heightArray.count;
    } else  if (section == 0) {
        return 5;
    } else  if (section == 1) {
        return 5;
    }{
        return 3;
    }
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (indexPath.section == 2) {
        cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
    } else if (indexPath.section == 0){
        cell.backgroundColor = [UIColor redColor];
    } else if (indexPath.section == 1){
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (UICollectionView*)collectionView{
    if (!_collectionView) {
        DifferSectionFlowLayout *flowLayout = [[DifferSectionFlowLayout alloc]init];
        flowLayout.selSection = 2;
        flowLayout.delegate = self;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
