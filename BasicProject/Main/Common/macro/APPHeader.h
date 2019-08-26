//
//  APPHeader.h
//
//
//  Created by   on 16/2/24.
//  Copyright © 2016年  . All rights reserved.
//
//  宏定义和声明信息

#import "DeleLine.h"
#import "AppHelper.h"

#ifndef Project_APPHeader_h
#define Project_APPHeader_h

#define NOW [NSDate date]


#define STATUSBAR_DEFAULT  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

#define STATUSBAR_LIGHT  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

#pragma mark-    --异常捕获-->
//TODO: release  改为0    调试模式 改为 1  don't forget

/**
 *  输出宏 1为调试模式 0为release
 *
 *  @param format 会输出所在行数的log 控制台输出
 *  @param ...
 *
 *  @return
 */


#ifdef  DEBUG
#define HYString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define NSLog(...) printf("<%s 第%d行>:%s NSLog:\n  %s\n-----\n", [HYString UTF8String] ,__LINE__,__func__ ,[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#elif defined PROD
#define HYString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define NSLog(...) printf("<%s 第%d行>:%s NSLog:\n  %s\n-----\n", [HYString UTF8String] ,__LINE__,__func__ ,[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define NSLog(format, ...) nil
#endif


// UI图的宽度

#define IPhone5_UP ([UIScreen mainScreen].bounds.size.width >320.f)
// 直接使用UI图上的尺寸，像素单位

#define UI_WIDTH 750.0

#define PX(px) (SCREEN_WIDTH/UI_WIDTH*px)

//  宏
/*
 *  布局
 *
 *  依次 ：最小X  最大X  最小Y  最大Y  宽  高  设备宽  设备高
 *
 */
#pragma mark - ————————————————— 布局缩写
#define cminX CGRectGetMinX
#define cmaxX CGRectGetMaxX
#define cminY CGRectGetMinY
#define cmaxY CGRectGetMaxY
#define cwidth CGRectGetWidth
#define cheight CGRectGetHeight


#pragma mark - 颜色和字体

// 16进制颜色码（#FFFFFF）转RGB
#define UIColorFromRGBA(RGBValue, alphaValue) [UIColor colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 green:((float)((RGBValue & 0x00FF00) >> 8))/255.0 blue:((float)(RGBValue & 0x0000FF))/255.0 alpha:alphaValue]
//16进制色值
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

#define COL_NAVI [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]

#define FONT_SIZE [UIFont systemFontOfSize:14]
// 灰字体颜色
#define COL_GRAY_FONT rgb(163, 163, 163)

//  153 号灰色
#define COL_GRAY_FONT_153 rgb(153,153,153)

//  192 浅灰色
#define COL_GRAY_FONT_192 rgb(192,192,192)
//  纯白色
#define COL_WHITE [UIColor whiteColor]
//  51 号黑色
#define COL_GRAY_FONT_51 rgb(51,51,51)
//  自定义多少颜色值
#define COL_GRAY(num) rgb(num,num,num)

//  浅黑色
#define COL_LIGHT_BLACK_FONT rgb(102,102,102)

// 黑字体颜色
#define COL_BLACK_FONT rgb(0, 0, 0)

#define COL_GRAY_LINE  [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]// 灰色线条

// 首页灰色背景
#define COL_BKG_GRAY  [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]
// 渐变颜色起始
#define COL_CHANG_START  HEXCOLOR(0x0093CD)
// 渐变颜色 后半
#define COL_CHANG_END  HEXCOLOR(0x00C47A)

#define COL_SEARCH_BAR [UIColor colorWithWhite:0.89 alpha:1]
//#define COL_SEARCH_BAR  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]

#define FONT(sz)  [UIFont systemFontOfSize:sz]
// 细体 Light
#define FONT_LIGHT(sizes) [UIFont fontWithName:@"Helvetica-Light" size:(sizes)]
// 加粗 Helvetica-Bold
#define FONT_BOLD(sizes) [UIFont boldSystemFontOfSize:sizes]
// 斜体
#define FONT_ITALIC(size) [UIFont italicSystemFontOfSize:PX(size)]

//  获取验证码颜色
#define COL_YELLOW_BT_GETCODE rgb(255, 192, 0)

//  不能点击按钮背景色
#define COL_GRAY_UNCLICK_BUTTON [UIColor colorWithRed:143 /255.0 green:143 / 255.0 blue:143 / 255.0 alpha:1]

//  不能点击按钮的标题
#define COL_GRAY_UNCLICK_BUTTON_TITLE [UIColor colorWithRed:172 / 255.0 green:172 / 255.0 blue:172 / 255.0  alpha:1]

//  粉红色
#define COL_PINK [UIColor colorWithRed:250/255.0 green:0/255.0 blue:70/255.0 alpha:1]


// 首页 字体-----------------
// 标题默认字体
#define FONT_TITLE [UIFont systemFontOfSize:PX(32)]
// 详情默认字体
#define FONT_DETAIL [UIFont systemFontOfSize:PX(28)]
// 黑色
#define COL_BLACK [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]

// APP主题色
#define COL_THEME [UIColor colorWithRed:255/255.0 green:90/255.0 blue:90/255.0 alpha:1]

// APP 浅绿色
#define COL_LITHT_BLUE [UIColor colorWithRed:20/255.0 green:215/255.0 blue:200/255.0 alpha:1]/**< 浅蓝色 >*/

// APP棕色
#define COL_BROWN [UIColor colorWithRed:94/255.0 green:48/255.0 blue:15/255.0 alpha:1]
#pragma mark - ————————————————— 系统Version和设备尺寸
//ios系统版本RGB 240，130，47

#define IOS_9X [[[UIDevice currentDevice] systemVersion] floatValue] >=9.0f
#define IOS_8X [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define IOS_7X ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)

#define IOS_6X [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f

#define IOS_NOT_6X [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f
// 屏幕尺寸
#define IPHONE_4X_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)
#define IPHONE_5X_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)
#define IPHONE_6X_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)
#define IPHONE_6PLUS_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)
#define IPHONE_X ([UIScreen mainScreen].bounds.size.height==812.0f || [UIScreen mainScreen].bounds.size.height==414.0f)
#define pro 16/9
// CGRectMake
#define FRAME(l,t,w,h) CGRectMake(l, t, w, h)

/**
 *  @param className 单例声明定义
 *  @return nil
 */
//.h
#define singleton_interface(className)  + (instancetype)shared##className;

//.m
#define singleton_implementation(className) \
static className *_instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
\
return _instace; \
} \
\
+ (instancetype)shared##className \
{ \
if (_instace == nil) { \
_instace = [[className alloc] init]; \
} \
\
return _instace; \
}
// 解决循环引用
#define WS(weakSelf)  __weak __typeof(&*self) weakSelf = self
#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;

// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//iphone 状态栏
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
// 导航栏高度
#define kNavBarHeight 44.0
// 导航状态栏 高度
#define kTopSafeHeight (kStatusBarHeight + kNavBarHeight)
// tabbar 间距
#define ktabBarSpaceH (kStatusBarHeight == 20 ? 0 :  34)

#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define IPhoneXTabSpace (IS_IPhoneX_All ? 34 : 0)

#define ktabBarHeight 49

//读取本地图片
#define LOAD_IMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]
#define ImageData(a) [UIImage imageWithData:(a)]

//定义NSurl对象
#define UrlString(a) [NSURL URLWithString:a]

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#define UI_ASYNC_TASK_DELAY(sec, block)  \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((sec) * NSEC_PER_SEC)), \
dispatch_get_main_queue(), (block));


#define UI_ASYNC_TASK(block)  dispatch_async(dispatch_get_main_queue(), (block));

//  版本号
#define VERSION_NO [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//清除背景色
#define CLEAR_COLOR [UIColor clearColor]
// 读取本地文件 得到字典类型
#define READ_FILE(name,type) [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]] options:NSJSONReadingAllowFragments error:nil];


//本地存储 NSuserdefaults
#define SAVE_TO_USER_DEFAULT(value,key)  do{\
[[NSUserDefaults standardUserDefaults] setObject:(value) forKey:(key)];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}while (0)

#define REMOVE_USER_DEFAULT(key)  do{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:(key)];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}while (0)

#define GET_OBJ_FROM_USER_DEFAULT(key) [[NSUserDefaults standardUserDefaults] objectForKey:(key)]

//获取 c语言 数组count的宏
#define GET_ARRAY_LEN(array,len){len = (sizeof(array) / sizeof(array[0]));}
//沙河path
#define SANDBOX_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]
// 返回App的封装对象
#define APP ([AppHelper sharedManager])

// 叹号提示框
#define SHOW_WARN_INFO(view, second, msg) [[ProgressHUD instance] showWarnProgressHDWithTimer:(view) time:(second) info:(msg) ]

// 无图片提示框 toast
#define SHOW_WARN_INFO_NO_IMG(view, second, msg) [[ProgressHUD instance] showWarnHUDWithTimer:(view) time:(second) info:(msg)]
// 完成 成功  toast
#define SHOW_CompletedProgressHD(view, second, msg) [[ProgressHUD instance] completedProgressHDView:(view) time:(second) info:(msg)]
// 成功 block
typedef  void(^successfulBlock)(NSDictionary *dic);
// 失败
typedef  void(^failBlock)(NSDictionary *dic);


#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))

/*
 *注册cell
 */
#define cellRegisterNibWith(tableView,nibName,identifier)     [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:identifier];

#define cellRegisterClassWith(tableView,className,identifier) [tableView registerClass:[className class] forCellReuseIdentifier:identifier];

/*
 *注册collectioncell
 */
#define CollectionCellRegisterNibWith(collection,nibName,identifier)      [collection registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:identifier];

#define CollectionCellRegisterClassWith(collection,className,identifier) [collection registerClass:[className class] forCellWithReuseIdentifier:identifier];

#define DefaultCenter [NSNotificationCenter defaultCenter]

#endif /* APPHeader_h */

