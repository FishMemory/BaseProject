//
//  Camera.m
//   
//
//  Created by 宋亚清 on 16/4/16.
//  Copyright © 2016年  . All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MediaPicker.h"
#import "NetWorkDecideD.h"
#import <CoreServices/CoreServices.h>
static NSString * const app_name_cn  = @"";
static NSString * const app_name_En  = @"";
@implementation MediaPicker
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)selectResource:(MediaType)sourceType vc:(UIViewController *)vc delegate:(id <MediaPickerDelegate>)delegate key:(NSString *)key{
    self.mediaPickerDelegate = delegate;
    self.key = key;
    self.vcControllers  = vc;
//    //检查相机模式是否可用
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        NSLog(@"sorry, no camera or camera is unavailable.");
//        return;
//    }
//    //获得相机模式下支持的媒体类型
//    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    BOOL canTakePicture = NO;
//    for (NSString* mediaType in availableMediaTypes) {
//        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
//            //支持拍照
//            canTakePicture = YES;
//            break;
//        }
//    }
//
//    //检查是否支持拍照
//    if (!canTakePicture) {
//        NSLog(@"sorry, taking picture is not supported.");
//        return;
//    }
//创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    
    //设置图像选取控制器的来源模式为相机模式
    if (sourceType == CAMERA) {
        if ( ![GetDeviceInformation GetCarmera]) {
            NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相机“选项中，允许%@访问您的手机相机",NSLocalizedString(app_name_cn,@"哈特瑞姆")];
            [MyAlertView WarningTextAlertViewActionWithUIViewController:self.vcControllers  title:@"" message:tips cancelButtonTitle:@"取消" okButtonTitle:@"好的" cancelBlocks:^(UIAlertAction *but) {
            } okBlock:^(UIAlertAction *but) {
            }];
            return;
        }
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置图像选取控制器的类型为静态图像
//        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil] ;
    }else if(sourceType == PHOTO){ // 相册库里的图片
        if(![GetDeviceInformation getPhoto]){
            NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相册“选项中，允许%@访问您的照片",NSLocalizedString(app_name_cn,app_name_En)];
            [MyAlertView WarningTextAlertViewActionWithUIViewController:self.vcControllers title:@"" message:tips cancelButtonTitle:@"取消" okButtonTitle:@"好的" cancelBlocks:^(UIAlertAction *but) {
                
            } okBlock:^(UIAlertAction *but) {
                
            }];
            return ;
        }
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.navigationBar.translucent = YES;
        //设置图像选取控制器的类型为静态图像
        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil] ;
    }else if(sourceType == AUDIO_VIDEO){ // 相册库里的音视频
        if(![GetDeviceInformation getPhoto]){
            NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相册“选项中，允许%@访问您的照片",NSLocalizedString(app_name_cn,app_name_En)];
            [MyAlertView WarningTextAlertViewActionWithUIViewController:self.vcControllers title:@"" message:tips cancelButtonTitle:@"取消" okButtonTitle:@"好的" cancelBlocks:^(UIAlertAction *but) {
                
            } okBlock:^(UIAlertAction *but) {
                
            }];
            return ;
        }
        imagePickerController.sourceType = UIImagePickerControllerCameraCaptureModeVideo;
        imagePickerController.navigationBar.translucent = YES;
        //设置图像选取控制器的类型为视频
        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie, nil] ;
    }
    
    //允许用户进行编辑
    if(self.key != nil && [self.key isEqualToString:@"alumniBackImage"]){
           imagePickerController.allowsEditing = NO;
    }else{
           imagePickerController.allowsEditing = YES;
          
    }
//    imagePickerController.edgesForExtendedLayout = UIRectEdgeNone;
    
//    imagePickerController.showsCameraControls  = YES;
    if (sourceType == AUDIO_VIDEO) {
        imagePickerController.videoMaximumDuration = 5*60.f;
        
    }
    //设置委托对象
    imagePickerController.delegate = self;
   
    //以模视图控制器的形式显示

    [vc presentViewController:imagePickerController animated:YES completion:^{
        vc.navigationController.navigationBar.translucent = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        if (sourceType == AUDIO_VIDEO) {
             [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }];
}
#define TITLE @"您当前处于运营商网络状态下，是否继续？"

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //  判断是选择背景图
    if(self.key != nil && [self.key isEqualToString:@"YES"]){
      
   
    }else{
        UIImage* editedImage= [[UIImage alloc]init];
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        //当image从相机中获取的时候存入相册中
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//            UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
//        }
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
            NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            if(editedImage == nil){
                if([mediaType isEqualToString:@"public.movie"])
                {
                    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
                    NSLog(@"found a video");
                    BOOL iswifi = [NetWorkDecideD IsEnableWIFI];
                    if( iswifi == NO ){
                        [MyAlertView WarningTextAlertViewActionWithUIViewController:picker title:@"" message:TITLE cancelButtonTitle:@"放弃" CancelButtonColor:COL_THEME OkButtonColor:COL_THEME okButtonTitle:@"继续" cancelBlocks:^(UIAlertAction *but) {
                            [picker dismissViewControllerAnimated:YES completion:^{
                                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                            }];
                        } okBlock:^(UIAlertAction *but) {
                            if(videoURL != nil){
                                [self.mediaPickerDelegate selectVideoUrl:videoURL thumbnail:nil forkey:self.key];
                            }
                            [picker dismissViewControllerAnimated:YES completion:^{
                                
                                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                                
                            }];
                        }];
                    }else{
                        if(videoURL != nil){
                            [self.mediaPickerDelegate selectVideoUrl:videoURL thumbnail:nil forkey:self.key];
                        }
                        [picker dismissViewControllerAnimated:YES completion:^{
                            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                        }];
                    }
                }
                
            }else{
                NSData *headviewData = UIImageJPEGRepresentation(editedImage, 0.3);
                if(headviewData != nil){
                    [self.mediaPickerDelegate selectImageData:headviewData forkey:self.key];
                    [picker dismissViewControllerAnimated:YES completion:^{
                        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                    }];
                }
            }
            
          
        } else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {

            editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
         
                NSData *headviewData = UIImageJPEGRepresentation(editedImage, 0.3);
                if(headviewData != nil){
                    [self.mediaPickerDelegate selectImageData:headviewData forkey:self.key];
                }
            [picker dismissViewControllerAnimated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            }];
        }
        
   
    }
    
} 
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
      
    }];
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
}

/*
// 截取 图片 取消
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
       [controller.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
           [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
       }];
}
// 截取 图片 完成
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{
  
    NSData *imageData = UIImageJPEGRepresentation(croppedImage, 0.3);
    [self.CameraDelegate selectIamgeData:imageData forkey:self.key];
    [controller.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
        
}

*/


@end
