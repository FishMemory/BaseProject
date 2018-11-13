//
//  ProgressHUD.h
//  3dMagicCamera
//
//  Created by 宋亚清 on 15/4/14.
//  Copyright (c) 2015年 宋亚清. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface ProgressHUD : NSObject{
    MBProgressHUD *hud;
    CGFloat offsetY;
}
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)MBProgressHUD *hud1;
@property(nonatomic,assign)CGFloat progress;
+ (id)instance;

-(void)setMessage:(NSString*)title detail:(NSString*)detail;

#pragma mark <--对号 完成提示图片- ->
- (void)completedProgressHDView:(UIView *)inView time:(NSTimeInterval)time info:(NSString *)info;

- (void)showWarnHUDWithTimer:(UIView *)inView time:(NSTimeInterval) time info:(NSString *)info;
/**
 *  带叹号图片提醒
 *
 *  @param inView 父视图
 *  @param time   要持续显示的时间
 *  @param info   文字信息
 */
- (void)showWarnProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info;
/**
 *  带叹号图片提醒
 *
 *  @param inView 父视图
 *  @param time   要持续显示的时间 之后自动消失
 *  @param info   文字信息
 */
- (void)showWarnProgressHDWithTimer:(UIView *)inView time:(NSTimeInterval) time info:(NSString *)info;
/**
 *  对号图片提示框
 *
 *  @param tf     是否显示 YES为显示 NO为去掉
 *  @param inView 父视图
 *  @param info   提示文字信息
 */
- (void)showProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info;


/**
 *  菊花loading
 *
 *  @param tf     是否显示
 *  @param inView 要加载 父视图
 *  @param info   提示信息
 */
- (void)showBackProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info;
- (void)setOffsetY:(CGFloat)y;


- (void)showOnlyBarProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info;


/**
 *  只显示文字 自动消失
 *
 *  @param time   time
 *  @param inView 父视图
 *  @param info   内容
 */
- (void)showOnlyTextProgressHDWithTimer:(NSTimeInterval)time inView:(UIView *)inView info:(NSString *)info;

/**
 *  图片加loading
 *
 *  @param show
 *  @param inView 
 */
-(void)imageViewShowback:(BOOL)show inView:(UIView *) inView;
@end
