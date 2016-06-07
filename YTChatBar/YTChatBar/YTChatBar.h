//
//  YTChatBar.h
//  FinanceSecretary
//
//  Created by JDYX on 16/6/1.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

typedef NS_ENUM(NSUInteger, XMFunctionViewShowType){
   
    XMFunctionViewShowFace /**< 显示表情View */,
    XMFunctionViewShowImage /**< 显示录音view */,
    XMFunctionViewShowMore /**< 显示更多view */,
    XMFunctionViewShowKeyboard /**< 显示键盘 */,
};

@protocol XMChatBarDelegate;


@interface YTChatBar : UIView

@property (nonatomic, strong) HPGrowingTextView *textView;

@property (assign, nonatomic) CGFloat superViewHeight;

@property (weak, nonatomic) id<XMChatBarDelegate> delegate;

/**
 *  结束输入状态
 */
- (void)endInputing;

@end


/**
 *  XMChatBar代理事件,发送图片,地理位置,文字,语音信息等
 */
@protocol XMChatBarDelegate <NSObject>


@optional

/**
 *  chatBarFrame改变回调
 *
 *  @param chatBar
 */
- (void)chatBarFrameDidChange:(YTChatBar *)chatBar frame:(CGRect)frame;


/**
 *  发送图片信息,支持多张图片
 *
 *  @param chatBar
 *  @param pictures 需要发送的图片信息
 */
- (void)chatBar:(YTChatBar *)chatBar sendPictures:(NSArray *)pictures;



/**
 *  发送普通的文字信息,可能带有表情
 *
 *  @param chatBar
 *  @param message 需要发送的文字信息
 */
- (void)chatBar:(YTChatBar *)chatBar sendMessage:(NSString *)message;

@end




