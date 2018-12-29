//
//  TabBarControllerViewController.m
//  Copyright © 2016年  . All rights reserved.
#define HOME @"1"
#define CHAT @"2"
#define ME @"3"
#define INTERVIEW @"4"
#define ACTIVITY @"5"

#import "BaseUINavigationController.h"

#import "TabBarControllerViewController.h"


//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface TabBarControllerViewController ()<UITabBarControllerDelegate>
{
    BaseUINavigationController * firstN;
    BaseUINavigationController * interviewN;
    BaseUINavigationController * conversationVC;
    BaseUINavigationController * myInfoN;
    BaseUINavigationController * contactVC;
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
    UIImage * navBackImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, UNABLE_SPACE_HEIGHT)];
    ImageArrays = @[@"chat",@"find",@"home",@"friends",@"user"];
    selectedImageArray =  @[@"chated",@"finded",@"homed",@"friended",@"usered"];
    
    //首页导航
    UIViewController * first = [[UIViewController alloc]init];
    firstN = [[BaseUINavigationController alloc]initWithRootViewController:first];
    [firstN.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
    firstN.tabBarItem = [[UITabBarItem alloc]initWithTitle:HOME image:ImageNamed(ImageArrays[2]) selectedImage:[UIImage imageWithOriginalName:selectedImageArray[2]] ];

 
    UIViewController * interviewVc = [[UIViewController alloc]init];
    self.interviewListVC = interviewVc;
    interviewN = [[BaseUINavigationController alloc]initWithRootViewController:interviewVc];
    [interviewN.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
    interviewN.tabBarItem = [[UITabBarItem alloc]initWithTitle:INTERVIEW image:ImageNamed(ImageArrays[1]) selectedImage:[UIImage imageWithOriginalName:selectedImageArray[1]] ];

    //    交流
    UIViewController *thirdvc = [[UIViewController alloc]init];
    conversationVC = [[BaseUINavigationController alloc]initWithRootViewController:thirdvc];
    [conversationVC.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
    conversationVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:CHAT image:ImageNamed(ImageArrays[0]) selectedImage:[UIImage imageWithOriginalName:selectedImageArray[0]]];

    // 医生圈
    UIViewController * fourVC= [[UIViewController alloc]init];
    contactVC = [[BaseUINavigationController alloc]initWithRootViewController:fourVC];
    [contactVC.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
    contactVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:ACTIVITY  image:ImageNamed(ImageArrays[3]) selectedImage:[UIImage imageWithOriginalName:selectedImageArray[3]]];
    
    //我
    UIViewController * myInfoVC = [[UIViewController alloc]init];
    myInfoN = [[BaseUINavigationController alloc]initWithRootViewController:myInfoVC];
    [myInfoN.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
    myInfoN.tabBarItem = [[UITabBarItem alloc]initWithTitle:ME  image:ImageNamed(ImageArrays[4]) selectedImage:[UIImage imageWithOriginalName:selectedImageArray[4]]];
 
    self.tabBar.translucent = NO;

    
    self.viewControllers = @[conversationVC,interviewN,firstN,contactVC,myInfoN];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, 50)]];
    //    添加推送通知

    //获取未读消息数，此时并没有把self注册为SDK的delegate，读取出的未读数是上次退出程序时的
    //    [self didUnreadMessagesCountChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPersonUnReadMessageCount) name:@"setPersonUnReadMessageCount" object:nil];
    [self setupUnreadMessageCount];
    [self setupUntreatedApplyCount];
    [self getMessageData];
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
    att[NSForegroundColorAttributeName] = COL_THEME_BLUE;
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    [self getData];
}


-(void)tabBarItemClicked:(UIButton *)item
{
 
}

-(void)removeBtn{
//    self.button.hidden = YES;
//    [self.button removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getData{
    NSDictionary * d = @{@"banner.type":@1};
    [HttpServices post:@"" _id:nil showBackProgressHD:NO token:APP.token showError:NO dataDic:d success:^(id jsonObj, Pagination *page) {
        // 异步下载图片并保存
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *imageArray =  [jsonObj objectForKey:@"values"];
            
            NSDictionary * oldImage =  GET_OBJ_FROM_USER_DEFAULT(@"boot_img");
            NSArray *oldImageArray =  [oldImage objectForKey:@"values"];
            
            
            for (NSDictionary * newDic in imageArray) {
                NSString* newPath = [newDic objectForKey:@"imgurl"];
//                NSLog(@"引导图：%@", newPath);
                bool isChange = YES;
                for (NSDictionary * imgDic in oldImageArray) {
                    if([newPath isEqualToString:[imgDic objectForKey:@"imgurl"]]){
                        isChange = NO;
                        break;
                    }
                }
                if(isChange){
                    NSMutableArray * newImageArray = [[NSMutableArray alloc]initWithCapacity:1];
                    
                    for (NSDictionary * imgDic in imageArray) {
                        // 下载新的图片
                        NSString * download = [NSString stringWithFormat:@"%@/%@", ServiceHead, [imgDic objectForKey:@"imgurl"]];
                        NSLog(@"开始下载新的引导图：%@", download);
                        NSString* path = [self downloadImage:download];
//                        NSLog(@"下载完毕：%@", path);
                        [newImageArray addObject:path];
                    }
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isTheFirst"];
                    SAVE_TO_USER_DEFAULT(jsonObj, @"boot_img");
                    SAVE_TO_USER_DEFAULT(newImageArray, @"guide_img");
                    return;
                }else{
//                    NSLog(@"引导图没有更新");
                }
            }
        });
    } apiErroBlock:nil networkErroBlock:nil];
}

 
#pragma 同步下载文件 文件保存在沙盒相对路径下
-(NSString*)downloadImage:(NSString*)url
{
    //第一步:创建URL
    NSURL *pURL = [NSURL URLWithString:url];
    
    //第二步:创建一个请求
    NSURLRequest *pRequest = [NSURLRequest requestWithURL:pURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    
    //第三步:建立连接
    NSError *pError = nil;
    NSURLResponse *pRespond = nil;
    //向服务器发起请求（发起之后,线程就会一直等待服务器响应,直到超出最大响应时间)
    NSData *pData = [NSURLConnection sendSynchronousRequest:pRequest returningResponse:&pRespond error:&pError];
    
    //输出获取结果
    //    NSLog(@"pData = %@",pData);
    if(pError != nil){
        return nil;
    }
    
    NSString * fileName = [url lastPathComponent];
    //    [url md5String]
    NSString *filePath = [SANDBOX_PATH stringByAppendingPathComponent:@"download"];
    // 不存在目录，创建之
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        if(![[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil]){
            return nil;
        }
    }
    filePath = [filePath stringByAppendingPathComponent:fileName];
    
    if([pData writeToFile:filePath atomically:YES])
        return [@"download" stringByAppendingPathComponent:fileName];
    else
        return nil;
    
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


// 统计未读消息数
-(void)setupUnreadMessageCount
{
//    NSInteger unreadCount = 0;
    NSInteger unreadInterviewCount = 0;
    NSInteger unreadConversationCount = 0;
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:(unreadConversationCount + unreadInterviewCount)];
}

- (void)setupUntreatedApplyCount
{
    NSInteger unreadCount = 0;
    if (contactVC) {
        if (unreadCount > 0) {
            contactVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
        }else{
            contactVC.tabBarItem.badgeValue = nil;
        }
    }
}
-(void)getMessageData{
 
}
- (void)setPersonUnReadMessageCount{
    NSInteger unreadCount = APP.myMsgCount;
    if (myInfoN) {
        if (unreadCount > 0) {
            myInfoN.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
        }else{
            myInfoN.tabBarItem.badgeValue = nil;
        }
    }
}


- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    lastPlaySoundDate = [NSDate date];
}


@end
