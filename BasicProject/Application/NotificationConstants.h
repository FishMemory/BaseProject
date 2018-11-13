//
//  NotificationConstants.h
//   
//
//  Created by Michael on 16/6/22.
//  Copyright © 2016年  . All rights reserved.
//

#ifndef NotificationConstants_h
#define NotificationConstants_h


//登录状态变化
#define LOGIN_STATUS_CHANGE_NOTIFICATION @"LoginStateNSNotification"

#define APP_STATUS_CHANGE_NOTIFICATION @"app_status_change_notification"

//============== 友盟推送消息相关 ==============
#define KEY_NOTIFY_TYPE @"notification_type"
#define KEY_NOTIFY_TIME @"notification_timestamp"
#define KEY_NOTIFY_ACTION @"notification_action"
#define KEY_NOTIFY_TITLE @"alert"
#define KEY_NOTIFY_TEXT @"text"

#define TYPE_SERVICE @"type_service"
#define TYPE_SYSTEM @"type_systems"

#define KEY_NOTIFY_HAS_READ @"has_read"
#define KEY_NOTIFY_DELETED @"has_deleted"

//============== 融云推送消息相关 ==============
#define KEY_RONG_MSG @"rcmessage"
#define KEY_RONG_COUNT @"rcmessage_count"
#define KEY_RONG_RC @"rc"
#define KEY_RONG_TYPE @"cType"
#define KEY_RONG_TYPE_PR @"PR"
#define KEY_RONG_TYPE_GRP @"GRP"
#define KEY_RONG_TYPE_UID @"fId"
#define KEY_RONG_TYPE_APP_DATE @"appData"

#define KEY_ACTION @"key_action"
#define KEY_RC_HEADER @"key_header"
#define KEY_SCHEMA @"key_schema"
#define KEY_ARGS @"key_args"

//MichaelTang add from v1.1
#define KEY_REFRESH_USER_ENTITY @"_REFRESH_USER_ENTITY_"

// AppDelegate接收到推送消息后的action跳转通知，让当前的VC来处理action跳转
// 因为只有当前活动的VC能跳转
// 该Key对应的是App刚启动时的跳转，由于通过通知无法处理这种跳转，只能先保存下来，等App首页启动了之后，再次处理跳转
#define KEY_BOOT_TASK @"key_suspend_action"
#define PUSH_MSG_BOOT_TASK_NOTIFICATION @"push_msg_action_notification"

// 有新的消息推送时，发送的通知
#define NEW_MSG_COUNT_NOTIFICATION @"new_msg_count_notification"
// 清除新消息提示通知
#define MSG_CLEAR_NOTIFICATION @"msg_clear_notification"

// 新的会话IM提示数量通知
#define NEW_IM_COUNT_NOTIFICATION @"new_im_count_notification"
// 清除新会话IM数量通知
#define IM_COUNT_CLEAR_NOTIFICATION @"im_count_clear_notification"

// 客服 消息红点通知
#define IM_CUSTOMERSERVICE @"im_count_custom_service"

#endif /* NotificationConstants_h */
