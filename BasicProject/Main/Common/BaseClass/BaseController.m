//
//  TestController.m
//
//
//  Created by 宋亚清 on 16/5/16.
//  Copyright © 2016年  . All rights reserved.
//
#import "BaseController.h"
#import "APPHeader.h"
#import "AppHelper.h"
#import "UriParser.h" 

#define FONT_PS(pt)(PX(pt/2.0f))

#define DONE_BUTTON_TAG 1234


@interface BaseController()
{
    BOOL isVisible;
    
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
        isVisible = NO;
        __viewName = [self getPageClassName];
    }
    return self;
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.returnKeyHandler = nil;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self needNavigationBar]) {
        [self creartNavigationBarWithTitle:@""];
    }
    self.myNavigationBar.line.hidden = NO;
    [self.myNavigationBar.backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [self.myNavigationBar.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
}

//设置注册 登录页的导航栏样式
-(void)setLoginControllerType{
    self.view.backgroundColor = [UIColor whiteColor];
    self.myNavigationBar.backgroundColor =[UIColor whiteColor];
    [self.myNavigationBar.backBtn setImage:[UIImage imageNamed:@"back_icon_black"] forState:UIControlStateNormal];
    self.myNavigationBar.line.hidden = YES;
    self.myNavigationBar.navigationTitle.textColor = UIColorFromRGBA(0x595959, 1);
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController &&
        !self.navigationController.isNavigationBarHidden) {
        self.navigationController.navigationBarHidden = YES;
    }
    APP.currentController = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)creartNavigationBarWithTitle:(NSString*)title{
    self.myNavigationBar = [[[NSBundle mainBundle]loadNibNamed:@"MyNavigationBar" owner:self options:nil]lastObject];
    self.myNavigationBar.navigationTitle.text = title;
    self.myNavigationBar.frame = FRAME(0, 0, self.view.width, kTopSafeHeight);
    [self.view addSubview:self.myNavigationBar];
    [self.view bringSubviewToFront:self.myNavigationBar];
}

-(BOOL)needNavigationBar{
    return YES;
}

-(void)setNavBarTitle:(NSString*)title{
    self.myNavigationBar.navigationTitle.text = title;
}

-(void)setPageName:(NSString*)pageName
{
    __viewName = pageName;
}

#pragma mark  --获取当前类名-->
-(NSString *)getPageClassName{
    NSString*  pageClassName =  [NSString stringWithFormat:@"%@",[self class]];
    return pageClassName;
}


// 在View显示出来之前，注册所有的TextView和TextField的returnKey事件
-(void)viewDidAppear:(BOOL)animated {
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

-(void)async_task:(CGFloat)delay exeBlk:(void (^_Nonnull)(void))exeBlk
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), exeBlk);
}

-(void)setTitle:(NSString*)title{
    self.myNavigationBar.navigationTitle.text = title;
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


-(BOOL)isTabBarController
{
    return NO;
}


/**
 * 设置导航栏背景色
 */
-(void)setNaviBarBkg:(UIColor *)color{
    [self.myNavigationBar.layer addSublayer:[CAGradientLayer layer]];
    self.myNavigationBar.backgroundColor = color;
}

-(void)setNavBarBkgchangeCol:(NSArray*)colors{
    [self.myNavigationBar setViewLayerThemeColors:CGSizeMake(SCREEN_WIDTH, self.myNavigationBar.height)];
    [self.myNavigationBar bringSubviewToFront: self.myNavigationBar.centerView];
    //    UIImage * naviBkgImg = [UIImage ImageWithColorsSize:CGSizeMake(SCREEN_WIDTH, kTopSafeHeight)];
    //    [[[self navigationController] myNavigationBar] setBackgroundImage:naviBkgImg forBarMetrics:UIBarMetricsDefault];
}

-(void)setStatusBkgStyle:(UIStatusBarStyle *)UIStatusBarStyle{
    [[UIApplication sharedApplication] setStatusBarStyle:*UIStatusBarStyle];
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


#pragma mark-    <--搜索栏-->
-(void)initNaviItemWithSearchBarPlace:(NSString*)placeh action:(SEL)searchAction{
    // 搜索文本区背景
    _naview = [[UIView alloc]initWithFrame:FRAME(10, kTopSafeHeight-42, SCREEN_WIDTH-20, 30)];
    _naview.backgroundColor = rgb(52, 58, 75);
    _naview.layer.masksToBounds = YES;
    _naview.layer.cornerRadius = 5;
    [self.myNavigationBar addSubview:_naview];
    // 左侧搜索图片
    UIButton *searchImg = [UIButton buttonWithType:UIButtonTypeCustom];
    searchImg.frame = FRAME(13, 8, 12, 12);
    [searchImg setImage:ImageNamed(@"search") forState:UIControlStateNormal];
    //    searchImg.tintColor = rgb(52, 58, 75);
    [_naview addSubview:searchImg];
    // 搜索文本区文字
    UITextField  *searchField = [[UITextField alloc]initWithFrame:FRAME(33 ,0, _naview.width-15, 30)];
    [searchField setFont:[UIFont systemFontOfSize:14]];
    searchField.textColor = UIColorFromRGBA(0x8F96A5, 1);
    searchField.placeholder = placeh;
    [searchField setValue:UIColorFromRGBA(0x8F96A5, 1) forKeyPath:@"_placeholderLabel.textColor"];
    //    [searchField addTarget:self action:searchAction forControlEvents:UIControlEventTouchUpInside];
    [searchField addTarget:self action:@selector(inputEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [_naview addSubview:searchField];
    if ([self showSearchTouchBtn]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = searchField.bounds;
        [button addTarget:self action:searchAction forControlEvents:UIControlEventTouchUpInside];
        [_naview addSubview:button];
    }
    
    
    //    [UIImage imageWithColor:<#(UIColor *)#> size:<#(CGSize)#>]
    //    UIButton *right = [UIButton  buttonWithType:UIButtonTypeCustom];
    //    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc]initWithCustomView:right];
    //    rightbar.accessibilityElementsHidden = YES;
    //    self.navigationItem.rightBarButtonItem = rightbar;
    //
    //    // 默认左侧不显示
    //    UIButton *leftButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    //    UIBarButtonItem *leftbar = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    //    leftbar.accessibilityElementsHidden = YES;
    //    self.navigationItem.leftBarButtonItem = leftbar;
}

//-(void)initNavBarSearch:(NSString*)palceH {
//    [self setNaviItem:@""];
//    self.myNavigationBar.line.hidden = NO;
//    [self initNaviItemWithSearchBarPlace:palceH  action:@selector(searchInputAction:)];
//    self.naview.width = SCREEN_WIDTH -20 -80;
//    UIButton *right = [UIButton  buttonWithType:UIButtonTypeCustom];
//    right.titleLabel.font = FONT(PX(36));
//    right.frame = FRAME(SCREEN_WIDTH - 80, 0, 80, 44);
//    [right setTitle:@"Cancel" forState:UIControlStateNormal];
//    [right setTitleColor:rgb(59, 59, 59) forState:UIControlStateNormal];
//    [right addTarget:self action:@selector(cancelAct) forControlEvents:UIControlEventTouchUpInside];
//}

-(BOOL)showSearchTouchBtn{
    return NO;
}
-(void)inputEnd:(UITextField*)field{
    
}
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

// 默认不能旋转
-(BOOL)shouldAutorotate {
    return NO;
}

//// 默认只支持竖屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(MJRefreshNormalHeader*)initiMJheader:(SEL)action {
    MJRefreshNormalHeader *mjheader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:action];
    mjheader.automaticallyChangeAlpha = YES;
    
    mjheader.lastUpdatedTimeLabel.hidden = YES;
    //    [mjheader setTitle:MJRefreshHeaderIdleText forState:MJRefreshStateIdle];
    //    [mjheader setTitle:MJRefreshHeaderPullingText forState:MJRefreshStatePulling];
    //    [mjheader setTitle:MJRefreshHeaderRefreshingText forState:MJRefreshStateRefreshing];
    return mjheader;
}

-(MJRefreshBackNormalFooter*)inittTabMJfooter:(void(^)(void))refresh{
    MJRefreshBackNormalFooter *mjfooter =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (refresh) {
            refresh();
        }
    }];
    //    [mjfooter setTitle:MJRefreshAutoFooterIdleText forState:MJRefreshStateIdle];
    //    [mjfooter setTitle:MJRefreshBackFooterPullingText forState:MJRefreshStatePulling];
    //    [mjfooter setTitle:MJRefreshAutoFooterRefreshingText forState:MJRefreshStateRefreshing];
    //    [mjfooter setTitle:MJRefreshAutoFooterNoMoreDataText forState:MJRefreshStateNoMoreData];
    return mjfooter;
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window)   {// 是否是正在使用的视图
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}

-(void)backLastPageWith:(NSString*)name{
    Class clas = NSClassFromString(name);
    if (clas == nil) {
        return;
    }
    UIViewController *vc = [[clas alloc] init];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[controller class]]) {
            vc = controller;
            break;
        }
    }
    [self.navigationController popToViewController:vc animated:YES];
}

@end


