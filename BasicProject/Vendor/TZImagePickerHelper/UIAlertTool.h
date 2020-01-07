//
//  UIAlertTool.h
//  Snwdai
//
//  Created by 张明辉 on 16/3/15.
//  Copyright © 2016年 张明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIAlertTool : NSObject
//alert
+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle confirm:(void (^)())confirm cancle:(void (^)())cancel;
//action sheet
+(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle confirm:(void (^)())confirm cancle:(void (^)())cancel;

+(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle oneTitle:(NSString *)oneTitle twoTitle:(NSString *)twoTitle  one:(void (^)())one   two:(void (^)())two cancle:(void (^)())cancel;

//sex action sheet
+(void)showActionSheetWithWomenConfirm:(void (^)(NSString *sex))confirm;


+(void)showActionSheetWithWith:(UIView *)view endTitle:(NSString *)title endtitileArr:(NSArray *)titleArr Confirm:(void (^)(NSString *str))confirm;
@end
