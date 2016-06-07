//
//  YTSlideImageView.h
//  YTChatBar
//
//  Created by JDYX on 16/6/7.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sendImage)(NSArray *imageArray);

@interface YTSlideImageView : UIView

@property (nonatomic,strong)sendImage sendImageBlock;


@end
