/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>
#import "UIView+DLExtension.h"
#import "UIView+syCategory.h"
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

/**
 *  根据标签数组排列视图
 *
 *  @param dataArray 标签数组
 *  @param orignalX  按钮起始位置x
 *  @param origanalY 按钮起始位置y
 */
//- (void)arrangeButtonItemsWithDataSource:(NSArray *)dataArray OriginalButtonX:(CGFloat )orignalX OriginalButtonY:(CGFloat)origanalY;
///**
// *  根据标签数组获取所有的button的高总和
// *
// *  @param dataArray 标签数组
// *  @param originalX 按钮起始位置x
// *  @param originalY 按钮起始位置y
// *
// *  @return 返回所有的按钮高度之和
// */
//- (CGFloat)getAllButtonItemsWithDatasource:(NSArray *)dataArray OriginalButtonX:(CGFloat)originalX OrignalButtonY:(CGFloat)originalY;

-(void)setViewFilletSize:(CGSize)size;
/// 画圆角边框
-(void)setViewFilletRadius:(CGFloat)radius color:(UIColor*)color;

-(void)createViewShadDow:(UIColor *)color;

@end
