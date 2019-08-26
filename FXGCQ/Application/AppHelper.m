//
//  HTAppHelper.m
//  LifeCamera
//
//  Created by 宋亚清 on 15/8/14.
//  Copyright (c) 2016年  All rights reserved.
//
#import "AppHelper.h"

//@interface AppHelper()
//{
//    // 当有IM新消息是，设置为YES
//    BOOL hasNewIMMsg;
//    // IM新消息数量
//    BOOL imMsgCount;
//    // 当有订单或系统推送消息时，设置为YES
//    BOOL hasNewPushMsg;
//    // 当有订单或系统推送消息时，消息数量
//    NSInteger pushMsgCount;
//}
//
//@end

@implementation AppHelper
- (id)init {
    self = [super init];
    if (self) {
        // 将App的delegate保存在单例中
        _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString* data = GET_OBJ_FROM_USER_DEFAULT(KEY_HAS_BOOTED);
        self.isFirstBoot = (data == nil || [data isEqualToString:@""]);
        // 如果是第一次启动，则将其值设置为YES
        if(self.isFirstBoot){
            SAVE_TO_USER_DEFAULT(@"YES", KEY_HAS_BOOTED);
            // 统计初次安装量：Apple_install
#ifdef DEBUG
#elif defined PROD
#else
//            [MobClick event:@"apple_install"];
#endif
        }
    }
    return self;
}

+ (AppHelper *)sharedManager {
    //它还接收一个希望在应用的生命周期内仅被调度一次的代码块，对于本例就用于shared实例的实例化。
    //  dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如
    static dispatch_once_t onceQueue;
    static AppHelper *appInstance;
    dispatch_once(&onceQueue, ^{
        appInstance = [[AppHelper alloc] init];
    });
    return appInstance;
}

- (UIWindow *)window {
    return self.delegate.window;
}

/*
 清除所有的存储本地的数据
 */
-(void)clearAllUserDefaultsData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults dictionaryRepresentation];
    for (id key in dict) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize]; 
}

-(NSString*)curUserNick{
    if (!_curUserNick) {
        NSDictionary *dics =  GET_OBJ_FROM_USER_DEFAULT(USERINFO);
        NSString *name = [dics objectForKeyCheck:@"name"];
        _curUserNick = name;
    }
    return _curUserNick;
}
-(NSNumber*)curUserId{
    if (!_curUserId) {
        NSDictionary *dics =  GET_OBJ_FROM_USER_DEFAULT(USERINFO);
        NSNumber *name = [dics objectForKeyCheck:@"id"];
        _curUserId = name;
    }
    return _curUserId;
}

-(NSMutableDictionary *)currentUserInfo{
    if (!_currentUserInfo) {
        NSDictionary *dics =  GET_OBJ_FROM_USER_DEFAULT(USERINFO); 
        _currentUserInfo = [[NSMutableDictionary alloc]initWithDictionary:dics];;
    }
    return _currentUserInfo;
}

/**
 当View显示的时候调用
 */
-(void)onPageAppear:(NSString* )key
{

}
/**
 当View消失的时候调用
 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)onPageDisappear:(NSString* )key
{

}

/**
 当用户执行操作的时候，调用
 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)onEvent:(NSInteger) type key:(NSString* )key value:(NSString *)value
{
}

/**
 将数据提交给服务器
 使用说明：http://123.56.246.186:8382/documents/33
 */
-(void)submitLog
{

}

/**
 当有新的IM消息时，调用该方法，会发送通知
 */
-(void)setIMMsgState:(BOOL)hasNew count:(NSInteger)count
{
    self.hasNewIMMsg = hasNew;
    self.newIMMsgCount = count;
    if(self.hasNewIMMsg){
        [[NSNotificationCenter defaultCenter] postNotificationName:NEW_IM_COUNT_NOTIFICATION object:nil userInfo:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:IM_COUNT_CLEAR_NOTIFICATION object:nil userInfo:nil];
    }
}

/**
 当有新的Push消息时，调用该方法，会发送通知
 */
-(void)setPushMsgState:(BOOL)hasNew count:(NSInteger)count
{
    self.hasNewPushMsg = hasNew;
    self.newPushMsgCount = count;
    if(self.hasNewPushMsg){
        [[NSNotificationCenter defaultCenter] postNotificationName:NEW_MSG_COUNT_NOTIFICATION object:nil userInfo:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_CLEAR_NOTIFICATION object:nil userInfo:nil];
    }
}

-(void)checkNewMessage:(BOOL)forceUpdate success:(void(^__strong)(void))success
{
//    static NSTimeInterval lastUpdateTime = 0;
//    NSTimeInterval now =[[NSDate date] timeIntervalSince1970];
//    
//    // 如果不是强制更新，并且上次更新距离本次更新不到30秒，不去请求
//    if(!forceUpdate && now - lastUpdateTime < 30){
//        return;
//    }
//    
//    lastUpdateTime = now;
//    
//    NSLog(@"更新服务器最新消息");
//    
//    NSInteger unreadMsgCount = 0;
//    
//    // 开始异步请求网络
//    NSMutableArray * readResult = [[NSMutableArray alloc]init];
//    NSMutableArray * unReadResult = [[NSMutableArray alloc]init];
//    FMDatabase *db = [FMDBHelper getDbInstance];
//    if (db) {
//        // 获得本地所有的已读消息
//        FMResultSet *rs;
//        
//        // 获得本地所有的未读消息
//        FMResultSet *rs2;
//        
//        // 未登录用户
//        if(!APP.isLogin || APP.token.length <= 0){
//            // 未读系统消息
//            rs = [db executeQuery:[NSString stringWithFormat:@"SELECT msg_id FROM %@ WHERE is_read = 10 AND type = 20", [TabMessage tableName]]];
//            // 已读系统消息
//            rs2 = [db executeQuery:[NSString stringWithFormat:@"SELECT msg_id FROM %@ WHERE is_read != 10 AND type = 20", [TabMessage tableName]]];
//        }else{
//            // 已经登录用户
//            // 未读系统消息和本人的未读取消息
//            rs = [db executeQuery:[NSString stringWithFormat:@"SELECT msg_id FROM %@ WHERE is_read = 10 AND (user_uuid = '%@' OR type = 20)", [TabMessage tableName], APP.uuid]];
//            // 已读系统消息和本人消息
//            rs2 = [db executeQuery:[NSString stringWithFormat:@"SELECT msg_id FROM %@ WHERE is_read != 10 AND (user_uuid = '%@' OR type = 20)", [TabMessage tableName], APP.uuid]];
//        }
//        while ([rs next]) {
//            NSNumber* msg_id = [[rs resultDictionary] objectForKey:@"msg_id"];
//            if(msg_id == nil || [msg_id integerValue] == 0){
//                continue;
//            }
//            [readResult addObject:msg_id];
//        }
//        
//        while ([rs2 next]) {
//            NSNumber* msg_id = [[rs2 resultDictionary] objectForKey:@"msg_id"];
//            if(msg_id == nil || [msg_id integerValue] == 0){
//                continue;
//            }
//            [unReadResult addObject:msg_id];
//            unreadMsgCount++;
//        }
//        
//        [db close];
//    }
//    db = nil;
//    NSString* token = APP.token.length > 0 ? APP.token : @"";
//    NSDictionary *requestDic = @{@"lang":@0,@"token":token,@"has_read_list":readResult,@"unread_list":unReadResult};
//    
//    [HttpServices post:get_msg_list _id:nil showBackProgressHD:NO token:token showError:YES dataDic:requestDic success:^(id jsonObj, Pagination *page) {
//        NSInteger newMsgCount = 0;
//        
//        NSArray* data = [jsonObj objectForKey:@"data"];
//        for(int i = 0; data != nil && i < [data count]; i++){
//            NSDictionary* item = [data objectAtIndex:i];
//            TabMessage * msg = [[TabMessage alloc] init];
//            NSInteger type = [[item objectForKey:@"type"] integerValue];
//            // 系统消息
//            if(type == 20){
//                msg.user_uuid = @"";
//            }else{
//                msg.user_uuid = APP.uuid;
//            }
//            msg.type = type;
//            msg.action = [item objectForKey:@"action"];
//            msg.title = [item objectForKey:@"title"];
//            msg.content = [item objectForKey:@"content"];
//            NSNumber* msg_id = [item objectForKey:@"msg_id"];
//            // 如果消息ID异常，不显示当前消息
//            if(msg_id != nil){
//                msg.msg_id = [msg_id integerValue];
//            }else{
//                continue;
//            }
//            NSNumber* created_at = [item objectForKey:@"created_at"];
//            if(created_at != nil){
//                msg.created_at = [created_at integerValue];
//            }
//            // 将新消息插入数据库中
//            [FMDBHelper insertObject:msg];
//            newMsgCount++;
//        }
//        
//        // 更新成功
//        if(success){
//            success();
//        }
//        
//        // 有新消息，修改新消息状态
//        if(unreadMsgCount + newMsgCount <= 0)
//        {
//            [APP setPushMsgState:NO count:0];
//        }else{
//            [APP setPushMsgState:YES count:unreadMsgCount + newMsgCount];
//        }
//
//    } apiErroBlock:^(id jsonObj) {
//        // 有新消息，修改新消息状态
//        if(unreadMsgCount <= 0)
//        {
//            [APP setPushMsgState:NO count:0];
//        }else{
//            [APP setPushMsgState:YES count:unreadMsgCount];
//        }
//    } networkErroBlock:^(NSURLSessionDataTask *operation, NSError *error) {
//        // 有新消息，修改新消息状态
//        if(unreadMsgCount <= 0)
//        {
//            [APP setPushMsgState:NO count:0];
//        }else{
//            [APP setPushMsgState:YES count:unreadMsgCount];
//        }
//    }];
}

- (void)setDateHandlerWithString:(NSString *)formatString{
    APP.dateFomateHandler = [[NSDateFormatter alloc]init];
    [APP.dateFomateHandler setDateFormat:formatString];
}
//IM 退出
-(void)emLogout
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{

        });
    });

}

@end
