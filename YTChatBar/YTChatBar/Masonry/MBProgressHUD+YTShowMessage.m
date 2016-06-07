//
//  MBProgressHUD+YTShowMessage.m
//  YTAnmation
//
//  Created by Ljcx on 16/3/14.
//  Copyright © 2016年 Ljcx. All rights reserved.
//

#import "MBProgressHUD+YTShowMessage.h"
//#import "AFNetworkReachabilityManager.h"
#import <objc/runtime.h>


static const void *IndieBandNameKey = &IndieBandNameKey;

@implementation MBProgressHUD (YTShowMessage)

- (void)setStr:(NSString *)str  {
    objc_setAssociatedObject(self, &IndieBandNameKey, str, OBJC_ASSOCIATION_COPY);
}

- (NSString *)str {

    return objc_getAssociatedObject(self, &IndieBandNameKey);
}

+(MBProgressHUD *)showMessage:(NSString *)message customView:(UIView *)customView mode:(MBProgressHUDMode)modeStyle toView:(UIView *)toView {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.labelText = message;
    hud.customView = customView;
    hud.mode = modeStyle;
    [hud show:YES];
    
    return hud;
}

-(void)printHello {
    self.str = @"123";
    
}

#pragma mark 网络状态的监测

//+ (NSInteger )monitorNetworkStatus {
//    
//    __block NSInteger statusCode;
//    
//    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
//    // 检测网络连接的单例,网络变化时的回调方法
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        
//        statusCode  = status;
//        
//        
//    }];
//    
//    return statusCode;
//    
//    
//}




@end
