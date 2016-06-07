//
//  YTChatBar.m
//  FinanceSecretary
//
//  Created by JDYX on 16/6/1.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import "YTChatBar.h"
#import "Masonry/Masonry.h"
#import "XMChatFaceView.h"
#import "YTSlideImageView.h"

#define kMaxHeight 60.0f
#define kMinHeight 45.0f
#define kFunctionViewHeight 210.0f


@interface YTChatBar()<HPGrowingTextViewDelegate,XMChatFaceViewDelegate>

@property (nonatomic, strong) UIButton *emticonButton;
@property (nonatomic, strong) UIButton *imageButton;
@property (strong, nonatomic) XMChatFaceView *faceView;
@property (assign, nonatomic, readonly) CGFloat bottomHeight;
@property (assign, nonatomic) CGRect keyboardFrame;
@property (strong, nonatomic) YTSlideImageView *moreView;
@property (nonatomic) CGRect r;

@end

@implementation YTChatBar

- (YTSlideImageView *)moreView{
    if (!_moreView) {
        _moreView = [[YTSlideImageView alloc]initWithFrame:CGRectMake(0, self.superViewHeight, self.frame.size.width, kFunctionViewHeight)];
        _moreView.backgroundColor = self.backgroundColor;
    }
    return _moreView;
}

- (XMChatFaceView *)faceView{
    if (!_faceView) {
        _faceView = [[XMChatFaceView alloc] initWithFrame:CGRectMake(0, self.superViewHeight , self.frame.size.width, kFunctionViewHeight)];
        _faceView.delegate = self;
        _faceView.backgroundColor = self.backgroundColor;
    }
    return _faceView;
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self loadNotice];
        [self loadBarView];
    }
    return self;
}

- (void)endInputing {
}

- (void)loadNotice {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)loadBarView {

    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageButton.tag = XMFunctionViewShowImage;
    [self.imageButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageButton setImage:[UIImage imageNamed:@"picN.png"] forState:UIControlStateNormal];
    [self.imageButton setImage:[UIImage imageNamed:@"picS.png"] forState:UIControlStateHighlighted];
    [self addSubview:self.imageButton];
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-39);
        make.left.equalTo(self.mas_left).offset(12);
        make.width.equalTo(@(32));
        make.height.equalTo(@(32));
    }];
    
    self.emticonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.emticonButton.tag = XMFunctionViewShowFace;
    [self.emticonButton setImage:[UIImage imageNamed:@"emNot.png"] forState:UIControlStateNormal];
    [self.emticonButton setImage:[UIImage imageNamed:@"emo.png"] forState:UIControlStateHighlighted];
    [self.emticonButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.emticonButton];
    [self.emticonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-39);
        make.left.equalTo(self.imageButton.mas_right).offset(12);
        make.width.equalTo(@(32));
        make.height.equalTo(@(32));
    }];
    
    self.textView = [[HPGrowingTextView alloc] init];
    self.textView.isScrollable = YES;
    self.textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.textView.minNumberOfLines = 1;
    self.textView.maxNumberOfLines = 7;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.cornerRadius = 6;
    self.textView.clipsToBounds = YES;
    self.textView.returnKeyType =  UIReturnKeySend;
    self.textView.font = [UIFont systemFontOfSize:15.f];
    self.textView.delegate = self;
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-78);
        make.left.equalTo(self.mas_left).offset(8);
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.equalTo(@(33));
    }];
    
}

- (void)buttonAction:(UIButton *)button {
    XMFunctionViewShowType showType = button.tag;
    
    if(button == self.emticonButton) {
        [self.emticonButton setSelected:!self.emticonButton.selected];
        [self.imageButton setSelected:NO];
    }else if(button == self.imageButton) {
        [self.imageButton setSelected:!self.imageButton.selected];
        [self.emticonButton setSelected:NO];
    }
    
    if(!button.selected) {
        NSLog(@"222");
        showType = XMFunctionViewShowKeyboard;
        [self.textView becomeFirstResponder];
    }

    [self showViewWithType:showType];
}

- (void)showViewWithType:(XMFunctionViewShowType)showType {
    [self showImage:showType == XMFunctionViewShowImage && self.imageButton.selected];
    [self showEmotionFace:showType == XMFunctionViewShowFace && self.emticonButton.selected];
    NSLog(@"1-%d:2-%d",self.imageButton.selected?YES:NO,self.emticonButton.selected?YES:NO);
    
    switch (showType) {
            
        case XMFunctionViewShowImage:
            
//            [self.textView resignFirstResponder];
//            [self.textView resignFirstResponder];
            
            
            [self setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - self.textView.frame.size.height - 10, self.frame.size.width, self.textView.frame.size.height + 10)animated:NO];

            break;
        case XMFunctionViewShowFace:
//            [self.textView resignFirstResponder];
            
            [self setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - self.textView.frame.size.height - 10, self.frame.size.width, self.textView.frame.size.height + 10) animated:NO];
            
            [self growingTextViewDidChange:self.textView];
            break;
        case XMFunctionViewShowKeyboard:
            [self.textView becomeFirstResponder];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
            break;
        default:
            break;
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)sendTextMessage:(NSString *)text{
    if (!text || text.length == 0) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendMessage:)]) {
        [self.delegate chatBar:self sendMessage:text];
    }
    self.textView.text = @"";
    [self setFrame:CGRectMake(0, self.superViewHeight - self.bottomHeight - kMinHeight, self.frame.size.width, kMinHeight) animated:NO];
    [self showViewWithType:XMFunctionViewShowKeyboard];
    
}


//
- (BOOL)growingTextView:(HPGrowingTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [self sendTextMessage:textView.text];
        return NO;
    }else if (text.length == 0){
        //判断删除的文字是否符合表情文字规则
        NSString *deleteText = [textView.text substringWithRange:range];
        if ([deleteText isEqualToString:@"]"]) {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            NSString *subText;
            while (YES) {
                if (location == 0) {
                    return YES;
                }
                location -- ;
                length ++ ;
                subText = [textView.text substringWithRange:NSMakeRange(location, length)];
                if (([subText hasPrefix:@"["] && [subText hasSuffix:@"]"])) {
                    break;
                }
            }
            textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
            [textView setSelectedRange:NSMakeRange(location, 0)];
//            [self textViewDidChange:self.textView];
            return NO;
        }
    }
    return YES;
}
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView {
    return YES;
}


- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView {
    
    [self showEmotionFace:NO];
    [self showImage:NO];
    return YES;
}


- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView {
//    CGRect textViewFrame = self.textView.frame;
//    
//    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
//    
//    CGFloat offset = 10;
////    textView.scrollEnabled = (textSize.height + 0.1 > kMaxHeight-offset);
//    textViewFrame.size.height = MAX(34, MIN(kMaxHeight, textSize.height));
//    
//    CGRect addBarFrame = self.frame;
//    addBarFrame.size.height = textViewFrame.size.height+offset;
//    addBarFrame.origin.y = self.superViewHeight - self.bottomHeight - addBarFrame.size.height;
//    [self setFrame:addBarFrame animated:NO];


}



- (void)faceViewSendFace:(NSString *)faceName{
    if ([faceName isEqualToString:@"[删除]"]) {
        [self growingTextView:self.textView shouldChangeTextInRange:NSMakeRange(self.textView.text.length - 1, 1)  replacementText:@""];
    }else if ([faceName isEqualToString:@"发送"]){
        NSString *text = self.textView.text;
        if (!text || text.length == 0) {
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendMessage:)]) {
            
            [self.delegate chatBar:self sendMessage:text];
        }
        self.textView.text = @"";
        [self setFrame:CGRectMake(0, self.superViewHeight - self.bottomHeight - kMinHeight, self.frame.size.width, kMinHeight) animated:NO];
        [self showViewWithType:XMFunctionViewShowFace];
    }else{
        self.textView.text = [self.textView.text stringByAppendingString:faceName];
    }

}


- (CGFloat)bottomHeight{
    
    if (self.faceView.superview || self.moreView.superview) {
        return MAX(self.keyboardFrame.size.height, MAX(self.faceView.frame.size.height, self.moreView.frame.size.height));
    }else{
        return MAX(self.keyboardFrame.size.height, CGFLOAT_MIN);
    }
}


-(void)keyboardWillShow:(NSNotification *)note {
    // get keyboard size and loctaion
    self.keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.superview convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.frame;
//    NSLog(@"高度多少222:%f",containerFrame.origin.y);
    containerFrame.origin.y = self.superview.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    NSLog(@"高度多少:%f",containerFrame.origin.y);
    // set views with new info
    self.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    self.keyboardFrame = CGRectZero;
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.frame;
    containerFrame.origin.y = self.superview.bounds.size.height - containerFrame.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}


- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);

    self.r = self.textView.frame;
    _r.size.height -= diff;
    _r.origin.y += diff;
    self.textView.frame = self.r;
    
//    CGRect r = self.textView.frame;
//    r.size.height -= diff;
//    r.origin.y += diff;
//    self.textView.frame = r;
    
}

- (void)setFrame:(CGRect)frame animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:.3 animations:^{
            [self setFrame:frame];
        }];
    }else{
        [self setFrame:frame];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBarFrameDidChange:frame:)]) {
        [self.delegate chatBarFrameDidChange:self frame:frame];
    }
}

/**
 *  通知代理发送图片信息
 *
 *  @param image 发送的图片
 */
- (void)sendImageMessage:(UIImage *)image{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendPictures:)]) {
        [self.delegate chatBar:self sendPictures:@[image]];
    }
}

- (void)showEmotionFace:(BOOL)isShow {

    if(isShow) {
        NSLog(@"表情显示");
        
        [self.emticonButton setImage:[UIImage imageNamed:@"emo.png"] forState:UIControlStateNormal];
        [self.superview addSubview:self.faceView];
        [UIView animateWithDuration:.3 animations:^{
            [self.faceView setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight, self.frame.size.width, kFunctionViewHeight)];
        } completion:nil];
        
    }else {
        NSLog(@"表情不显示");
    
        [self.emticonButton setImage:[UIImage imageNamed:@"emNot.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.01 animations:^{
            [self.faceView setFrame:CGRectMake(0, self.superViewHeight, self.frame.size.width, kFunctionViewHeight)];
//            self.faceView.backgroundColor = [UIColor redColor];
        } completion:^(BOOL finished) {
            [self.faceView removeFromSuperview];
        }];
        
    }
}

- (void)showImage:(BOOL)isShow {

    if(isShow) {
        NSLog(@"图片显示");
        [self.imageButton setImage:[UIImage imageNamed:@"picS.png"] forState:UIControlStateNormal];
        [self.superview addSubview:self.moreView];
        self.moreView.sendImageBlock = ^(NSArray *imageArray){
            NSLog(@"imageArray:%@",imageArray);
        };
        
        [UIView animateWithDuration:.3 animations:^{
            [self.moreView setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight, self.frame.size.width, kFunctionViewHeight)];
        } completion:nil];
//        [self.superview addSubview:self.headView];
        
    }else {
        NSLog(@"图片不显示");
        [self.imageButton setImage:[UIImage imageNamed:@"picN.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.01 animations:^{
            [self.moreView setFrame:CGRectMake(0, self.superViewHeight, self.frame.size.width, kFunctionViewHeight)];
        } completion:^(BOOL finished) {
            [self.moreView removeFromSuperview];
        }];
//        [self.superview addSubview:self.headView];

        
    }
    
}

- (UIViewController *)rootVC {
    return [UIApplication  sharedApplication].keyWindow.rootViewController;
}

- (void)selectImage {
//    CocoaPickerViewController *transparentView = [[CocoaPickerViewController alloc] init];
//    transparentView.delegate = self;
//    transparentView.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    transparentView.view.frame = self.frame;
//    
//    [[self rootVC] presentViewController:transparentView animated:YES completion:nil];
}




- (void)touchDownAnamation:(UIButton* )button{
    button.bounds = CGRectMake(0, 0, 100, 100);
    
    [UIView animateWithDuration:0.25 animations:^{
        button.layer.cornerRadius = 50;
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
