//
//  MyAlertView.h
//   
//
//  Created by 宋亚清 on 16/5/9.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAlertView : NSObject
{
    
//    UIImageView *imageView;
//    UIButton *closeBtn;
}
@property (copy, nonatomic)  void (^receiveBlock)(void);
@property (copy, nonatomic)  void (^cancelBlock)(void);
@property (strong, nonatomic) UIView *backView;
+ (instancetype)instance;

-(void)WrAlert:(NSString*)title time:(NSInteger)time;
-(void)showAlertViewImgUrl:(NSString *)url;

// 下边弹出框 可设置颜色 标题 传标题数组  颜色数组 自上而下
+(void)WarnSheetViewVC:(UIViewController *)VC  titleArray:(NSArray *)titleArray colors:(NSArray *)colors topBlock:(void(^)(UIAlertAction *but))topBlock bottomBlock:(void(^)(UIAlertAction *but))bottomBlock cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock;
/**
 *  alertVIew  默认类型
 *
 *  @param currentPageVC     当前页controller
 *  @param title             title description
 *  @param message           message description
 *  @param cancelButtonTitle cancelButtonTitle description
 *  @param okButtonTitle     okButtonTitle description
 *  @param cancelBlock       cancelBlock description
 *  @param okblock           okblock description
 */
+(void)WarningTextAlertViewActionWithUIViewController:(UIViewController *)currentPageVC  title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle  okButtonTitle:(NSString *)okButtonTitle cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock okBlock:(void(^)(UIAlertAction *but))okblock ;
/**
 *  默认类型可设置两个按钮的颜色
 *
 *  @param currentPageVC
 *  @param title
 *  @param message
 *  @param cancelButtonTitle
 *  @param cancleColor
 *  @param okColor
 *  @param okButtonTitle
 *  @param cancelBlock
 *  @param okblock
 */
+(void)WarningTextAlertViewActionWithUIViewController:(UIViewController *)currentPageVC  title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle CancelButtonColor:(UIColor *)cancleColor OkButtonColor:(UIColor *)okColor okButtonTitle:(NSString *)okButtonTitle cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock okBlock:(void(^)(UIAlertAction *but))okblock ;


/**
 *  alertVIew  默认类型
 *
 *  @param currentPageVC     当前页controller
 *  @param title             title description
 *  @param message           message description
 *  @param cancelButtonTitle cancelButtonTitle description
 *  @param okButtonTitle     okButtonTitle description
 *  @param cancelBlock       cancelBlock description
 *  @param okblock           okblock description
 */
+(void)WarnDefaultAlertView:(UIViewController *)currentPageVC  title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle  okButtonTitle:(NSString *)okButtonTitle cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock okBlock:(void(^)(UIAlertAction *but))okblock ;


/**
 *  anctionSheetView  两个按钮 加cancel建
 *
 *  @param currentPageVC     当前控制器vc
 *  @param topTitle          第一个按钮
 *  @param bottomTitile      下边按钮
 *  @param cancelButtonTitle 取消按钮Title
 *  @param cancelBlock       取消
 *  @param topBtnBlock       第一个按钮操作
 *  @param bottomBtnBlock    下边按钮操作
 */
+(void)WarningActionSheetVC:(UIViewController *)currentPageVC  topTitle:(NSString *)topTitle bottomTitile:(NSString *)bottomTitile  cancelButtonTitle:(NSString *)cancelButtonTitle topBtnBlock:(void(^)(UIAlertAction *but))topBtnBlock bottomBtnBlock:(void(^)(UIAlertAction *but))bottomBtnBlock  cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock;


/**
 *  只有一个确定键 
 *
 *  @param currentPageVC
 *  @param title
 *  @param message
 *  @param okButtonTitle
 *  @param okblock
 */
+(void)WarningTextAlertViewActionOnlyOneViewController:(UIViewController *)currentPageVC  title:(NSString *)title message:(NSString *)message  okButtonTitle:(NSString *)okButtonTitle okBlock:(void(^)(UIAlertAction *but))okblock;



/**
 *  alertView 只有一个按钮， 可设置颜色
 *
 *  @param currentPageVC 
 *  @param title         
 *  @param message       
 *  @param okButtonTitle 
 *  @param okblock       
 */

+(void)WarningAlertViewOnlyOneBut:(UIViewController *)currentPageVC  title:(NSString *)title titleColor:(UIColor *)titleColor message:(NSString *)message  okButtonTitle:(NSString *)okButtonTitle okBlock:(void(^)(UIAlertAction *but))okblock ;


-(void)showCodeInputView:(void(^)(NSString *inputCode))finished; 
@end
