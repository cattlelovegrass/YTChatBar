//
//  ViewController.m
//  YTChatBar
//
//  Created by JDYX on 16/6/6.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import "ViewController.h"
#import "YTChatBar.h"

@interface ViewController ()<XMChatBarDelegate>

@property (nonatomic, strong) YTChatBar *bar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"聊天输入框";
    
    self.navigationController.navigationBar.translucent = NO;
    
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:233/255.0 blue:237/255.0 alpha:1.0];
    [self loadBar];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)chatBar:(YTChatBar *)chatBar sendMessage:(NSString *)message
{
    NSLog(@"试试看message:%@",message);
}

- (void)loadBar {
    self.bar = [[YTChatBar alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-80-64,self.view.frame.size.width,80)];
    [self.bar setSuperViewHeight:[UIScreen mainScreen].bounds.size.height - (self.navigationController.navigationBar.isTranslucent ? 0 : 64)];
    self.bar.delegate = self;
    self.bar.backgroundColor = [UIColor colorWithRed:231/255.0 green:233/255.0 blue:237/255.0 alpha:1.0];
    [self.view addSubview:self.bar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
