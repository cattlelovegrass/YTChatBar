//
//  YTCollectionView.m
//  YTChatBar
//
//  Created by JDYX on 16/6/7.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import "YTCollectionView.h"
#import "YTCollectionCell.h"

@interface YTCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) 

@end

@implementation YTCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[YTCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YTCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *name = _itemArray[indexPath.row];
    cell.imageButton.image = [UIImage imageNamed:name];
    
    if(!cell) {
        NSLog(@"无法创建collection错误");
    }
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.frame.size.width-3)/4,self.frame.size.height/2+5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = _itemArray[indexPath.row];
    
    if(self.collectViewCellSelectHandel) {
        self.collectViewCellSelectHandel(indexPath,name);
    }
}

@end
