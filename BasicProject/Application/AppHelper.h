//
//  
//
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define KEY_DEVICE_TOKEN @"_UMENG_DEVICE_TOKEN_"
#define KEY_AGE @"age"
#define KEY_CASE_ID @"caseId"
#define KEY_HEADER @"header"
#define KEY_NAME @"name"
#define KEY_NICK @"nick"
#define KEY_SEX @"sex"

@interface AppHelper : NSObject<UINavigationBarDelegate>
+ (AppHelper*)sharedManager;

/** 消息状态机
 */
-(void)setIMMsgState:(BOOL)hasNew count:(NSInteger)count;
-(void)setPushMsgState:(BOOL)hasNew count:(NSInteger)count;

/**
 * 当View消失的时候调用,统计用户行为
 * 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)onPageAppear:(NSString* )key;

/**
 * 当View消失的时候调用,统计用户行为
 * 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)onPageDisappear:(NSString* )key;

/**
 * 当用户执行操作的时候,统计用户行为
 * 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)onEvent:(NSInteger) type key:(NSString* )key value:(NSString *)value;

/**
 * 将数据提交给服务器
 * 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)submitLog;

/**
 是否显示IAP
 */
@property(nonatomic,assign)BOOL showIAP;

/**
 至少间隔30秒检查是否有新消息
 */
-(void)checkNewMessage:(BOOL)forceUpdate success:(void(^__strong)(void))success;
@property (assign, nonatomic) BOOL hasNewCustomServiceMsg;
@property (assign, nonatomic) BOOL showSelectBtn;/**< 是否显示提问按钮 >*/
//@property(nonatomic,assign)NSInteger discoverSelectIndex;/**<  发现页面选择标签标记 >*/
@property(nonatomic,strong)NSString *discoverURL;/**<  发现页面访问url >*/
@property(nonatomic,assign)BOOL hasNewIMMsg;
@property(nonatomic,assign)BOOL hasNewPushMsg;
@property(nonatomic,assign)NSInteger newPushMsgCount;
@property(nonatomic,assign)NSInteger newIMMsgCount;
@property(nonatomic,strong)NSNumber * alumni_number; /**< 校友ID >*/
@property(nonatomic,assign)NSInteger alumniStatusCode;/**< 校友的审核状态 >*/
@property(nonatomic,assign)BOOL isHiddenPay;   /**< 是否  隐藏支付  >*/
@property(nonatomic,assign)NSInteger myMsgCount;// 我的消息 未读个数
// APP是否是第一次启动
@property (nonatomic, assign) BOOL isFirstBoot;
@property(nonatomic,strong)UIViewController * currentController;
@property (nonatomic, readonly)  AppDelegate *delegate;
@property (nonatomic, assign)  BOOL isInBackground;
@property (strong, readonly) UIWindow *window;

// 当前环信登录的用户名
@property (strong, nonatomic) NSString *curHXUser;
// 当前环信登录的用户名
@property (strong, nonatomic) NSString *curHXPassword;
// 当前登录的ID
@property (strong, nonatomic) NSNumber *curUserId;
// 当前登录的用户名
@property (strong, nonatomic) NSString *curUserName;
// 当前用户登录的呢称
@property (strong, nonatomic) NSString *curUserNick;
// 当前用户的性别
@property (strong, nonatomic) NSString *curUserSex;
// 当前用户的头像
@property (strong, nonatomic) NSString *curUserHeader;
// 当前用户的年龄
@property (strong, nonatomic) NSNumber *curUserAge;
// 当前登录的用户token
@property (strong, nonatomic) NSString *token; /**< 用户token >*/
// 当前用户登陆信息词典
@property (nonatomic, strong) NSMutableDictionary * currentUserInfo;/**< 当钱用户 >*/
// 是否已经登陆成功
@property (assign, nonatomic) BOOL isLogin; /**< 登录状态 >*/
@property (copy, nonatomic) NSString *countryCode; /**< 国家 区号 >*/
@property (copy, nonatomic) NSString *mobile; /**< 手机号 >*/
@property (copy, nonatomic) NSString *mobileWithCountryCode; /**< 全部的手机号+区号 >*/
@property (assign, nonatomic) BOOL YueDaOpened;
@property (nonatomic,strong) NSDateFormatter * dateFomateHandler;

-(void)setDateHandlerWithString:(NSString * )formatString;
// EM退出登录时调用 
-(void)emLogout;


/*
 清除所有的存储本地的数据
 */
-(void)clearAllUserDefaultsData;

@end

