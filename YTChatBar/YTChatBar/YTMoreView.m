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
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*2, 168);
//    self.scrollView.sho
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
//    self.scrollView.scrollEnabled = YES;
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
    
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor  = [UIColor redColor];
    [self.pageControl addTarget:self action:@selector(clickDot:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).offset(1);
        make.width.equalTo(@(self.frame.size.width));
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    YTCollectionView *collectionView = [[YTCollectionView alloc]initWithFrame:CGRectMake(0,0,0,0) collectionViewLayout:flow];
    collectionView.backgroundColor = self.backgroundColor;
    collectionView.itemArray = @[@"sharemore_location@2x.png",@"sharemore_pic@2x.png",@"sharemore_video@2x.png",@"sharemore_location@2x.png"];
    [self.scrollView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.equalTo(@(168));
        make.width.equalTo(@(self.frame.size.width));
    }];
    
    collectionView.collectViewCellSelectHandel = ^(NSIndexPath *indexPath,id model)  {
        NSLog(@"看看:%@",model);
    };
    
//    NSLog(@"子视图:%@",self.scrollView.subviews);
    
    
    
}




- (void)clickDot:(UIPageControl *)control {
    
    NSInteger page =  control.currentPage;
    NSLog(@"页码：%lu",(unsigned long)page);
    [self.scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * (page), _scrollView.contentOffset.y) animated: YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    
    NSUInteger page = scrollView.contentOffset.x/self.frame.size.width;
    NSLog(@"页码：%lu",(unsigned long)page);
    self.pageControl.currentPage = page;
}



@end
