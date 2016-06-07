//
//  YTSlideImageView.m
//  YTChatBar
//
//  Created by JDYX on 16/6/7.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import "YTSlideImageView.h"
#import "YTImageManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Masonry.h"
#import "MBProgressHUD+YTShowMessage.h"
#import "TZImagePickerController.h"


@interface YTSlideImageView()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *sendBackArray;

@property (nonatomic,strong) UIButton *doneButton;

@property (nonatomic,strong) UIButton *cameraButton;

@property (nonatomic,strong) UIButton *imageLabraryBtn;


@end

@implementation YTSlideImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self loadPhotoLibName];
    }
    return self;
    
}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)loadScrollImageView {
    
}

- (void)loadPhotoLibName {
    _sendBackArray = [NSMutableArray array];
    NSArray *imageArray = [YTImageManager imageManager].imageArray;
    if(imageArray.count > 0) {

        [self initHeadView];
        [self addPhotoToScrollViewWithImageArray:imageArray];
        
    }else {
        ALAssetsLibrary *assets = [[ALAssetsLibrary alloc]init];
        [assets enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if(group == nil) {
                return ;
            }
            NSString *name = [NSString stringWithFormat:@"%@",[group valueForProperty:ALAssetsGroupPropertyName]];
            if ([name isEqualToString:@"相机胶卷"]|| [name isEqualToString:@"Camera Roll"]) {
                [self getImageWith:group];
            }
        } failureBlock:^(NSError *error) {
            
        }];
    }
}

- (void)getImageWith:(ALAssetsGroup *)assets {
    NSMutableArray *imageArray = [NSMutableArray array];
    [assets enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result) {
            UIImage *image = [UIImage imageWithCGImage:result.aspectRatioThumbnail];
            [imageArray addObject:image];
        }
    }];
    NSArray *revArray = [imageArray copy];
    NSMutableArray *oldArray = [NSMutableArray array];
    for(UIImage *image in [revArray reverseObjectEnumerator]) {
        [oldArray addObject:image];
    }
    
    NSArray *array = [oldArray copy];
    [self initHeadView];
    [YTImageManager imageManager].imageArray = array;
    [self  addPhotoToScrollViewWithImageArray:array];
    
}

- (void)selectFromLibrary:(UIButton *)btn {
    NSLog(@"从相册选择");
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    //    imagePickerVc.isSelectOriginalPhoto
    //    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    //    imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    
    [[self rootVC] presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (void)takePhoto:(UIButton *)btn {
    NSLog(@"拍照");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [[self rootVC] presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"模拟器无法打开照相机，请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_sendBackArray addObject:image];
    ALAssetsLibrary *liarary = [[ALAssetsLibrary alloc]init];
    [liarary writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
    }];
    
    NSArray *array = [_sendBackArray copy];
    
    _sendImageBlock(array);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (UIViewController *)rootVC {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)sendImage:(UIButton *)btn {
    NSLog(@"发送图片");
    if(_sendBackArray.count == 0) {
        [self popView:@"请选择图片"];
    }else {
        
    }
}

- (void)popView:(NSString *)title {
    MBProgressHUD *mb =[MBProgressHUD showMessage:title customView:nil mode:MBProgressHUDModeText toView:self];
    [mb hide:YES afterDelay:0.7f];
}

- (void)initHeadView {
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 168)];
    scroll.showsVerticalScrollIndicator = NO;
    [self addSubview:scroll];
    _scrollView = scroll;
    
    UIView *bottomView = [[UIView alloc]init];
    
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(scroll.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    
    self.doneButton = [self buttonWithFrame:CGRectMake(0,0,0,0) title:@"发送" target:self selector:@selector(sendImage:)];
    [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.doneButton.layer.cornerRadius = 6;
    self.doneButton.clipsToBounds = YES;
    self.doneButton.layer.borderWidth = 1;
    self.doneButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.doneButton.backgroundColor = [UIColor colorWithRed:38/255.0 green:183/255.0 blue:236/255.0 alpha:1.0];
    [bottomView addSubview:self.doneButton];
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(5);
        make.right.equalTo(bottomView.mas_right).offset(-4);
        make.width.equalTo(@(70));
        make.bottom.equalTo(bottomView.mas_bottom).offset(-4);
    }];
    
    
    
    self.cameraButton = [self buttonWithFrame:CGRectMake(0,0,0,0) title:@"相机" target:self selector:@selector(takePhoto:)];
    [self.cameraButton setTitleColor:[UIColor colorWithRed:38/255.0 green:183/255.0 blue:236/255.0 alpha:1.0] forState:UIControlStateNormal];
    [bottomView addSubview:self.cameraButton];
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(5);
        make.left.equalTo(bottomView.mas_left).offset(6);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-4);
        make.width.equalTo(@(58));
    }];
    
    self.imageLabraryBtn = [self buttonWithFrame:CGRectMake(0,0,0,0) title:@"相册" target:self selector:@selector(selectFromLibrary:)];
    [self.imageLabraryBtn setTitleColor:[UIColor colorWithRed:38/255.0 green:183/255.0 blue:236/255.0 alpha:1.0] forState:UIControlStateNormal];
    [bottomView addSubview:self.imageLabraryBtn];
    [self.imageLabraryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(5);
        make.left.equalTo(self.cameraButton.mas_right).offset(1);
        make.width.equalTo(@(58));
        make.bottom.equalTo(bottomView.mas_bottom).offset(-4);
    }];

}

- (void)addPhotoToScrollViewWithImageArray:(NSArray *)array {
    
    for(int i =0;i<array.count;i++) {
        UIImage *image = array[i];
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageBtn setImage:image forState:UIControlStateNormal];
        imageBtn.tag = i;
        [imageBtn addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        imageBtn.layer.borderWidth = 2;
        imageBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        float imageView_W = image.size.width/(image.size.height/_scrollView.bounds.size.height);
        imageBtn.frame = CGRectMake(_scrollView.contentSize.width,0,imageView_W,_scrollView.bounds.size.height);
        imageBtn.selected = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width+imageView_W,_scrollView.contentSize.height);
        [_scrollView addSubview:imageBtn];
    }
    
}

- (void)imageClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    UIImage *image = [YTImageManager imageManager].imageArray[btn.tag];
    NSLog(@"子视图：%@",btn.subviews);
    
    if (btn.selected) {
        [_sendBackArray addObject:image];
        btn.layer.borderColor = [UIColor colorWithRed:38/255.0 green:183/255.0 blue:236/255.0 alpha:1.0].CGColor;
    } else{
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_sendBackArray removeObject:image];
    }
    
    NSArray *array = [_sendBackArray copy];
    _sendImageBlock(array);
}

- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    NSLog(@"kankan:%@",photos);
#warning TODO
}

@end
