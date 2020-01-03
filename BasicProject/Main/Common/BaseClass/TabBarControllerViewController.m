//
//  TabBarControllerViewController.m
//  Copyright © 2016年  . All rights reserved.
#define MESSAGE @"消息"
#define WORK @"工作台"
#define ME @"我的"

#import "BaseUINavigationController.h"
#import "TabBarControllerViewController.h"
//#import "MessageVC.h"
//#import "WorkBenchVC.h"
//#import "MineVC.h"

//两次提示的默认间隔
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface TabBarControllerViewController ()<UITabBarControllerDelegate>
{
    BaseUINavigationController * messageNa;
    BaseUINavigationController * workNa;
    BaseUINavigationController * mineNa;
    NSArray *ImageArrays;
    NSArray *selectedImageArray;
    BOOL switchTabBar;
    NSDate *lastPlaySoundDate;
}
@end

@implementation TabBarControllerViewController


+ (TabBarControllerViewController *)sharedInstance {
    //它还接收一个希望在应用的生命周期内仅被调度一次的代码块，对于本例就用于shared实例的实例化。
    //  dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如
    static dispatch_once_t onceQueue;
    static TabBarControllerViewController *appInstance;
    dispatch_once(&onceQueue, ^{
        appInstance = [[TabBarControllerViewController alloc] init];
    });
    return appInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setTranslucent:NO];
    self.delegate = self;
    UIImage * navBackImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, kTopSafeHeight)];
    ImageArrays = @[@"message_u",@"work_u",@"mine_u"];
    selectedImageArray =  @[@"message_s",@"work_s",@"mine_s"];
    UIColor *selectColor = COL_THEME;
    UIColor *normalColor = rgba(34, 34, 34, 1);
    //首页导航
    UIViewController * first = [[UIViewController alloc]init];
    [self addOneChlildVc:first title:MESSAGE imageName:ImageArrays[0] selectedImageName:selectedImageArray[0] itemColor:normalColor itemSelectedColor:selectColor];
    messageNa = [self createNavWith:first image:navBackImage];
    
    UIViewController * work = [[UIViewController alloc]init];
    [self addOneChlildVc:work title:WORK imageName:ImageArrays[1] selectedImageName:selectedImageArray[1] itemColor:normalColor itemSelectedColor:selectColor];
    workNa = [self createNavWith:work image:navBackImage];
    
    UIViewController *mine = [[UIViewController alloc]init];
    [self addOneChlildVc:mine title:ME imageName:ImageArrays[2] selectedImageName:selectedImageArray[2] itemColor:normalColor itemSelectedColor:selectColor];
    mineNa = [self createNavWith:mine image:navBackImage];
    self.tabBar.translucent = NO;
    
    self.viewControllers = @[messageNa,workNa,mineNa];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, 50)]];
}
-(BaseUINavigationController*)createNavWith:(UIViewController*)vc image:(UIImage*)image{
    BaseUINavigationController *nav = [[BaseUINavigationController alloc]initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    return nav;
}


/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName itemColor:(UIColor *)itemcolor itemSelectedColor:(UIColor *)itemselectedcolor
{
    // 设置标题
    childVc.tabBarItem.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = itemselectedcolor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = itemselectedcolor;
    selectedTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    if (@available(iOS 10.0, *)) {
        [[UITabBar appearance] setUnselectedItemTintColor:itemcolor];
    } else {
        // Fallback on earlier versions
    }
    
    // 设置选中的图标
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}


+ (void)initialize {
    // 获取所有的tabBarItem外观标识
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = COL_THEME;
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// 是否支持旋转屏幕
-(BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

// 如果支持旋转屏幕，支持旋转屏幕的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

// 默认屏幕的方向
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController  preferredInterfaceOrientationForPresentation];
}

@end
