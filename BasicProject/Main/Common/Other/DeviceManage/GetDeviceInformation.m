//
//  GetDeviceInformation.m
//   
//
//  Created by 宋亚清 on 16/3/14.
//  Copyright © 2016年  . All rights reserved.
//  获取设备信息类
//
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "GetDeviceInformation.h"
#import "SSKeychain.h"
#import "sys/utsname.h"
#import<AssetsLibrary/AssetsLibrary.h>

@implementation GetDeviceInformation

+(BOOL)GetCarmera{
    return YES;
}

+(BOOL)getPhoto{
       return YES;
}
+ (BOOL)canRecord
{
    __block BOOL bCanRecord = NO;
        
    return bCanRecord;
}
-(instancetype )init{
    if (self = [super init]) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        //    NSMutableDictionary *informationDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        //    CFShow(infoDictionary);
        // app名称
        self.app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//        NSLog(@"app名称:%@",_app_Name);
        
//        NSLog(@"app版本:%@",self.app_Version);
        //    // app build版本
        self.app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//        NSLog(@"app build版本:%@",self.app_build);
        
        //手机序列号
        self.identifierNumber = (NSString *)[[UIDevice currentDevice] identifierForVendor];
//        NSLog(@"手机序列号: %@",self.identifierNumber);
        //手机别名： 用户定义的名称
        self.userPhoneName = [[UIDevice currentDevice] name];
//        NSLog(@"手机别名: %@", self.userPhoneName);
        //设备名称5s 6s
//        self.deviceName = [[UIDevice currentDevice] systemName];
        self.deviceName =  [GetDeviceInformation getDeviceModel];
//        NSLog(@"设备名称: %@",self.deviceName );
        //手机系统版本
        self.phoneVersion = [[UIDevice currentDevice] systemVersion];
//        NSLog(@"手机系统版本: %@", self.phoneVersion);
        //手机型号
//        self.phoneModel = [[UIDevice currentDevice] model];
        self.phoneModel =  [GetDeviceInformation getDeviceModel];
//        NSLog(@"手机型号: %@",self.phoneModel );
        //地方型号  （国际化区域名称）
        self.localPhoneModel = [[UIDevice currentDevice] localizedModel];
//        NSLog(@"国际化区域名称: %@",self.localPhoneModel );
        
        // 当前应用名称
        self.appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//        NSLog(@"当前应用名称：%@",self.appCurName);
        // 当前应用软件版本  比如：1.0.1
        self.appCurVersion =  [NSString stringWithFormat:@"%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
//        NSLog(@"当前应用软件版本:%@",self.appCurVersion);
        // 当前应用版本号码   int类型
        self.appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
//        NSLog(@"当前应用版本号码：%@",self.appCurVersionNum);

    }
    return self;

}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
+ (CGFloat ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


+(NSString *)getDeviceInfo{
//    UIDevice *device = [[UIDevice alloc] init];
//    NSString *name = device.name;       //获取设备所有者的名称
//    NSString *model = device.model;      //获取设备的类别
//    NSString *type = device.localizedModel; //获取本地化版本
//    NSString *systemName = device.systemName;   //获取当前运行的系统
//    NSString *systemVersion = device.systemVersion;//获取当前系统的版本
//    NSLog(@"\n获取设备所有者的名称:%@,\n获取设备的类别:%@,\n获取本地化版本:%@,\n获取当前运行的系统:%@,\n获取当前系统的版本:%@",name,model,type,systemName,systemVersion);
    return nil;
}

//为系统创建一个随机的标示符
+(NSString*)createUUID
{
    NSString *identifierNumber;
        if([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0)
        {
            identifierNumber = [[NSUUID UUID] UUIDString];                //ios 6.0 之后可以使用的api
        }
        else{
            CFUUIDRef uuid = CFUUIDCreate(NULL);
            CFStringRef uuidString = CFUUIDCreateString(NULL, uuid);                    //ios6.0之前使用的api
            identifierNumber = [NSString stringWithFormat:@"%@", uuidString];
            [[NSUserDefaults standardUserDefaults] setObject:identifierNumber forKey:@"UUID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            CFRelease(uuidString);
            CFRelease(uuid);
        }
        return identifierNumber;
}

+(NSString *)get{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];

    //  获取运行商的名称
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    return mCarrier;
}


+(NSString *) getDeviceToken{
    NSError *error = nil;
    NSString *uniqueIdentifier = [SSKeychain passwordForService:@"WXY_TOKEN" account:@"wxy_device_token" error:&error];
    
    if ([error code] == SSKeychainErrorNotFound) {
        NSLog(@"uniqueIdentifier not found");
        uniqueIdentifier = [self createUUID];
        [SSKeychain setPassword:uniqueIdentifier forService:@"WXY_TOKEN" account:@"wxy_device_token"];
        NSLog(@"uniqueIdentifier:%@", uniqueIdentifier);
    }
    return uniqueIdentifier;
    
    
    
    /*
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"WXY_TOKEN" accessGroup:nil];
    //    NSString *username = [wrapper objectForKey:(id)kSecAttrAccount];
    //    NSString *password = [wrapper objectForKey:(id)kSecValueData];
    NSString *uniqueIdentifier = [wrapper objectForKey:(id)kSecAttrAccount];
    NSLog(@"device_identifier:%@",uniqueIdentifier);
    if ([uniqueIdentifier isEqualToString:@""]) {
        [wrapper setObject:[self createUUID] forKey:(id)kSecAttrAccount];
        NSLog(@"set uniqueIdentifier.");
    }
    
    uniqueIdentifier = [wrapper objectForKey:(id)kSecAttrAccount];
    NSLog(@"uniqueIdentifier:%@", uniqueIdentifier);
    return uniqueIdentifier;
    */
} //getDeviceIdentifier

+ (NSString*)getDeviceModel
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString hasPrefix:@"iPhone6"])            return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";

//    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
//    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
//    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
//    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
//    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
//    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
//    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}


@end
