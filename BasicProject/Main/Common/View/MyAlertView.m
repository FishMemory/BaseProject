//
//  MyAlertView.m
//   
//
//  Created by 宋亚清 on 16/5/9.
//  Copyright © 2016年  . All rights reserved.
//

#import "MyAlertView.h"
#import "UIButton+countDown.h"
#import "JJCPayCodeTextField.h"
@implementation MyAlertView

+ (instancetype)instance
{
    static MyAlertView *alertV;
    if (alertV == nil) {
        alertV = [[MyAlertView alloc] init];
    }
    return alertV;
}

-(void)WrAlert:(NSString*)title time:(NSInteger)time
{
    CGSize titleSize = [title calculateSize:CGSizeMake(SCREEN_WIDTH-PX(320), MAXFLOAT) font:FONT(PX(32))];
    CGFloat height =  titleSize.height > PX(32) ? titleSize.height-PX(32) : titleSize.height;
    self.backView = [[UIView alloc]initWithFrame:FRAME(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backView.backgroundColor = rgba(0, 0, 0, 0.2);
    [APP.window addSubview:self.backView];
    UIView  *alertview = [[UIView alloc]initWithFrame:FRAME(PX(100),(SCREEN_HEIGHT-PX(210))/2 , SCREEN_WIDTH-PX(200), PX(210)+height)];
    alertview.backgroundColor = rgba(241, 242, 242,1);
    [alertview setViewWithRadius:PX(15)];
    [self.backView addSubview:alertview];
    DLLabel *titles = [[DLLabel alloc]initWithText:title font:FONT(PX(32)) textColor:[UIColor blackColor]];
    titles.frame = FRAME(PX(60), PX(40),alertview.width-PX(120) , titleSize.height);
    titles.numberOfLines = 0 ;
    
    titles.textAlignment  = NSTextAlignmentLeft;
    [alertview addSubview:titles];
    
    UIView *line = [[UIView alloc]initWithFrame:FRAME(0, titles.bottom+PX(46), alertview.width, 0.5)];
    line.backgroundColor = COL_GRAY_LINE;
    [alertview addSubview:line];
    UIButton *cancelBtn = [DLButton buttonType:UIButtonTypeCustom frame:FRAME(0, line.bottom, alertview.width/2, alertview.height-line.bottom) titleColor:rgb(19, 96, 254) target:self Selector:@selector(closeAction) selectorState:UIControlEventTouchUpInside title:@"取消" cornerRadius:0];
    cancelBtn.titleLabel.font = FONT_TITLE;
    [alertview addSubview:cancelBtn];
    
    UIButton *okBtn = [DLButton buttonType:UIButtonTypeCustom frame:FRAME(cancelBtn.right, cancelBtn.top, cancelBtn.width, cancelBtn.height) titleColor:rgb(19, 96, 254) target:self Selector:@selector(receiveAction) selectorState:UIControlEventTouchUpInside title:@"确定" cornerRadius:0];
    okBtn.titleLabel.font = FONT_TITLE;
    [alertview addSubview:okBtn];
    [okBtn leftBorder:CGRectZero];
    if (time > 0 ) {
        [okBtn alertStartWithTime:time title:@"确定" countDownTitle:@"s" mainColor:rgb(19, 96, 254)  countColor:COL_GRAY_FONT];
    }
    
}

-(void)showAlertViewImgUrl:(NSString *)url{
   self.backView = [[UIView alloc]initWithFrame:FRAME(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backView.backgroundColor = rgba(0, 0, 0, 0.8);
    [APP.window addSubview:self.backView];
    UIImageView *imageView  = [[UIImageView alloc]initWithFrame:FRAME((SCREEN_WIDTH - PX(676))/2., PX(270), PX(676), PX(697))];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(receiveAction)];
    [imageView addGestureRecognizer:tap];
    [self.backView addSubview:imageView];
    UIButton *closeBtn = [DLButton buttonType:UIButtonTypeCustom frame:FRAME(SCREEN_WIDTH-PX(140),PX(190-18),PX(100), PX(100)) titleColor:nil title:@"" cornerRadius:0];
    UIImageView *closeImage = [[UIImageView alloc]initWithImage:ImageNamed(@"answer_delete_button")];
    closeImage.frame = FRAME((closeBtn.width -PX(63))/2.,(closeBtn.width -PX(63))/2.,PX(64), PX(64));
    [closeBtn addSubview:closeImage];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:closeBtn];
 
}
// 优惠码输入框
-(void)showCodeInputView:(void(^)(NSString *inputCode))finished{
    self.backView = [[UIView alloc]initWithFrame:FRAME(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backView.backgroundColor = rgba(0, 0, 0, 0.2);
    [APP.window addSubview:self.backView];
    
    UIView  *alertview = [[UIView alloc]initWithFrame:FRAME((SCREEN_WIDTH-PX(528))/2,PX(400) ,PX(528), PX(306))];
    alertview.backgroundColor = COL_NAVI;
    [alertview setViewWithRadius:PX(15)];
    [self.backView addSubview:alertview];
    
    JJCPayCodeTextField *textField = [[JJCPayCodeTextField alloc] initWithFrame:CGRectMake((alertview.width-PX(315))/2.0, PX(39), PX(315), PX(80)) TextFieldType:JJCPayCodeTextFieldTypeSpaceBorder];
    textField.borderSpace = PX(20);
    textField.textFieldNum = 3;
    textField.isShowTrueCode = YES;
    textField.borderColor = COL_GRAY_LINE;
    [alertview addSubview:textField];
    UIButton *okBtn = [DLButton buttonType:UIButtonTypeCustom frame:FRAME((alertview.width-PX(316))/2.,alertview.height-PX(126),PX(316), PX(76)) titleColor:COL_NAVI target:self Selector:@selector(receiveAction) selectorState:UIControlEventTouchUpInside title:@"确认" cornerRadius:PX(8)];
    okBtn.titleLabel.font = FONT_TITLE;
    okBtn.backgroundColor = COL_THEME;
    [alertview addSubview:okBtn];
    
    textField.finishedBlock = ^(NSString *payCodeString) {
        if (finished) {
            finished(payCodeString);
        } 
        NSLog(@"payCodeString：%@", payCodeString);
    };
}
-(void)receiveAction{
     [self.backView removeFromSuperview];
    if(self.receiveBlock){
        self.receiveBlock();
    }
   
}
-(void)closeAction{
     [self.backView removeFromSuperview];
    if(self.cancelBlock){
        self.cancelBlock();
    }
}

// 下边弹出框 可设置颜色 标题 传标题数组  颜色数组 自上而下
+(void)WarnSheetViewVC:(UIViewController *)VC  titleArray:(NSArray *)titleArray colors:(NSArray *)colors topBlock:(void(^)(UIAlertAction *but))topBlock bottomBlock:(void(^)(UIAlertAction *but))bottomBlock cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock  {
   
    //添加Button 第一个按钮
    NSString *topTitle = [titleArray firstObject];
    NSString *bottomTitile =  [titleArray objectAtIndex:1];
    NSString *cancelTitle = [titleArray lastObject];
    topTitle =  topTitle.length > 0 ? topTitle : @"";
    bottomTitile =  bottomTitile.length > 0 ? bottomTitile : @"";
    cancelTitle =  cancelTitle.length > 0 ? cancelTitle : @"";
    UIColor *topColor = [colors firstObject];
    UIColor *centerColor = [colors objectAtIndex:1];
    UIColor *cancerColor = [colors lastObject];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil                                                                      message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *topAction =  [UIAlertAction actionWithTitle:topTitle style: UIAlertActionStyleDefault handler:nil];
     [topAction setValue:topColor forKey:@"_titleTextColor"];
    topAction.enabled  = NO;
    //    第二个按钮
    UIAlertAction *centerAction =  [UIAlertAction actionWithTitle:bottomTitile  style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //处理点击从相册选取
        bottomBlock(action);
    }];
    [centerAction setValue:centerColor forKey:@"_titleTextColor"];
    //    取消
    UIAlertAction *cancetAtion =  [UIAlertAction actionWithTitle:cancelTitle  style: UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
        cancelBlock(action);
    }];
    [cancetAtion setValue:cancerColor forKey:@"_titleTextColor"];
    [alertController addAction:topAction];
    [alertController addAction:centerAction];
    [alertController addAction:cancetAtion];
    
    [VC presentViewController: alertController animated: YES completion: nil];
}

/**
 *  anctionSheetView
 *
 *  @param currentPageVC     当前控制器vc
 *  @param topTitle          第一个按钮
 *  @param bottomTitile      下边按钮
 *  @param cancelButtonTitle 取消按钮Title
 *  @param cancelBlock       取消
 *  @param topBtnBlock       第一个按钮操作
 *  @param bottomBtnBlock    下边按钮操作
 */
+(void)WarningActionSheetVC:(UIViewController *)currentPageVC  topTitle:(NSString *)topTitle bottomTitile:(NSString *)bottomTitile  cancelButtonTitle:(NSString *)cancelButtonTitle topBtnBlock:(void(^)(UIAlertAction *but))topBtnBlock bottomBtnBlock:(void(^)(UIAlertAction *but))bottomBtnBlock  cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                      message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button 第一个按钮
    topTitle =  topTitle.length > 0 ? topTitle : @"";
    bottomTitile =  bottomTitile.length > 0 ? bottomTitile : @"";
    cancelButtonTitle =  cancelButtonTitle.length > 0 ? cancelButtonTitle : @"";
    [alertController addAction: [UIAlertAction actionWithTitle:topTitle style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        topBtnBlock(action);
        
    }]];
    //    第二个按钮
    [alertController addAction: [UIAlertAction actionWithTitle:bottomTitile  style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        bottomBtnBlock(action);
        
    }]];
    //    取消
    [alertController addAction: [UIAlertAction actionWithTitle:cancelButtonTitle  style: UIAlertActionStyleCancel handler:nil]];
    [currentPageVC presentViewController: alertController animated: YES completion: nil];
    NSLog(@"上传照片");
}
+ (void)WarningTextAlertViewActionWithUIViewController:(UIViewController *)currentPageVC title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle CancelButtonColor:(UIColor *)cancleColor OkButtonColor:(UIColor *)okColor okButtonTitle:(NSString *)okButtonTitle cancelBlocks:(void (^)(UIAlertAction *))cancelBlock okBlock:(void (^)(UIAlertAction *))okblock{
    
    NSString *canceltitle = @"取消";
    if(cancelButtonTitle.length > 0){
        canceltitle =  cancelButtonTitle;
    }
    NSString *suretitle = @"确定";
    if (okButtonTitle.length > 0) {
        suretitle = okButtonTitle;
    }
    message =  message.length > 0 ? message : @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:title];
    if (title.length > 1) {
        [hogan addAttribute:NSForegroundColorAttributeName  value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
        [alertController setValue:hogan forKey:@"attributedTitle"];
    }
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:canceltitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        cancelBlock(action);
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        okblock(action);
    }];
    [alertController addAction:cancelAction];
    [cancelAction setValue:cancleColor forKey:@"_titleTextColor"];
    [alertController addAction:otherAction];
    [otherAction setValue:okColor forKey:@"_titleTextColor"];
    [currentPageVC presentViewController:alertController animated:YES completion:nil];
    
}

// 默认类型
+(void)WarningTextAlertViewActionWithUIViewController:(UIViewController *)currentPageVC  title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle  okButtonTitle:(NSString *)okButtonTitle cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock okBlock:(void(^)(UIAlertAction *but))okblock {
     NSString *canceltitle = @"取消";
    if(cancelButtonTitle.length > 0){
        canceltitle =  cancelButtonTitle;
    }
    NSString *suretitle = @"确定";
    if (okButtonTitle.length > 0) {
        suretitle = okButtonTitle;
    }
    message =  message.length > 0 ? message : @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:title];
    if (title.length > 1) {
        [hogan addAttribute:NSForegroundColorAttributeName  value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
        [alertController setValue:hogan forKey:@"attributedTitle"];
    }
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:canceltitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        cancelBlock(action);
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        okblock(action);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [currentPageVC presentViewController:alertController animated:YES completion:nil];
    
}


// 默认类型  设置颜色 按钮
+(void)WarningAlertViewVC:(UIViewController *)currentPageVC  titleColor:(UIColor *)titleColor title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle  okTitle:(NSString *)okTitle cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock okBlock:(void(^)(UIAlertAction *but))okblock {
    NSString *canceltitle = @"取消";
    if(cancelTitle.length > 0){
        canceltitle =  cancelTitle;
    }
    NSString *suretitle = @"确定";
    if (okTitle.length > 0) {
        suretitle = okTitle;
    }
    message = message.length > 0 ? message : @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIView *subView1 = alertController.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    //取title和message：
    UILabel *messagelab = subView5.subviews[0];
    messagelab.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:title];
    if (title.length > 1) {
        [hogan addAttribute:NSForegroundColorAttributeName  value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
        [alertController setValue:hogan forKey:@"attributedTitle"];
    }
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message.length > 0 ? message : @""];
  
    
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, message.length)];
    if ([alertController valueForKey:@"attributedMessage"]) {
        [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:canceltitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        cancelBlock(action);
    }];
   
        [cancelAction setValue:COL_THEME forKey:@"_titleTextColor"];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        okblock(action);
    }];
    
    [otherAction setValue:COL_THEME forKey:@"_titleTextColor"];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [currentPageVC presentViewController:alertController animated:YES completion:nil];
    
}
// 默认类型
+(void)WarnDefaultAlertView:(UIViewController *)currentPageVC  title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle  okButtonTitle:(NSString *)okButtonTitle cancelBlocks:(void(^)(UIAlertAction *but))cancelBlock okBlock:(void(^)(UIAlertAction *but))okblock {
    NSString *canceltitle = @"取消";
    if(cancelButtonTitle.length > 0){
        canceltitle =  cancelButtonTitle;
    }
    NSString *suretitle = @"确定";
    if (okButtonTitle.length > 0) {
        suretitle = okButtonTitle;
    }
    message =  message.length > 0 ? message : @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:title];
    if (title.length > 1) {
        [hogan addAttribute:NSForegroundColorAttributeName  value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
        [alertController setValue:hogan forKey:@"attributedTitle"];
    }
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:canceltitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (cancelBlock) {
            cancelBlock(action);
        }
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (okblock) {
            okblock(action);
        }
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [currentPageVC presentViewController:alertController animated:YES completion:nil];
    
}

// 只有一个确定键  设置字体颜色
+(void)WarningAlertViewOnlyOneBut:(UIViewController *)currentPageVC  title:(NSString *)title titleColor:(UIColor *)titleColor message:(NSString *)message  okButtonTitle:(NSString *)okButtonTitle okBlock:(void(^)(UIAlertAction *but))okblock {
    
    NSString *suretitle = @"确定";
    if (okButtonTitle.length > 0) {
        suretitle = okButtonTitle;
    }
    message =  message.length > 0 ? message : @"";
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIView *subView1 = alertController.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    //取title和message：
    UILabel *messagelab = subView5.subviews[0];
    messagelab.textAlignment = NSTextAlignmentLeft;
//    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
//    
//      [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(20, 30)];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        okblock(action);
    }];
 
    [otherAction setValue:titleColor forKey:@"_titleTextColor"];
    
    
    [alertController addAction:otherAction];
    [currentPageVC presentViewController:alertController animated:YES completion:nil];
    
}

// 只有一个确定键
+(void)WarningTextAlertViewActionOnlyOneViewController:(UIViewController *)currentPageVC  title:(NSString *)title message:(NSString *)message  okButtonTitle:(NSString *)okButtonTitle okBlock:(void(^)(UIAlertAction *but))okblock {

    NSString *suretitle = @"确定";
    if (okButtonTitle.length > 0) {
        suretitle = okButtonTitle;
    }
    message = message.length > 1 ? message :@"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIView *subView1 = alertController.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    //取title和message：
    UILabel *messagelab = subView5.subviews[0];
    messagelab.textAlignment = NSTextAlignmentLeft;
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        okblock(action);
    }];
    
    [alertController addAction:otherAction];
    [currentPageVC presentViewController:alertController animated:YES completion:nil];
    
}


@end
