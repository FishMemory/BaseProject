//
//  WebViewController.m
//   
//
//  Created by 宋亚清 on 16/4/11.
//  Copyright © 2016年  . All rights reserved.
//

#import "WebViewController.h"
#import "JSAction.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()
{
    UIWebView *myWebView;
    titleView *_titleLab;
}
@end

@implementation WebViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self setNaviBarBkg:COL_THEME_BLUE];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNav];
    [self initViews];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self disableIQReturnKey];
}

-(void)getUrl{
    NSString *shareUrl = self.webURl;
    NSArray *shareArray = [shareUrl componentsSeparatedByString:@"?"];
    NSString *param = [shareArray lastObject];
    NSArray * arr = [param componentsSeparatedByString:@"&"];
    if(arr != nil){
        NSMutableDictionary* argDic = [[NSMutableDictionary alloc] init];
        for(int i = 0; i < [arr count]; i++){
            NSString* str = [arr objectAtIndex:i];
            NSArray* arr2 = [str componentsSeparatedByString:@"="];
            if (!(arr2.count >1)) {
                return;
            }
            NSString * key = [arr2 objectAtIndex:0];
            
            NSString * value = [arr2 objectAtIndex:1];
//            NSLog(@"key = %@, value = %@", key, [value stringByRemovingPercentEncoding]);
            [argDic setValue:value forKey:key];
            
        }
        [argDic setObject:shareUrl forKey:@"shareUrl"];

        
    }
}

-(void)setNav {
    
    [self getUrl];
    
    _titleLab = [[titleView alloc]initWithFrame:FRAME(0, 0, SCREEN_WIDTH-88, 30) title:_navTitle titleColor:[UIColor blackColor] position:NSTextAlignmentCenter];
    self.navigationItem.titleView = _titleLab;
    [_titleLab setColor:COL_BLACK];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:COL_GRAY_WHITE size:CGSizeMake(SCREEN_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *left = [DLButton buttonType:UIButtonTypeSystem frame:FRAME(0, 0, 30, 30) titleColor:COL_BLACK backGroundImage:nil target:self Selector:@selector(webBackAtions) selectorState:UIControlEventTouchUpInside title:@"" cornerRadius:0];
    [left setImage:ImageNamed(@"ic_nav_back") forState:UIControlStateNormal];
//    [left setTintColor:COL_GRAY_WHITE];
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc]initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = backBar;
    
//    if(_shareModel.share == 1){
//        UIButton *right = [DLButton buttonType:UIButtonTypeSystem frame:FRAME(0, 0, 30, 30) titleColor:nil backGroundImage:nil target:self Selector:@selector(webShareUrl) selectorState:UIControlEventTouchUpInside title:@"" cornerRadius:0];
//        [right setImage:ImageNamed(@"share") forState:UIControlStateNormal];
//        [right setTintColor:COL_THEME_BLUE];
//        UIBarButtonItem *rightbar = [[UIBarButtonItem alloc]initWithCustomView:right];
//        right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        self.navigationItem.rightBarButtonItem = rightbar;
//    }else{
        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        right.frame = FRAME(0, 0, 30, 30);
        UIBarButtonItem *rightbar = [[UIBarButtonItem alloc]initWithCustomView:right];
        self.navigationItem.rightBarButtonItem = rightbar;
//    }
    
}
-(void)webShareUrl{
    
    
}
-(void)initViews{
    if(_navigationItemTransparent){
        myWebView = [[UIWebView alloc]initWithFrame:FRAME(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }else{
        myWebView = [[UIWebView alloc]initWithFrame:FRAME(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTopSafeHeight)];
    }
    myWebView.backgroundColor = [UIColor whiteColor];
    
    myWebView.delegate = self;
    
    
    NSString *enstring = [self.webURl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest  *requst = [NSURLRequest requestWithURL:[NSURL URLWithString: enstring]];
    [myWebView loadRequest:requst];
    [self.view addSubview:myWebView];
}

-(void)webBackAtions{
    if (_navigationItemTransparent) {
        self.navigationController.navigationBar.translucent = YES;
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:CLEAR_COLOR size:CGSizeMake(SCREEN_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
    }
    [self goBackPage];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[ProgressHUD  instance] showBackProgressHD:YES inView:self.view info:@"正在加载"];
    
    JSContext* context = [myWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    JSAction * jsAction = [[JSAction alloc]init];
    context[@"NativeObject"] = jsAction;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString  *titleLabel  = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    NSLog(@"网页标题获取: %@",titleLabel);
    _titleLab.labelText = titleLabel.length > 0 ? titleLabel : _navTitle;
    [[ProgressHUD  instance] showBackProgressHD:NO inView:self.view info:@"正在加载"];
  
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([error code] == NSURLErrorCancelled) {
        return;
    }
    if (error){
        SHOW_WARN_INFO(self.view, 2,@"加载出现异常..");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// 默认不能旋转
-(BOOL)shouldAutorotate
{
    return NO;
}

// 默认只支持竖屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

@end
