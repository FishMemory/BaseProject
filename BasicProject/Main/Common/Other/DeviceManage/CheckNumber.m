//
//  CheckNumber.m
//  3dMagicCamera
//
//  Created by Heysandy on 15/4/30.

//

#import "CheckNumber.h"

@implementation CheckNumber
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(190))\\d{8}$";
    NSString *phoneRegex = @"^0?(13|15|17|18|14|19)[0-9]{9}$";
//    NSString *phoneRegex = @"^([\\d\\+])?\\d{7,15}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//车牌号验证
- (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

//车型
- (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

//用户名
- (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+(BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[0-9a-zA-Z_]{6,18}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
- (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}
//     获取验证码
-(BOOL)getVerificationCode:(NSString *)phoneNumber zone:(NSString *)zone{
    BOOL Success = NO;
//        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodVoice phoneNumber:phoneNumber zone:@"86" customIdentifier:nil result:^(NSError *error) {
//    
//            if (!error) {
//             
//                NSLog(@"获取验证码成功");
//            }
//            else{
////                Success = NO;
//                NSLog(@"错误信息:%@",error);
//            }
//    
//        }];
//    

    return Success;
}

@end
