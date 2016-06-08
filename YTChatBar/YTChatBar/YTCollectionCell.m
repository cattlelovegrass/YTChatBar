//
//  YTCollectionCell.m
//  YTChatBar
//
//  Created by JDYX on 16/6/7.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import "YTCollectionCell.h"
#import "Masonry/Masonry.h"

@implementation YTCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor yellowColor];
        [self loadUI];        
    }
    return self;
}


- (void)loadUI {
    
    self.imageButton = [[UIImageView alloc]init];
    [self addSubview:self.imageButton];
    
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(self.mas_right).offset(-8);
    }];

    
}



@end
