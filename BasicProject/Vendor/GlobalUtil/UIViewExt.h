/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>
//#import "UIView+DLExtension.h"
//#import "UIView+syCategory.h"


typedef NS_ENUM(NSUInteger, DLBadgeStyle)
{
    DLBadgeStyleRedDot = 0,
    DLBadgeStyleNumber,
    DLBadgeStyleNew
};

typedef NS_ENUM(NSUInteger, DLBadgeAnimType)
{
    DLBadgeAnimTypeNone = 0,
    DLBadgeAnimTypeScale,
    DLBadgeAnimTypeShake,
    DLBadgeAnimTypeBreathe
};

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);


@interface UIView (ViewFrameGeometry)
@property CGPoint origin;
@property CGSize size;

@property CGFloat originalx;
@property CGFloat originaly;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

@property (nonatomic, assign) CGSize boundsSize;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;
@property (nonatomic, readonly) CGRect contentBounds;
@property (nonatomic, readonly) CGPoint contentCenter;

- (void)shakeView;

@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, assign) CGRect badgeFrame;
@property (nonatomic, assign) DLBadgeAnimType aniType;

- (void)shoDLBadge;
- (void)shoDLBadgeWithStyle:(DLBadgeStyle)style value:(NSInteger)value animationType:(DLBadgeAnimType)aniType;
- (void)clearBadge;

- (void)removeAllSubviews;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

- (void)leftBorder:(CGRect)rect;
- (void)rightBorder:(CGRect)rect;
- (void)topBorder:(CGRect)rect;
- (void)bottomBorder:(CGRect)rect;

-(void)leftBorder:(CGRect)rect borderColor:(UIColor *)color;
-(void)Border:(CGRect)rect borderColor:(UIColor *)color;
/**
 *  设置view 圆角 和边框及颜色
 *
 *  @param radius
 *  @param color
 */
-(void)setViewWithRadius:(CGFloat)radius color:(CGColorRef )color;
/**
 *  设置view类及子类的圆角
 *
 *  @param radius 圆角半径
 */
-(void)setViewWithRadius:(CGFloat)radius;
/**
 *  设置圆角和边界线
 *
 *  @param radius      圆角弧度
 *  @param color       边界线颜色
 *  @param borderwidth 边界线宽度
 */
- (void)setViewWithRadius:(CGFloat)radius BorderColor:(UIColor *)color BorderWidth:(CGFloat)borderwidth;

-(void)setViewLayerThemeColors:(CGSize)size;

 
-(void)setViewFilletSize:(CGSize)size;
/// 画圆角边框
-(void)setViewFilletRadius:(CGFloat)radius color:(UIColor*)color;

-(void)createViewShadDow:(UIColor *)color;


//-----------------

/**
 *  计算一个UIView的 endX = x坐标 + width + 格外加上的extraX
 *
 *  @param extraX  格外加上的宽度
 *
 *  @return endX
 */
- (CGFloat)getEndXwith:(CGFloat)extraX;

/**
 *  计算一个UIView的 endY = y坐标 + height + 格外加上的extraY
 *
 *  @param extraY 格外加上的高度
 *
 *  @return endY
 */
- (CGFloat)getEndYwith:(CGFloat)extraY;

/**
 *  设置所有子view垂直居中
 */
- (void)setSubViewsMiddle;

/**
 *  设置所有子view水平居中
 */
- (void)setSubViewsCenter;

/**
 *  让UIView在父View垂直居中，注意：调用此方法前确保当前view已加入父view中
 */
- (void)setUIViewMiddle;

/**
 *  让UIView在父View中水平居中，注意：调用此方法前确保当前view已加入父view中
 */
- (void)setUIViewCenter;

/**
 *  将UIView在指定parentView里水平居中
 *
 *  @param parentView 父UIView
 */
- (void)setUIViewCenterOf:(UIView *)parentView;

/**
 *  将UIView在指定parentView里垂直居中
 *
 *  @param parentView 父UIView
 */
- (void)setUIViewMiddleOf:(UIView *)parentView;

/**
 *  将UIView在指定parentView里垂直并水平居中
 *
 *  @param parentView 父UIView
 */
- (void)setUIViewVerticalAndHorizontalCenterOf:(UIView *)parentView;

/**
 *  计算实例view到指定的SuperView的Y值,
 *  ____superView最顶层也就是viewController.view,即此时值可设置为nil,
 *  ____(注意：距离最顶层，ios6与7会相差20像素);
 *
 *  @param superView 指定的SuperView
 *
 *  @return 目标view在指定superView的Y值距离
 */
- (CGFloat)offsetyFromSuperView:(UIView *)superView;

/**
 *  设置UIVIiew的border
 *
 *  @param top    上
 *  @param right  右
 *  @param bottom 下
 *  @param left   左
 */
- (void)setBorderWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

/**
 *  弹出view,类似于弹簧效果
 */
- (void)showAnimationWithSpring;

/**
 *  关闭view,类似于弹簧效果
 */
- (void)hiddenAnimationWithSpring;
// 取指定的图片 在view中
-(UIImage*)captureViewframe:(CGRect)fra;
//获得圆角的个数
-(void)roundCount:(CGSize)size diretionNum:(UIRectCorner)corner;
//截屏返回image
- (UIImage *)screenshot;

-(void)SetShadowWithframe:(CGRect)frame colors:(NSArray*)colors;



@end

