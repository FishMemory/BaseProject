/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "UIViewExt.h"
#import <objc/runtime.h>
#import "CAAnimation+WAnimation.h"

static char badgeLabelKey;
static char badgeBgColorKey;
static char badgeTextColorKey;
static char badgeAniTypeKey;
static char badgeFrameJey;

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}
#define kBadgeBreatheAniKey     @"breathe"
#define kBadgeRotateAniKey      @"rotate"
#define kBadgeShakeAniKey       @"shake"
#define kBadgeScaleAniKey       @"scale"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#define kAnimationDidStopNotification              @"kAnimationDidStopNotification"

#define kAnimationDidStartNotification              @"kAnimationDidStartNotification"

NSString *const kDLAnimationFlyOut = @"kDLAnimationFlyOut";
NSString *const kDLAnimationTypeOut = @"kDLAnimationTypeOut";
NSString *const kDLAnimationTargetViewKey = @"kDLAnimationTargetViewKey";
NSString *const kDLAnimationCallerDelegateKey = @"kDLAnimationCallerDelegateKey";
NSString *const kDLAnimationCallerStartSelectorKey = @"kDLAnimationCallerStartSelectorKey";
NSString *const kDLAnimationCallerStopSelectorKey = @"kDLAnimationCallerStopSelectorKey";
NSString *const kDLAnimationName = @"kDLAnimationName";
NSString *const kDLAnimationType = @"kDLAnimationType";
@implementation UIView (ViewGeometry)

// Retrieve and set the origin
- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

- (CGFloat)x {
    return self.center.x;
}

- (void)setX:(CGFloat)x {
    self.center = CGPointMake(x, self.center.y);
}

- (CGFloat)y {
    return self.center.y;
}

- (void)setY:(CGFloat)y {
    self.center = CGPointMake(self.center.x, y);
}
// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}


- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{  //看对象不看指针
    CGRect newframe = self.frame;
    //NSLog(@"~~~%@",NSStringFromCGRect(newframe));
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}



- (CGSize)boundsSize {
    return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)size {
    CGRect bounds = self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}

- (CGFloat)boundsWidth {
    return self.boundsSize.width;
}

- (void)setBoundsWidth:(CGFloat)width {
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)boundsHeight {
    return self.boundsSize.height;
}

- (void)setBoundsHeight:(CGFloat)height {
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}

- (CGRect)contentBounds {
    return CGRectMake(0.0f, 0.0f, self.boundsWidth, self.boundsHeight);
}

- (CGPoint)contentCenter {
    return CGPointMake(self.boundsWidth/2.0f, self.boundsHeight/2.0f);
}

// Animations
- (void)shakeView {
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    
    [self.layer addAnimation:shake forKey:nil];
}

- (void)shoDLBadge{
    
    [self shoDLBadgeWithStyle:DLBadgeStyleRedDot value:0 animationType:DLBadgeAnimTypeNone];
}

/**
 *  shoDLBadge
 *
 *  @param style DLBadgeStyle type
 *  @param value (if 'style' is DLBadgeStyleRedDot or DLBadgeStyleNew,
 *                this value will be ignored. In this case, any value will be ok.)
 */
- (void)shoDLBadgeWithStyle:(DLBadgeStyle)style value:(NSInteger)value animationType:(DLBadgeAnimType)aniType {
    
    self.aniType = aniType;
    switch (style) {
        case DLBadgeStyleRedDot:
            [self showRedDotBadge];
            break;
        case DLBadgeStyleNumber:
            [self showNumberBadgeWithValue:value];
            break;
        case DLBadgeStyleNew:
            [self showNeDLBadge];
            break;
        default:
            break;
    }
    if (aniType != DLBadgeAnimTypeNone) {
        [self beginAnimation];
    }
}

/**
 *  clear badge
 */
- (void)clearBadge {
    
    self.badge.hidden = YES;
}

#pragma mark -- private methods
- (void)showRedDotBadge {
    
    [self badgeInit];
    //if badge has been displayed and, in addition, is was not red dot style, we must update UI.
    if (self.badge.tag != DLBadgeStyleRedDot) {
        self.badge.text = @"";
        self.badge.tag = DLBadgeStyleRedDot;
        self.badge.layer.cornerRadius = self.badge.width / 2;
    }
    self.badge.hidden = NO;
}

- (void)showNeDLBadge {
    
    [self badgeInit];
    //if badge has been displayed and, in addition, is was not red dot style, we must update UI.
    if (self.badge.tag != DLBadgeStyleNew) {
        self.badge.text = @"new";
        self.badge.tag = DLBadgeStyleNew;
        self.badge.width = 20;
        self.badge.height = 13;
        self.badge.center = CGPointMake(self.width, 0);
        self.badge.font = [UIFont boldSystemFontOfSize:9];
        self.badge.layer.cornerRadius = self.badge.height / 3;
    }
    self.badge.hidden = NO;
}

- (void)showNumberBadgeWithValue:(NSInteger)value {
    
    if (value < 0) {
        return;
    }
    [self badgeInit];
    if (self.badge.tag != DLBadgeStyleNumber) {
        self.badge.tag = DLBadgeStyleNumber;
        
        //maximun value allowed is 99. When the value is greater than 99, "99+" will be shown.
        if (value >=100) {
            self.badge.text = @"99+";
        } else {
            self.badge.text = [NSString stringWithFormat:@"%@", @(value)];
        }
        [self adjustLabelWidth:self.badge];
        self.badge.width = self.badge.width - 4;
        self.badge.height = 12;
        if (self.badge.width < self.badge.height) {
            self.badge.width = self.badge.height;
        }
        
        self.badge.center = CGPointMake(self.width, 0);
        self.badge.font = [UIFont boldSystemFontOfSize:9];
        self.badge.layer.cornerRadius = self.badge.height / 2;
    }
    self.badge.hidden = NO;
}

//lazy loading
- (void)badgeInit {
    
    if (self.badgeBgColor == nil) {
        self.badgeBgColor = [UIColor redColor];
    }
    if (self.badgeTextColor == nil) {
        self.badgeTextColor = [UIColor whiteColor];
    }
    if (nil == self.badge) {
        CGFloat redotWidth = 8;
        CGRect frm = CGRectMake(self.width, -redotWidth, redotWidth, redotWidth);
        self.badge = [[UILabel alloc] initWithFrame:frm];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.center = CGPointMake(self.width, 0);
        self.badge.backgroundColor = self.badgeBgColor;
        self.badge.textColor = self.badgeTextColor;
        self.badge.text = @"";
        self.badge.tag = DLBadgeStyleRedDot;//red dot by default
        self.badge.layer.cornerRadius = self.badge.width / 2;
        self.badge.layer.masksToBounds = YES;//very important
        [self addSubview:self.badge];
    }
}

#pragma mark --  other private methods
- (void)adjustLabelWidth:(UILabel *)label {
    
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [UIFont fontWithName:@"Arial" size:label.font.pointSize];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = label.frame;
    frame.size = labelsize;
    [label setFrame:frame];
}

#pragma mark -- animation

//if u want to add badge animation type, follow steps bellow:
//1. go to definition of DLBadgeAnimType and add new type
//2. go to category of CAAnimation+WAnimation to add new animation interface
//3. call that new interface here
- (void)beginAnimation {
    
    if (self.aniType == DLBadgeAnimTypeBreathe)
    {
        [self.badge.layer addAnimation:[CAAnimation opacityForever_Animation:1.4]
                                forKey:kBadgeBreatheAniKey];
    }
    else if (self.aniType == DLBadgeAnimTypeShake)
    {
        [self.badge.layer addAnimation:[CAAnimation shake_AnimationRepeatTimes:MAXFLOAT
                                                                      durTimes:1
                                                                        forObj:self.badge.layer]
                                forKey:kBadgeShakeAniKey];
    }
    else if (self.aniType == DLBadgeAnimTypeScale)
    {
        [self.badge.layer addAnimation:[CAAnimation scaleFrom:1.4
                                                      toScale:0.6
                                                     durTimes:1
                                                          rep:MAXFLOAT]
                                forKey:kBadgeScaleAniKey];
    }
}


#pragma mark -- setter/getter
- (UILabel *)badge {
    
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadge:(UILabel *)label {
    
    objc_setAssociatedObject(self, &badgeLabelKey, label, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)badgeBgColor {
    
    return objc_getAssociatedObject(self, &badgeBgColorKey);
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor {
    
    objc_setAssociatedObject(self, &badgeBgColorKey, badgeBgColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)badgeTextColor {
    
    return objc_getAssociatedObject(self, &badgeTextColorKey);
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN);
}
- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}
- (DLBadgeAnimType)aniType {
    
    id obj = objc_getAssociatedObject(self, &badgeAniTypeKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj integerValue];
    }
    else
        return DLBadgeAnimTypeNone;
}

- (void)setAniType:(DLBadgeAnimType)aniType {
    
    NSNumber *numObj = @(aniType);
    objc_setAssociatedObject(self, &badgeAniTypeKey, numObj, OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)badgeFrame {
    
    id obj = objc_getAssociatedObject(self, &badgeFrameJey);
    if (obj != nil && [obj isKindOfClass:[NSArray class]] && [obj count] == 4 ) {
        CGFloat x = [obj[0] floatValue];
        CGFloat y = [obj[1] floatValue];
        CGFloat width = [obj[2] floatValue];
        CGFloat height = [obj[3] floatValue];
        return  CGRectMake(x, y, width, height);
    } else
        return CGRectZero;
}

- (void)setBadgeFrame:(CGRect)badgeFrame {
    
    
}



// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}
-(void)leftBorder:(CGRect)rect{
    CALayer *leftBorder = [CALayer layer];
    CGFloat height = self.frame.size.height ;
    leftBorder.frame = FRAME(0.0f, 0, 0.5f, height);
    if (rect.size.height) {
         leftBorder.frame =  rect;
    }
  
    [self.layer addSublayer:leftBorder];
    leftBorder.backgroundColor = COL_GRAY_LINE.CGColor;
}
-(void)Border:(CGRect)rect borderColor:(UIColor *)color
{
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = rect;
    leftBorder.backgroundColor = color.CGColor;
    [self.layer addSublayer:leftBorder];
    
}

-(void)leftBorder:(CGRect)rect borderColor:(UIColor *)color{
    CALayer *leftBorder = [CALayer layer];
    CGFloat height = self.frame.size.height ;
    leftBorder.frame = FRAME(0.0f, 0, 0.5f, height);
    if (rect.size.height) {
        leftBorder.frame =  rect;
    }
    leftBorder.backgroundColor = color.CGColor;
    [self.layer addSublayer:leftBorder];
    
}


-(void)rightBorder:(CGRect)rect{
    CALayer *rightBorder = [CALayer layer];
    CGFloat height = self.frame.size.height ;
    rightBorder.frame = FRAME(self.frame.size.width, 0, 0.5f, height);
    if (rect.size.height) {
        rightBorder.frame =  rect;
    }
    
    [self.layer addSublayer:rightBorder];
    rightBorder.backgroundColor = COL_GRAY_LINE.CGColor;
}

-(void)bottomBorder:(CGRect)rect{
    CALayer *bottomBorder = [CALayer layer];
    CGFloat width = self.frame.size.width ;
    bottomBorder.frame = FRAME(0.0f, self.frame.size.height-0.5, width, 0.5f);
    if (rect.size.width) {
        bottomBorder.frame =  rect;
    }
    bottomBorder.backgroundColor = COL_GRAY_LINE.CGColor;
    [self.layer addSublayer:bottomBorder];
  
}
-(void)topBorder:(CGRect)rect{
    CALayer *topBorder = [CALayer layer];
    CGFloat width = self.frame.size.width ;
    topBorder.frame = FRAME(0.0f, 0, width,0.5f );
    if (rect.size.width) {
        topBorder.frame =  rect;
    }
    [self.layer addSublayer:topBorder];
    topBorder.backgroundColor = COL_GRAY_LINE.CGColor;
}

-(void)setViewWithRadius:(CGFloat)radius color:(CGColorRef )color{
    self.layer.masksToBounds = YES;
    
    if (self.height == radius) {
        self.layer.cornerRadius = self.height/2.;
    }else{
        self.layer.cornerRadius = radius;
    }
    
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = color;
}

-(void)setViewWithRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    if (self.height == radius) {
        self.layer.cornerRadius = self.height/2.;
    }else{
        self.layer.cornerRadius = radius;
    }
}
/// 性能优化切圆角 size(8,8) 圆角为8
-(void)setViewFilletSize:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)setViewFilletRadius:(CGFloat)radius color:(UIColor*)color{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    [maskLayer setLineWidth:1];
//    [maskLayer setFillColor:color.CGColor];
    [maskLayer setStrokeColor:color.CGColor];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setViewWithRadius:(CGFloat)radius BorderColor:(UIColor *)color BorderWidth:(CGFloat)borderwidth{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = borderwidth;
}


- (void)arrangeButtonItemsWithDataSource:(NSArray *)dataArray OriginalButtonX:(CGFloat)orignalX OriginalButtonY:(CGFloat)origanalY{
   self.originalx = orignalX;
    self.originaly = origanalY;
    CGFloat originalX = PX(30);
    NSInteger  theRowOfbutton = 0;
    
    for (int i = 0; i < dataArray.count; i ++) {
        NSString * string = dataArray[i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        CGSize size = [string calculateSize:CGSizeMake(1000, PX(60)) font:FONT(PX(28))];
        if ((originalX + size.width + PX(30) + PX(20)) < (SCREEN_WIDTH - PX(30))) {
            button.frame = FRAME(originalX, origanalY + theRowOfbutton * PX(80), size.width + PX(30), PX(60));
            originalX  = originalX + size.width + PX(30) + PX(20);
        }else{
            originalX = PX(30);
            theRowOfbutton ++;
        }
        
        [button setTitle:string forState:UIControlStateNormal];
        [button setViewWithRadius:button.height /2 BorderColor:COL_GRAY_LINE BorderWidth:PX(1)];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:button.size] forState:UIControlStateSelected];
        [self addSubview:button];
    }

}

-(void)setViewLayerThemeColors:(CGSize)size {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.colors = @[(__bridge id)COL_CHANG_START.CGColor,(__bridge id)COL_CHANG_END.CGColor];
    [self.layer addSublayer:layer];
}

-(void)createViewShadDow:(UIColor *)color{
    //阴影的颜色
    self.layer.shadowColor = [color CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 3);
    //阴影透明度
    self.layer.shadowOpacity = 0.3;
    //阴影圆角度数
    self.layer.shadowRadius = 7;
}

//
//- (CGFloat)getAllButtonItemsWithDatasource:(NSArray *)dataArray OriginalButtonX:(CGFloat)originalX OrignalButtonY:(CGFloat)originalY{
//    originalX = originalx;
//    NSInteger  theRowOfbutton = 0;
//
//    for (int i = 0; i < dataArray.count; i ++) {
//        NSString * string = dataArray[i];
//        CGSize size = [string calculateSize:CGSizeMake(1000, PX(60)) font:FONT(PX(28))];
//
//        if ((originalX + size.width + PX(30) + PX(20)) < (SCREEN_WIDTH - originalX)) {
//            originalX  = originalX + size.width + PX(30) + PX(20);
//        }else{
//            originalX = PX(30);
//            theRowOfbutton ++;
//        }
//    }
//    return originalY * theRowOfbutton;
//}



#pragma mark - 计算
#pragma mark 计算一个UIView的 endX = x坐标 + width + 格外加上的extraX
- (CGFloat)getEndXwith:(CGFloat)extraX{
    return self.frame.origin.x+self.frame.size.width+extraX;
}

#pragma mark 计算一个UIView的 endY = y坐标 + height + 格外加上的extraY
- (CGFloat)getEndYwith:(CGFloat)extraY{
    return self.frame.origin.y+self.frame.size.height+extraY;
}

#pragma mark 设置所有子view垂直居中
- (void)setSubViewsMiddle{
    if (self) {
        for (UIView *subview in self.subviews)
        {
            CGRect newCGRect = subview.frame;
            newCGRect.origin.y = (self.frame.size.height - subview.frame.size.height)/2.0f;
            subview.frame = newCGRect;
        }
    }
}

#pragma mark 设置所有子view水平居中
- (void)setSubViewsCenter{
    if (self) {
        for (UIView *subview in self.subviews)
        {
            CGRect newCGRect = subview.frame;
            newCGRect.origin.x = (self.frame.size.width - subview.frame.size.width)/2.0f;
            subview.frame = newCGRect;
        }
    }
}

#pragma mark 让view在父View中垂直居中
- (void)setUIViewMiddle{
    self.y=(self.superview.frame.size.height-self.frame.size.height)/2;
}

#pragma mark 让view在父View中水平居中
- (void)setUIViewCenter{
    self.x=(self.superview.frame.size.width-self.frame.size.width)/2;
}

#pragma mark 将UIView在指定parentView里水平居中
- (void)setUIViewCenterOf:(UIView *)parentView{
    if (parentView != nil) {
        CGRect newCGRect = self.frame;
        newCGRect.origin.x = (parentView.frame.size.width - self.frame.size.width)/2.0f;
        self.frame = newCGRect;
    }
}

#pragma mark 将UIView在指定parentView里垂直居中
- (void)setUIViewMiddleOf:(UIView *)parentView{
    if (parentView != nil) {
        CGRect newCGRect = self.frame;
        newCGRect.origin.y = (parentView.frame.size.height - self.frame.size.height)/2.0f;
        self.frame = newCGRect;
    }
}

#pragma mark 将UIView在指定parentView里垂直并水平居中
- (void)setUIViewVerticalAndHorizontalCenterOf:(UIView *)parentView{
    if (parentView != nil) {
        CGRect newCGRect = self.frame;
        newCGRect.origin.y = (parentView.frame.size.height - self.frame.size.height)/2.0f;
        newCGRect.origin.x = (parentView.frame.size.width - self.frame.size.width)/2.0f;
        self.frame = newCGRect;
    }
}

#pragma mark 计算实例view到指定的superView的Y值
- (CGFloat)offsetyFromSuperView:(UIView *)superView{
    int i = 0;
    CGFloat offsetY = self.frame.origin.y;
    UIView *nextSuperView = self.superview;
    
    while (nextSuperView && nextSuperView != superView && i<20) {
        offsetY += nextSuperView.frame.origin.y;
        nextSuperView = nextSuperView.superview;
        i++;
    }
    return offsetY;
}

#pragma mark 设置UIVIiew的border
- (void)setBorderWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left{
    CALayer *layer = self.layer;
    
    if ((top == right == bottom == left) && top>0) {
        CALayer *border = [CALayer layer];
        border.borderWidth = top;
        [border setBorderColor:self.layer.borderColor];
        [layer addSublayer:border];
        return;
    }
    
    if (top>0) {
        CALayer *topBorder = [CALayer layer];
        topBorder.borderWidth = top;
        topBorder.frame = CGRectMake(0, 0, layer.frame.size.width, top);
        [topBorder setBorderColor:self.layer.borderColor];
        [layer addSublayer:topBorder];
    }
    
    if (right>0) {
        CALayer *rightBorder = [CALayer layer];
        rightBorder.borderWidth = right;
        rightBorder.frame = CGRectMake(layer.frame.size.width-right, 0, right, layer.frame.size.height);
        [rightBorder setBorderColor:self.layer.borderColor];
        [layer addSublayer:rightBorder];
    }
    
    if (bottom>0) {
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.borderWidth = bottom;
        bottomBorder.frame = CGRectMake(0, layer.frame.size.height-bottom, layer.frame.size.width, bottom);
        [bottomBorder setBorderColor:self.layer.borderColor];
        [layer addSublayer:bottomBorder];
    }
    
    if (left>0) {
        CALayer *leftBorder = [CALayer layer];
        leftBorder.borderWidth = left;
        leftBorder.frame = CGRectMake(0, 0, left, layer.frame.size.height);
        [leftBorder setBorderColor:self.layer.borderColor];
        [layer addSublayer:leftBorder];
    }
    
}

#pragma mark 弹出view,类似于弹簧效果
- (void)showAnimationWithSpring
{
    self.hidden=NO;
    CGAffineTransform newTransform =
    CGAffineTransformScale(self.transform, 0.1, 0.1);
    [self setTransform:newTransform];
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGAffineTransform newTransform =
        CGAffineTransformScale(self.transform, 11, 11);
        [self setTransform:newTransform];
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            [self setTransform:CGAffineTransformIdentity];
            
            
        }completion:^(BOOL finished){
            
            
        }];
        
    }];
}

#pragma mark 关闭view,类似于弹簧效果
- (void)hiddenAnimationWithSpring
{
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGAffineTransform newTransform =
        CGAffineTransformScale(self.transform, 1.1, 1.1);
        [self setTransform:newTransform];
        
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGAffineTransform newTransform =
            CGAffineTransformScale(self.transform, 0.1, 0.1);
            [self setTransform:newTransform];
            self.alpha=0;
            
        }completion:^(BOOL finished){
            [self setTransform:CGAffineTransformIdentity];
            self.hidden=YES;
            self.alpha=1;
        }];
        
    }];
}
-(UIImage*)captureViewframe:(CGRect)fra{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, fra);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}
-(void)roundCount:(CGSize )size diretionNum:(UIRectCorner)corner{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corner
                                                     cornerRadii:size];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    
}
- (UIImage *) screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)SetShadowWithframe:(CGRect)frame colors:(NSArray *)colors
{
    UIImageView *views = [[UIImageView alloc]initWithFrame:frame];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0,0, frame.size.width, frame.size.height);
    gradient.colors = colors;
    [views.layer insertSublayer:gradient atIndex:0];
    [self addSubview:views];
}



@end

