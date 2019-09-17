//
//  TestController.h
//
//
//  Created by 宋亚清 on 19/9/16.
//  Copyright © 2019年  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavigationBar.h"
#import "MBProgressHUD.h"
#import <MJRefresh/MJRefresh.h>
#ifndef BaseController_h
#define BaseController_h

#define IPHONE4x_5x_WIDTH 640
#define IPHONE6x_WIDTH 750
#define IPHONE6xP_WIDTH 1242

// 屏幕尺寸
#define IPHONE_4X_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)
#define IPHONE_5X_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)
#define IPHONE_6X_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)
#define IPHONE_6PLUS_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

#define SCREEN_PHY_WIDTH ([UIScreen mainScreen].bounds.size.width * [[UIScreen mainScreen] scale])


// UI图的宽度
//#define UI_WIDTHS 750
// 直接使用UI图上的尺寸，像素单位
#define PX(px) (SCREEN_WIDTH/UI_WIDTH*px)

// UI的字号磅数
#define FONT_PT(pt)(PX(pt/72.0f*96))

// PS里的字体大小
#define DEFAULT_TIMEOUT 2.0f

typedef void (^BecomeActiveBlock)(void);

/** 如果当前Controller想处理UrlParser里的自定义Action，需要注册该方法处理NSNotification通知 */
@interface BaseController : UIViewController<UINavigationBarDelegate>
// toast
@property(nonatomic,strong, nullable)NSDictionary* userInfo;
@property (nonatomic, strong) NSString* pushClassName;


@property (nonatomic, strong, nullable) BecomeActiveBlock beActiveBlock;
// toast Y方法偏移
@property CGFloat offsetY;
// 统计的View名
@property (nonatomic,nonnull, strong)NSString* _viewName;
@property (nonatomic, assign)CGFloat NavBarHeight;
@property (nonatomic, assign)CGFloat TabBarHeight;
@property (nonatomic, strong) UIView *navLineV;
@property (nonatomic, strong) UIView *naview;
@property(nonatomic,strong) MyNavigationBar* myNavigationBar;

-(BOOL)needNavigationBar;

// 是否正在显示
-(BOOL)isVisible;

// 设置标题
-(void)setTitle:(nullable NSString*)title;

/**
 设置统计时页面的名字
 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)setPageName:( NSString* _Nonnull )pageName;

-(nullable NSString *)getPageClassName;

/**
 *  设置 状态栏类型
 *
 *  @param UIStatusBarStyle
 */
-(void)setStatusBkgStyle:(nullable UIStatusBarStyle *)UIStatusBarStyle;

// 在主线程里执行一个延时任务
-(void)async_task:(CGFloat)delay exeBlk:(void (^_Nonnull)(void))exeBlk;

// 设置导航栏背景色
-(void)setNaviBarBkg:(nullable UIColor *)color;



/// 初始化带搜索的导航栏
-(void)initNaviItemWithSearchBarPlace:(NSString*)placeh action:(nullable SEL)searchAction;

/**
 判断两次action行为是否超过delay间隔
 如果没有超过，返回YES
 如果超过，返回NO
 */
//-(BOOL)mutiQuickAction:(nonnull NSString*)action minDelay:(NSInteger)delay;

-(void)showProgress;
-(void)dismissProgress;
-(void)showWarnText:(nullable NSString*) text;
-(void)showConfirmText:(nullable NSString*) text;
- (void)setProgressOffsetY:(CGFloat)y;
- (BOOL)checkLoginStatus;
// 判断自己是否是TabBar的根VC
-(BOOL)isTabBarController;


// 设置渐变主题
-(void)setNavBarBkgchangeCol:(NSArray*)colors;
/// 设置 navgationtitle
-(void)setNavBarTitle:(NSString*)title;
/// 添加mjheader
-(MJRefreshNormalHeader*)initiMJheader:(SEL)action;
// 添加 mjfooter
-(MJRefreshBackNormalFooter*)inittTabMJfooter:(void(^)(void))refresh;
//设置注册 登录页的导航栏样式
-(void)setLoginControllerType;

-(void)backLastPageWith:(NSString*)name;

- (void)backAction;
///  设置 title 和右键 图片
-(void)setTitle:(NSString *)title imageName:(NSString*)imageName action:(SEL)action;
///  设置 title 和右键 为文字
-(void)setTitle:(NSString *)title rightTitle:(NSString*)rightTitle action:(SEL)action;

@end


#endif /* TestController_h */

