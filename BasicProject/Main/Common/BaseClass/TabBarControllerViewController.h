//
//  TabBarControllerViewController.h

//

#import <UIKit/UIKit.h>


@interface TabBarControllerViewController : UITabBarController

//- (void)jumpToChatList;
+ (TabBarControllerViewController*)sharedInstance;
// 联系人与会话列表
@property (nonatomic, strong) UIViewController *contactViewVC;
@property (nonatomic, strong) UIViewController *conversationListVC;
// MichaelTang add from v1.2
@property (nonatomic, strong) UIViewController *interviewListVC;

@end
