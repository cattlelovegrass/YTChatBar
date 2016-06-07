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
//        self.backgroundColor = [UIColor redColor];
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*2, 168);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.equalTo(@(168));
        make.width.equalTo(@(self.frame.size.width));
    }];
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPage = 0;
//    self.pageControl.backgroundColor = [UIColor yellowColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.pageControl addTarget:self action:@selector(clickDot:) forControlEvents:UIControlEventValueChanged];
    self.pageControl.pageIndicatorTintColor  = [UIColor redColor];
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).offset(1);
        make.width.equalTo(@(self.frame.size.width));
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    YTCollectionView *collectionView = [[YTCollectionView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,_scrollView.frame.size.height) collectionViewLayout:flow];
    [self.scrollView addSubview:collectionView];
    collectionView.collectViewCellSelectHandel = ^(NSIndexPath *indexPath,id model)  {
        NSLog(@"%@",model);
    };
    
    NSLog(@"");
    
    
    
}



- (void)clickDot:(UIPageControl *)control {
    
    NSInteger page =  control.currentPage;
    [self.scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * (page), _scrollView.contentOffset.y) animated: YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    NSUInteger page = scrollView.contentOffset.x/self.frame.size.width;
    NSLog(@"页码：%lu",(unsigned long)page);
    self.pageControl.currentPage = page;
    if(page == 0) {
        self.scrollView.backgroundColor = [UIColor redColor];
    }else if(page == 1) {
        self.scrollView.backgroundColor = [UIColor yellowColor];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    NSUInteger page = scrollView.contentOffset.x/self.frame.size.width;
//    NSLog(@"页码：%lu",(unsigned long)page);
//    if(page == 1)
//    self.pageControl.currentPage = page;
//}

@end
