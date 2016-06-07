//
//  YTImageManager.m
//  YTChatBar
//
//  Created by JDYX on 16/6/6.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import "YTImageManager.h"

@implementation YTImageManager

static YTImageManager* _sharedManaer = nil;

+(instancetype)imageManager {
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _sharedManaer = [[self alloc] init] ;
    }) ;
    
    return _sharedManaer ;
}

@end
