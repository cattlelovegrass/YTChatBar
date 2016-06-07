//
//  YTCollectionView.h
//  YTChatBar
//
//  Created by JDYX on 16/6/7.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTCollectionView : UICollectionView


@property (nonatomic, strong) NSArray *itemArray;

@property(nonatomic,copy)void (^collectViewCellSelectHandel)(NSIndexPath *indexPath,id model);

@end
