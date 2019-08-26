//
//  GetDeviceInformation.h
//   
//
//  Created by 宋亚清 on 16/3/14.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>
@class deviceInforMationModel;
@interface GetDeviceInformation : NSObject
@property (copy, nonatomic) NSString *app_Name; /**< app名称 >*/

@property (copy, nonatomic) NSString *app_build;/**< app build版本 >*/

@property (copy, nonatomic) NSString *identifierNumber;/**< 手机序列号 >*/
@property (copy, nonatomic) NSString *userPhoneName;/**<  手机别名： 用户定义的名称>*/

@property (copy, nonatomic) NSString *deviceName;/**< 设备名称 5s 6s >*/

@property (copy, nonatomic) NSString *phoneVersion;/**< 手机系统版本 >*/

@property (copy, nonatomic) NSString *phoneModel;/**< 手机型号 >*/

@property (copy, nonatomic) NSString *appCurName;/**< 当前应用名称 >*/
@property (copy, nonatomic) NSString *appCurVersion; /**< 当前应用软件版本  比如：1.0.1 >*/
@property (copy, nonatomic) NSString *appCurVersionNum;/**< 当前应用版本号码 >*/
@property (copy, nonatomic) NSString *localPhoneModel;/**< 地方型号  （国际化区域名称） >*/
//相机权限
+(BOOL)GetCarmera;
//相册权限
+(BOOL)getPhoto;
//麦克风权限
+ (BOOL)canRecord;
/**
 *  获取单个文件的大小
 *
 *  @param filePath 文件的路径
 *
 *  @return 数据 long
 */
+ (long long) fileSizeAtPath:(NSString*) filePath;

/**
 *  便利文件夹获取文件夹大小
 *
 *  @param folderPath 要遍历的文件目录
 *
 *  @return 返回数值 float
 */
+ (CGFloat ) folderSizeAtPath:(NSString*) folderPath;
+(NSString *)getDeviceInfo;
+(NSString*)createUUID;
+(NSString *) getDeviceToken;
+(NSString *) getDeviceModel;

@end
