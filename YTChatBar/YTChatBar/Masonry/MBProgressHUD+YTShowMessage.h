//
//  MBProgressHUD+YTShowMessage.h
//  YTAnmation
//
//  Created by Ljcx on 16/3/14.
//  Copyright © 2016年 Ljcx. All rights reserved.
//

#import "MBProgressHUD.h"


//执行任务回调
typedef void (^success)(NSURLSessionDataTask *task, id responseObject);

//完成任务回调
typedef void (^failure)(NSURLSessionDataTask *task, NSError *error);


@interface MBProgressHUD (YTShowMessage)

//显示：文字,图片,mode样式

+(MBProgressHUD *)showMessage:(NSString *)message customView:(UIView *)customView mode:(MBProgressHUDMode)modeStyle toView:(UIView *)toView;

//-(void)printHello;

//+ (NSInteger)monitorNetworkStatus;
//
//@property (nonatomic, strong) NSString *str;




@end
