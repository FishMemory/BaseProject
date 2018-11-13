//
//  MediaPicker.h
//   
//
//  Created by 宋亚清 on 16/4/16.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "RSKImageCropper.h"

typedef enum {
    CAMERA = 1,
    PHOTO,
    AUDIO_VIDEO,
}MediaType;

@protocol MediaPickerDelegate <NSObject>
@optional//不必须实现的代理方法
/**
 * 代理返回 NSData
 *
 *  @param data
 *
 *  @return 返回Image NSData
 */
-(void)selectImageData:(NSData *)data forkey:(NSString*)key;
-(void)selectVideoUrl:(NSURL *)url thumbnail:(UIImage*)image forkey:(NSString*)key;
@end


@interface MediaPicker : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate,RSKImageCropViewControllerDelegate>
@property (weak, nonatomic) id <MediaPickerDelegate>mediaPickerDelegate;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) UIViewController *vcControllers;
@property (assign, nonatomic) CGFloat  scale;
/**
 *  系统相册选择或拍照
 *
 *  @param sourceType, CAMERA 调用相机,  PHOTO 调相册, AUDIO_VIDEO 音视频
 *  @param vc            要当前的控制器
 *  @param delegate      设置代理对象
 */
-(void)selectResource:(MediaType)sourceType  vc:(UIViewController *)vc delegate:(id <MediaPickerDelegate>)delegate key:(NSString *)key;
@end
