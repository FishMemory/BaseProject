//
//  TestController.m
//   
//
//  Created by Michael on 16/5/16.
//  Copyright © 2016年  . All rights reserved.
//
#import "BaseController.h"
#import "APPHeader.h"
#import "AppHelper.h"
#import "UriParser.h"
#import "IQKeyboardReturnKeyHandler.h"

#define FONT_PS(pt)(PX(pt/2.0f))

#define DONE_BUTTON_TAG 1234

// ================== 未实现
// 1. BaseControll titleBar设置，左边返回，右边字体或图标，中间title
// 2. 自动action处理
// 3. 自动添加一个pannel
// 4. 通过方法来自动将View添加到pannel里
// 5. 一些共通的方法

@interface BaseController()
{
    BOOL isVisible;
    UILabel * titleLabel;
    UIButton * rButton;
    MBProgressHUD *progress;
}
@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;
@end

@implementation BaseController


#pragma 重写init注册通知,dealloc释放通知两者必须成对出现,否则crash
-(instancetype)init
{
    self = [super init];
    if(self)
    {
        // 推送消息跳转处理
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultNotifyActionProcess:) name:PUSH_MSG_BOOT_TASK_NOTIFICATION object:nil];
        // App后台还是前台变化通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultAppStatusChange:) name:APP_STATUS_CHANGE_NOTIFICATION object:nil];
        
        isVisible = NO;
        __viewName = [self getPageClassName];
    }
    return self;
}

-(void)dealloc
{
    // 推送消息跳转处理
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PUSH_MSG_BOOT_TASK_NOTIFICATION object:nil];
    // App后台还是前台变化通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:APP_STATUS_CHANGE_NOTIFICATION object:nil];
}

/**
 设置统计时页面的名字
 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)setPageName:(NSString*)pageName
{
    __viewName = pageName;
}

#pragma mark  --获取当前类名-->
-(NSString *)getPageClassName{
    NSString*  pageClassName =  [NSString stringWithFormat:@"%@",[self class]];
    return pageClassName;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    APP.currentController = self;
    [APP onPageAppear:__viewName];
    //  页面统计
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
    [APP onPageDisappear:__viewName];
    //  页面统计
}
// 在View显示出来之前，注册所有的TextView和TextField的returnKey事件
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    APP.currentController = self;
    
    // 注册Next和Done按键
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    // 如果子类VC实现了TextViewDeletage，我们需要将代理传给returnKeyHandler，因为returnKeyHandler它也要处理代理事件
    if([self conformsToProtocol: @protocol (UITextViewDelegate)] || [self conformsToProtocol: @protocol (UITextFieldDelegate)]){
        id delegate = self;
        self.returnKeyHandler.delegate = delegate;
    }
}


/**
 直接关闭当前VC所有的TextView或TextField ReturnKey事件关闭
 注意：该方法只能在viewDidAppear里调用 ，并且需要先调用[super viewDidAppear:ani];
 如果没有调用[super viewDidAppear:ani];，则默认不开ReturnKey事件
 */
- (void)disableIQReturnKey
{
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDefault;
    self.returnKeyHandler = nil;
}

/**
 将指定的TextView或TextField的ReturnKey事件关闭
 可用于：
 1. 需要自己处理TextView或TextField的Delegate事件
 2. 需要使用TextView或TextField默认的ReturnKey事件
 注意：该方法只能在viewDidAppear里调用 ，并且需要先调用[super viewDidAppear:ani];
 如果没有调用[super viewDidAppear:ani];，则默认不开ReturnKey事件
 */
-(void)disableIQReturnKeyHandlerForView:(UIView*)view
{
    [self.returnKeyHandler removeTextFieldView:view];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
     self.navigationController.navigationBarHidden = NO;
    self.returnKeyHandler = nil;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNaviBarBkg:[UIColor whiteColor]];
    [self setNavItemLeftHidden:YES];
}




-(void)async_task:(CGFloat)delay exeBlk:(void (^_Nonnull)(void))exeBlk
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), exeBlk);
}

-(void)setTitle:(NSString*)title{
    titleLabel.text = title;
}

-(void)setRightText:(NSString*)rText
{
    [rButton setTitle:rText forState:UIControlStateNormal];
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    //    UIView *frontView = [[window subviews] objectAtIndex:0];
    //    id nextResponder = [frontView nextResponder];
    //
    //    if ([nextResponder isKindOfClass:[UIViewController class]])
    //        result = nextResponder;
    //    else
    //        result = window.rootViewController;
    
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            result = nextResponder;
        }
        else
        {
            result = window.rootViewController;
        }
    }
    
    
    
    return result;
}

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

-(BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
}


// 当App从后台变成前台时，消息处理
-(void)defaultAppStatusChange:(NSNotification*)notify
{
    if(!APP.isInBackground){
        if(_beActiveBlock){
            _beActiveBlock();
            _beActiveBlock = nil;
        }
    }
}

// 消息跳转默认处理，跳转到消息中心
-(void)defaultNotifyActionProcess:(NSNotification*)notify
{
    // 不是当前显示的VC，不处理消息
    if(![self isVisible]){
        return;
    }
    
    if(notify.userInfo == nil || [notify.userInfo count] == 0){
        return;
    }
    // Action已经可以处理，将挂起的Action任务消除
    REMOVE_USER_DEFAULT(KEY_BOOT_TASK);
    
    // 当前VC虽然是活动的，但是在后台，需要当它重新从后台变成前台后再执行Block
    if(APP.isInBackground){
        WS(weakSelf);
        
        // 如果是融云的消息推送，跳转到聊天列表
        NSDictionary* rc = [notify.userInfo objectForKey:KEY_RONG_RC];
        NSDictionary* rongMsg = [notify.userInfo objectForKey:KEY_RONG_MSG];
        NSString* urlAction = [notify.userInfo objectForKey:KEY_ACTION];
        if(rc != nil || rongMsg != nil){
            self.beActiveBlock = ^(void){
                [weakSelf pushToChatListFromRongCloud:weakSelf];
            };
        }else if(urlAction != nil){
            // Application的openURL处理，用来打开action
            self.beActiveBlock = ^(void){
                [[UriParser actionParser] parseActionAndPushViewController:urlAction viewController:weakSelf];
            };
        }else{
            // 友盟的其它消息推送，跳转到消息中心
            self.beActiveBlock = ^(void){
                [weakSelf pushToMessageCenterFromUMeng:weakSelf notify:notify];
            };
        }
    }else{
        
        // From V2.0 为了减少对用户的干扰，App在前端时不跳转
        // 如果是融云的消息推送，跳转到聊天列表
//        NSDictionary* rc = [notify.userInfo objectForKey:KEY_RONG_RC];
//        NSDictionary* rongMsg = [notify.userInfo objectForKey:KEY_RONG_MSG];
//        NSString* urlAction = [notify.userInfo objectForKey:KEY_ACTION];
//        if(rc != nil || rongMsg != nil){
//            [self pushToChatListFromRongCloud:self];
//        }else if(urlAction != nil){
//            // Application的openURL处理，用来打开action
//            [[UriParser actionParser] parseActionAndPushViewController:urlAction viewController:self];
//        }else{
//            // 友盟的消息推送，跳转到消息中心
//            [self pushToMessageCenterFromUMeng:self notify:notify];
//        }
    }
}

/**
 来自融云的推送，跳转到会话列表
 */
-(void)pushToChatListFromRongCloud:(BaseController*)controller
{

}

/**
 * 来自友盟的推送，跳转到消息中心
 */
-(void)pushToMessageCenterFromUMeng:(BaseController*)controller notify:(NSNotification*)notify
{

}

-(BOOL)isTabBarController
{

    return NO;
}

-(BOOL)hasNavigationBar
{
    
    return YES;
}

/** 
 * 设置导航栏背景色
 */
-(void)setNaviBarBkg:(UIColor *)color{
    UIImage * naviBkgImg = [UIImage imageWithColor:color size:CGSizeMake(SCREEN_WIDTH, UNABLE_SPACE_HEIGHT)];
    [[[self navigationController] navigationBar] setBackgroundImage:naviBkgImg forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏背景为不透明
    self.navigationController.navigationBar.translucent = NO;
}
-(void)setStatusBkgStyle:(UIStatusBarStyle *)UIStatusBarStyle{
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initNaviItem:(NSString *)title{
    [self initNaviItem:title action:@selector(backAction)];
}


/**
 *  设置导航栏的的标题   仅设置标题
 *  @param title  标题
 *  @param
 */
-(void)setNaviItem:(NSString*)title {
    titleView *titleLab = [[titleView alloc]initWithFrame:FRAME(0, 0, 30, 30) title:title titleColor:[UIColor blackColor] position:NSTextAlignmentCenter];
    titleLab.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLab;

}

/**
 *  设置导航栏的的标题 和左边的按钮
 *
 *  @param title      标题
 *  @param leftAction 左边按钮点击事件
 */
-(void)initNaviItem:(NSString*)title action:(SEL)leftAction{
    
    titleView *titleLab = [[titleView alloc]initWithFrame:FRAME(0, 0, 44, 30) title:title titleColor:[UIColor blackColor] position:NSTextAlignmentCenter];
    titleLab.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLab;
    
    UIButton * backItem = [UIButton buttonWithType:UIButtonTypeSystem];
    [backItem setTintColor:COL_BLACK_FONT];
    backItem.frame = CGRectMake(0, 0, 44, 30);
    [backItem addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
    [backItem setImage:[UIImage imageNamed:@"ic_nav_back"] forState:UIControlStateNormal];
//    backItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:backItem];
    
    self.navigationItem.leftBarButtonItem = barButton;
    UIButton * rBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rBtn.frame = CGRectMake(0, 0, 44, 44);
    [rBtn setTintColor:COL_BLACK_FONT];
//    rBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rBtn];
}


/**
 *  设置导航栏的的标题 和左边的按钮 图片
 *
 *  @param title      标题
 *  @param  imgName 图片名
 *  @param leftAction 左边按钮点击事件
 *  @param rightAction 按钮点击事件
 *  @param rightTxt 按钮标题
 */

-(void)initNaviItem:(NSString*)title leftImg:(NSString *)imgName action:(SEL)leftAction action:(SEL)rightAction rtitle:(NSString *)rightTxt{
    
    titleView *titleLab = [[titleView alloc]initWithFrame:FRAME(0, 0, 30, 30) title:title titleColor:[UIColor blackColor] position:NSTextAlignmentCenter];
    titleLab.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLab;
    
    UIButton * backItem = [UIButton buttonWithType:UIButtonTypeSystem];
    [backItem setTintColor:COL_BLACK_FONT];
    backItem.frame = CGRectMake(0, 0, 44, 30);
    [backItem addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
    [backItem setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
//    backItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:backItem];
    
    self.navigationItem.leftBarButtonItem = barButton;
    UIButton * rBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rBtn.frame = CGRectMake(0, 0, 44, 44);
    [rBtn setTintColor:COL_BLACK_FONT];
     [rBtn setTitle:rightTxt forState:UIControlStateNormal];
    [rBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
//    rBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rBtn];
}
/**
 *  设置导航栏右边按钮和导航栏的标题
 *
 *  @param title       导航栏标题
 *  @param rightText   导航栏右边的按钮标题
 *  @param rightAction 导航栏右边的点击事件
 */
-(void)initNaviItemWithRightText:(NSString*)title rightText:(NSString*)rightText
                          action:(SEL)rightAction{
    [self initNaviItem:title];
    
    rButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rButton.frame = CGRectMake(0, 0, 80, 44);
    [rButton addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
    [rButton setTitle:rightText forState:UIControlStateNormal];
    rButton.titleLabel.font = FONT(PX(30));
//    rButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rButton setTitleColor:COL_BLACK_FONT forState:UIControlStateNormal];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rButton];
    self.navigationItem.rightBarButtonItem = rightBar;
}
/**
 *  单独设置导航栏右边的按钮
 *
 *  @param rightText   按钮的title
 *  @param rightAction 按钮的事件
 */
- (void)initNaviItemRightButton:(NSString *)rightText action:(SEL)rightAction{
    rButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rButton.frame = CGRectMake(0, 0, 80, 44);
    [rButton addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
    [rButton setTitle:rightText forState:UIControlStateNormal];
    rButton.titleLabel.font = FONT(PX(30));
//    rButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rButton setTitleColor:COL_BLACK_FONT forState:UIControlStateNormal];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rButton];
    self.navigationItem.rightBarButtonItem = rightBar;
}

/**
 导航栏右边的按钮带Image

 @param title
 @param rImage
 @param rightAction
 */
-(void)initNaviItemWithRightImage:(NSString*)title image:(UIImage*)rImage
                           action:(SEL)rightAction{
    [self initNaviItem:title];
    
    rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rButton.frame = CGRectMake(0, 0, 44, 44);
    [rButton addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
    [rButton setImage:rImage forState:UIControlStateNormal];
//    [rButton setTintColor:COL_THEME_BLUE];
//    rButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rButton];
    self.navigationItem.rightBarButtonItem = rightBar;
}

#pragma mark-    <--搜索栏-->
-(void)initNaviItemWithSearchBar:(SEL)searchAction{
    // 搜索文本区背景
    UIView *naview = [[UIView alloc]initWithFrame:FRAME(15, 0, 230, 30)];
    //    naview.backgroundColor = COL_BKG_GRAY;
    naview.layer.borderColor = [UIColor whiteColor].CGColor;
    naview.layer.borderWidth = 1;
    naview.layer.masksToBounds = YES;
    naview.layer.cornerRadius = 15;
    self.navigationItem.titleView  = naview;
    // 左侧搜索图片
    UIButton *searchImg = [UIButton buttonWithType:UIButtonTypeSystem];
    searchImg.frame = FRAME(12, 7, 15, 15);
    [searchImg setImage:[UIImage imageNamed:@"seache_"] forState:UIControlStateNormal];
    searchImg.tintColor = [UIColor whiteColor];
    [naview addSubview:searchImg];
    // 搜索文本区文字
    UITextField  *searchField = [[UITextField alloc]initWithFrame:FRAME(35 ,0, naview.width-15, 30)];
    [searchField setFont:[UIFont italicSystemFontOfSize:15]];
    searchField.text = @"搜索服务主题 / 学校 / 校友";
    searchField.textColor = [UIColor whiteColor];
    [searchField addTarget:self action:searchAction forControlEvents:UIControlEventEditingDidBegin];
    [naview addSubview:searchField];
    //     右边导航按钮
    rButton = [[UIButton alloc]initWithFrame:FRAME(0, 0, 44, 44)];
    [rButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rButton setBackgroundImage:nil forState:UIControlStateNormal];
    [rButton addTarget:self action:searchAction forControlEvents:UIControlEventTouchUpInside];
    [rButton setTitle:@"搜索" forState:UIControlStateNormal];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    // 默认左侧不显示
    UIButton *leftButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *leftbar = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    leftbar.accessibilityElementsHidden = YES;
    self.navigationItem.leftBarButtonItem = leftbar;
}

-(void)setNavItemLeftHidden:(BOOL)hidden{
    if (hidden) {
        UIButton *buf = [UIButton buttonWithType:UIButtonTypeCustom];
        buf.frame = FRAME(0, 0, 30, 30);
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:buf];
        self.navigationItem.leftBarButtonItem = bar;
    }
}
-(void)setNavItemRightHidden:(BOOL)hidden{
    if (hidden) {
        UIButton *buf = [UIButton buttonWithType:UIButtonTypeCustom];
        buf.frame = FRAME(0, 0, 30, 30);
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:buf];
        self.navigationItem.rightBarButtonItem = bar;
    }
}

#pragma -- 删除navigationController 底部的下划线
//-(void)deleteNavigateLine{
//    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//        NSArray *list=self.navigationController.navigationBar.subviews;
//        for (id obj in list) {
//            if ([obj isKindOfClass:[UIImageView class]]) {
//                UIImageView *imageView=(UIImageView *)obj;
//                NSArray *list2=imageView.subviews;
//                for (id obj2 in list2) {
//                    if ([obj2 isKindOfClass:[UIImageView class]]) {
//                        UIImageView *imageView2=(UIImageView *)obj2;
//                        imageView2.hidden=YES;
//                    }
//                }
//            }
//        }
//    }
//}

#pragma mark - 检查用户登录状态 如果未登录，调到登录界面，返回NO
- (BOOL)checkLoginStatus{
        NSString *tokenString =  APP.token;
    if (!(tokenString.length > 0)) {
        if (!self.navigationController) {
            if (!self.navigationController) {
                SHOW_WARN_INFO(self.view.window, 2, @"您还没有登录");
            }
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@" " message:@"检测到您还未登录！" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                LoginVC *login = [[LoginVC alloc]init];
//                BaseUINavigationController * navigation = [[BaseUINavigationController alloc]initWithRootViewController:login];
//                [self presentViewController:navigation animated:YES completion:^{
//
//                }];
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [alert addAction:confirmAction];
        }
        
        
        return NO;
    }else{
        return YES;
    }
}


/**
 如果两次相同请求间隔不超过3秒，则提示用户
 */
-(BOOL)multiQuickAction:(NSString*)action minDelay:(NSInteger)delay
{
    // 上次请求的URL地址
    static NSString * lastRequestURL = nil;
    // 上次请求的时间
    static NSTimeInterval lastTime = 0;
    
    NSTimeInterval now =[[NSDate date] timeIntervalSince1970];
    
    // 如果两次相同请求间隔不超过3秒，则提示用户
    if(lastRequestURL != nil && [lastRequestURL isEqualToString:action] && now - lastTime < delay){
        return YES;
    }
    
    lastTime = now;
    lastRequestURL = action;
    return NO;
}

- (void)setUpNavigateItemsWithTitleString:(nullable NSString *)titleString{
    [self setUpNavigateItemsWithTitleString:titleString BackAction:@selector(backAction)];
}
// 导航栏back建
- (void)setUpNavigateItemsWithTitleString:(NSString *)titleString BackAction:(SEL)backAction{
    UIButton * backbarItem = [UIButton buttonWithType:UIButtonTypeSystem];
    [backbarItem setTintColor:COL_BLACK_FONT];
    backbarItem.frame = FRAME(0, 0, 44, 30);
//    backbarItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backbarItem addTarget:self action:backAction forControlEvents:UIControlEventTouchUpInside];
    [backbarItem setImage:[UIImage imageNamed:@"ic_nav_back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbarItem];
    UILabel * titlesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    titlesLabel.textColor = COL_BLACK_FONT;
    titlesLabel.text = titleString;
    titlesLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titlesLabel;
}
// 导航栏back建 右侧按钮 文字标题
- (void)setUpNavigateItemsWithTitleString:(NSString *)titleString BackAction:(SEL)backAction RightTitleString:(NSString *)rightTitle RightAction:(SEL)rightButtonAction{
    UIButton * backbarItem = [UIButton buttonWithType:UIButtonTypeSystem];
    [backbarItem setTintColor:COL_BLACK_FONT];
    backbarItem.frame = FRAME(0, 0, 44, 30);
//    backbarItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backbarItem addTarget:self action:backAction forControlEvents:UIControlEventTouchUpInside];
    [backbarItem setImage:[UIImage imageNamed:@"ic_nav_back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbarItem];
    UILabel * titlesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    titlesLabel.textColor = [UIColor blackColor];
    titlesLabel.text = titleString;
    titlesLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titlesLabel;
    
    UIButton * rightBt = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBt.frame = CGRectMake(0, 0, PX(150), PX(60));
    [rightBt setTintColor:COL_BLACK_FONT];
    [rightBt setTitle:rightTitle forState:UIControlStateNormal];
    rightBt.titleLabel.font = FONT(PX(30));
    rightBt.contentMode = UIControlContentHorizontalAlignmentRight;
//    rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBt addTarget:self action:rightButtonAction forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
}
// 导航栏back建 右侧按钮 文字标题 右侧文字颜色
- (void)setUpNavigateItemsWithTitleString:(nullable NSString *)titleString BackAction:(nullable SEL)backAction RightTitleString:(nullable NSString *)rightTitle RightAction:(nullable SEL)rightButtonAction RightButtonColor:(nullable UIColor *)color{
    UIButton * backbarItem = [UIButton buttonWithType:UIButtonTypeSystem];
    [backbarItem setTintColor:COL_BLACK_FONT];
    backbarItem.frame = FRAME(0, 0, 44, 30);
//    backbarItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backbarItem addTarget:self action:backAction forControlEvents:UIControlEventTouchUpInside];
    [backbarItem setImage:[UIImage imageNamed:@"ic_nav_back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbarItem];
    UILabel * titlesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    titlesLabel.textColor = COL_BLACK_FONT;
    titlesLabel.text = titleString;
    titlesLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titlesLabel;
    
    UIButton * rightBt = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBt.frame = CGRectMake(0, 0, PX(150), PX(60));
    [rightBt setTintColor:color];
    [rightBt setTitle:rightTitle forState:UIControlStateNormal];
    rightBt.titleLabel.font = FONT(PX(30));
    rightBt.contentMode = UIControlContentHorizontalAlignmentRight;
//    rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBt addTarget:self action:rightButtonAction forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
}


// 导航栏back建 右侧按钮icon
- (void)setUpNavigateItemsWithTitleString:(NSString *)titleString BackAction:(SEL)backAction RightButtonImageString:(NSString *)rightButtonImageString RightAction:(SEL)rightButtonAction{
    UIButton * backbarItem = [UIButton buttonWithType:UIButtonTypeSystem];
    [backbarItem setTintColor:COL_BLACK_FONT];
    backbarItem.frame = FRAME(0, 0, 44, 30);
//    backbarItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backbarItem addTarget:self action:backAction forControlEvents:UIControlEventTouchUpInside];
    [backbarItem setImage:[UIImage imageNamed:@"ic_nav_back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbarItem];
    UILabel * titlesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    titlesLabel.textColor = COL_BLACK_FONT;
    titlesLabel.text = titleString;
    titlesLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titlesLabel;
    
    UIButton * rightBt = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBt.frame = CGRectMake(0, 0, 30, 30);
    [rightBt setTintColor:COL_BLACK_FONT];
    [rightBt setImage:[UIImage imageNamed:rightButtonImageString] forState:UIControlStateNormal];
    rightBt.titleLabel.font = FONT(PX(30));
    rightBt.contentMode = UIControlContentHorizontalAlignmentRight;
//    rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBt addTarget:self action:rightButtonAction forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
}

// 导航栏左边图片  右侧按钮icon
- (void)setUpNavWithTitle:(NSString *)title BackAction:(SEL)backAction image:(NSString *)imageName RightBtnImageName:(NSString *)rightBtnImgName RightAction:(SEL)rightBtnAction{
    UIButton * backbarItem = [UIButton buttonWithType:UIButtonTypeSystem];
    [backbarItem setTintColor:COL_BLACK_FONT];
    backbarItem.frame = FRAME(0, 0, 44, 30);
//    backbarItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backbarItem addTarget:self action:backAction forControlEvents:UIControlEventTouchUpInside];
    [backbarItem setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbarItem];
    
    
    UIButton * rightBt = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBt.frame = CGRectMake(0, 0, 30, 30);
    [rightBt setTintColor:COL_BLACK_FONT];
    [rightBt setImage:[UIImage imageNamed:rightBtnImgName] forState:UIControlStateNormal];
    rightBt.titleLabel.font = FONT(PX(30));
//    rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBt addTarget:self action:rightBtnAction forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    
    UILabel * titlesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    titlesLabel.textColor = COL_BLACK_FONT;
    titlesLabel.text = title;
    titlesLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titlesLabel;
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createProgress{
    if(progress != nil){
        [self dismissProgress];
    }
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    progress = [[MBProgressHUD alloc] initWithView:delegate.window];
    progress.yOffset = _offsetY;
    [progress show:YES];
    [delegate.window addSubview:progress];
}

-(void)showProgress{
    [self createProgress];
    progress.dimBackground = YES;
}

-(void)dismissProgress{
    [progress hide:YES];
    [progress removeFromSuperview];
    progress = nil;
}


-(void)showWarnText:(NSString*) text{
    [self createProgress];
    progress.labelText = text;
    progress.margin = 12.f;
    progress.mode = MBProgressHUDModeCustomView;
    progress.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_tips_dialog"]];
    [progress hide:YES afterDelay:DEFAULT_TIMEOUT];
}

-(void)showConfirmText:(NSString*) text{
    [self createProgress];
    progress.mode = MBProgressHUDModeCustomView;
    progress.labelText = text;
    progress.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    [progress hide:YES afterDelay:DEFAULT_TIMEOUT];
}

- (void)setProgressOffsetY:(CGFloat)y
{
    _offsetY = y;
}
-(void)goBackPage{
    //    根据传的类名参数 back回到那个类去  SongYaQing add
    if (self.pushClassName.length > 0 ) {
        Class clazz = NSClassFromString(self.pushClassName);
        NSArray *array =  self.navigationController.viewControllers;
        for (UIViewController *vc  in  array) {
            if ([vc isKindOfClass:[clazz class]] ) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
// 默认不能旋转
-(BOOL)shouldAutorotate
{
    return NO;
}

-(CGFloat)NavBarHeight{
    // 状态栏(statusbar)
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    //标题栏
    CGRect NavRect = self.navigationController.navigationBar.frame;
    return StatusRect.size.height+NavRect.size.height;
}
-(CGFloat)TabBarHeight{
    if (IPHONE_X) {
        return 34;
    }
    return 0;
}
//// 默认只支持竖屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    // Return the orientation you'd prefer - this is what it launches to. The
    // user can still rotate. You don't have to implement this method, in which
    // case it launches in the current orientation
    return UIInterfaceOrientationPortrait;
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window)   {// 是否是正在使用的视图
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}
@end

