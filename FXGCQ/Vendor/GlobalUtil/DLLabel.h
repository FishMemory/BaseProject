
///----------------------------------
///  @name Label
///----------------------------------

#import <UIKit/UIKit.h>

@interface DLLabel : UILabel

// label inset
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (assign, nonatomic) CGSize fontSize;
@property (strong, nonatomic)  UIView  *backView;
@property (assign, nonatomic)   CGSize nameSize;
@property (assign, nonatomic)   CGSize nameSizeH;
- (id)initWithText:(NSString *)text
              font:(UIFont *)font
         textColor:(UIColor *)color;

- (id)initWithText:(NSString *)text
              font:(UIFont *)font
         textColor:(UIColor *)color Frame:(CGRect)frame ;

- (id)initWithText:(NSString *)text
              font:(UIFont *)font
         textColor:(UIColor *)color
   backgroundColor:(UIColor *)backgroundColor;

-(CGSize)getFontSize;
//
/**
 *   在Label 下插入一个 渐变图层
 *
 *  @param superViews label 所在的图层
 */
-(void)SetBackViews:(UIView *)superViews;
/** 
 Label上的字体显示阴影
 */
-(void)setFontShadow;

// 创建 label 设置 字体 大小
+(UILabel *)creatLabel:(UIFont *)font frame:(CGRect)frame textColor:(UIColor *)color;

- (UILabel *)creatWithText:(NSString *)text Frame:(CGRect)frame;
- (UILabel *)creatWithfont:(UIFont *)font textColor:(UIColor *)color Frame:(CGRect)frame Text:(NSString *)text;
@end
