/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "UIViewExt.h"

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

@end
