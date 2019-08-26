//
//  TestController.h
//   
//
//  Created by Michael on 16/5/16.
//  Copyright © 2016年  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
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

-(void)goBackPage;
// VC变成从后台变成前台后，需要执行的操作
@property (nonatomic, strong, nullable) BecomeActiveBlock beActiveBlock;
// toast Y方法偏移
@property CGFloat offsetY;
// 统计的View名
@property (nonatomic,nonnull, strong)NSString* _viewName;
@property (nonatomic, assign)CGFloat NavBarHeight;
@property (nonatomic, assign)CGFloat TabBarHeight;
// 是否正在显示
-(BOOL)isVisible;

// 设置标题
-(void)setTitle:(nullable NSString*)title;
// 设置右侧文字
-(void)setRightText:(nullable NSString*)rText;


/**
 设置统计时页面的名字
 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)setPageName:( NSString* _Nonnull )pageName;

-(nullable NSString *)getPageClassName;

-(void)defaultNotifyActionProcess:(nullable NSNotification*)notify;
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

// 初始化中间带标题的导航栏
-(void)initNaviItem:(nullable NSString*)title;

/**
 *  设置导航栏的的标题 和左边的按钮
 *  初始化中间带标题的导航栏，带自定义返回按钮操作
 *  @param title      标题
 *  @param leftAction 左边按钮点击事件
 */
-(void)initNaviItem:(nullable NSString*)title action:(nullable SEL)rightAction;

- (void)initNaviItemRightButton:(nullable NSString *)rightText action:(nullable SEL)rightAction;
/**
 *  初始化带右侧图片的导航栏
 *
 *  @param title
 *  @param rImage
 *  @param rightAction
 */
-(void)initNaviItemWithRightImage:(nullable NSString*)title image:(nullable UIImage*)rImage
                           action:(nullable SEL)rightAction;
/**
 *  设置 左边按钮 隐藏
 *
 *  @param hidden  YES / NO
 */
-(void)setNavItemLeftHidden:(BOOL)hidden;

/**
 右边导航隐藏

 @param hidden
 */
-(void)setNavItemRightHidden:(BOOL)hidden;
// 初始化带搜索的导航栏z
-(void)initNaviItemWithSearchBar:(nullable SEL)searchAction;

/**
 *  设置导航栏的的标题 和左边的按钮 图片
 *
 *  @param title      标题
 *  @param  imgName 图片名
 *  @param leftAction 左边按钮点击事件
 *  @param rightAction 按钮点击事件
 *  @param rightTxt 按钮标题
 */

-(void)initNaviItem:(NSString*)title leftImg:(NSString *)imgName action:(SEL)leftAction action:(SEL)rightAction rtitle:(NSString *)rightTxt;

/**
 *  设置导航栏右边按钮和导航栏的标题
 *  初始化带右侧文字的导航栏
 *  @param title       导航栏标题
 *  @param rightText   导航栏右边的按钮标题
 *  @param rightAction 导航栏右边的点击事件
 */
-(void)initNaviItemWithRightText:(nullable NSString*)title rightText:(nullable NSString*)rightText
                          action:(nullable SEL)rightAction;

// 删除导航栏下面的黑线
//-(void)deleteNavigateLine;

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
// 判断自己是否是四个TabBar的根VC
-(BOOL)isTabBarController;

// 当前VC中的ReturnKey事件不处理
- (void)disableIQReturnKey;

// 使指定的View不处理ReturnKey
-(void)disableIQReturnKeyHandlerForView:(nullable UIView*)view;

/**
 *  设置导航栏的的标题   仅设置标题
 *
 *  @param title      标题
 *  @param
 */
-(void)setNaviItem:(NSString*)title ;
/**
 *  只有返回键和标题
 *
 *  @param titleString 标题
 *  @param backAction  返回事件
 */
- (void)setUpNavigateItemsWithTitleString:(nullable NSString *)titleString BackAction:(nullable SEL)backAction;
/**
 *  左边橙色返回键右边按钮是文字
 *
 *  @param titleString       titleString description
 *  @param backAction        backAction description
 *  @param rightTitle        rightTitle description
 *  @param rightButtonAction rightButtonAction description
 */
- (void)setUpNavigateItemsWithTitleString:(nullable NSString *)titleString BackAction:(nullable SEL)backAction RightTitleString:(nullable NSString *)rightTitle RightAction:(nullable SEL)rightButtonAction;

/**
 *  可设置右边按钮的颜色
 *
 *  @param titleString       标题
 *  @param backAction        返回事件
 *  @param rightTitle        右边按钮
 *  @param rightButtonAction 右边点击事件
 *  @param color             右侧按钮颜色
 */
- (void)setUpNavigateItemsWithTitleString:(nullable NSString *)titleString BackAction:(nullable SEL)backAction RightTitleString:(nullable NSString *)rightTitle RightAction:(nullable SEL)rightButtonAction RightButtonColor:(nullable UIColor *)color;

/**
 *  左边橙色返回键右边按钮是图片
 *
 *  @param titleString            标题
 *  @param backAction             返回事件
 *  @param rightButtonImageString 右侧图标icon
 *  @param rightButtonAction      右侧点击事件
 */
- (void)setUpNavigateItemsWithTitleString:(nullable NSString *)titleString BackAction:(nullable SEL)backAction RightButtonImageString:(nullable NSString *)rightButtonImageString RightAction:(nullable SEL)rightButtonAction;
//  左右 都是图片 按钮  
- (void)setUpNavWithTitle:(NSString *)title BackAction:(SEL)backAction image:(NSString *)imageName RightBtnImageName:(NSString *)rightBtnImgName RightAction:(SEL)rightBtnAction;

- (void)setUpNavigateItemsWithTitleString:(nullable NSString *)titleString;

@end


#endif /* TestController_h */
