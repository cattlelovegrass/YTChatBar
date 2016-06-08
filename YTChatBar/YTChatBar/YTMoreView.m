//
//  YTMoreView.m
//  YTChatBar
//
//  Created by JDYX on 16/6/7.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import "YTMoreView.h"
#import "Masonry/Masonry.h"
#import "YTCollectionView.h"

@interface YTMoreView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) YTCollectionView *collectionView;



@end

@implementation YTMoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*2, 168);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.equalTo(@(168));
        make.width.equalTo(@(self.frame.size.width));
    }];
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self.pageControl addTarget:self action:@selector(clickDot:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).offset(1);
        make.width.equalTo(@(self.frame.size.width));
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    for(int i =0;i<2;i++) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[YTCollectionView alloc]initWithFrame:CGRectMake(0,0,0,0) collectionViewLayout:flow];
         _collectionView.backgroundColor = self.backgroundColor;
        [self.scrollView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.height.equalTo(@(168));
            make.width.equalTo(@(self.frame.size.width));
        }];
        
        if(self.pageControl.currentPage == 0 ) {
            _collectionView.itemArray = @[@"sharemore_location@2x.png",@"sharemore_pic@2x.png",@"sharemore_video@2x.png",@"sharemore_location@2x.png"];
            _collectionView.backgroundColor = [UIColor redColor];

        }
        
        _collectionView.collectViewCellSelectHandel = ^(NSIndexPath *indexPath,id model)  {
            
            NSLog(@"看看:%@",model);
        };
        
    }
    

}




- (void)clickDot:(UIPageControl *)control {
    
    NSInteger page =  control.currentPage;
    [self.scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * (page), _scrollView.contentOffset.y) animated: YES];
}

- (void)loadPageView:(NSInteger)page {

    if(page == 0 ) {
        _collectionView.itemArray = @[@"sharemore_location@2x.png",@"sharemore_pic@2x.png",@"sharemore_video@2x.png",@"sharemore_location@2x.png"];
        _collectionView.backgroundColor = [UIColor redColor];
        [_collectionView reloadData];
    }else if(page == 1) {
        _collectionView.itemArray = @[@"sharemore_location@2x.png"];
        [_collectionView reloadData];
        _collectionView.backgroundColor = [UIColor blueColor];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.pageControl.currentPage = page;
    [self loadPageView:page];
    NSLog(@"页码：%lu",page);
    
}





@end
