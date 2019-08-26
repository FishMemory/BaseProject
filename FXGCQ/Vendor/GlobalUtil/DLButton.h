
///----------------------------------
///  @name 按钮初始化
///----------------------------------

#import <Foundation/Foundation.h>

@interface DLButton : NSObject

/**
 *  Button
 *
 *  @param type           button type
 *  @param frame          button frame
 *  @param title          button title
 *  @param color          title color
 *  @param BGImage        background image
 *  @param highLightImage highloght image
 *  @param object         target object
 *  @param sec            action
 *  @param buttonEvent    for events
 */


+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  titleColor: (UIColor *)color backGroundImage: (UIImage *)BGImage highLightImage: (UIImage *)highLightImage target: (id)object Selector: (SEL)sec selectorState: (UIControlEvents)buttonEvent title: (NSString *)title ;
/**
 *  创建buttn 圆切角
 *
 *  @param type        button type
 *  @param frame       button frame
 *  @param color       title color
 *  @param BGImage     background image
 *  @param object      target object
 *  @param sec         action
 *  @param buttonEvent for events
 *  @param title       button title
 *  @param radius      round radius
 *
 *  @return button
 */
+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  titleColor: (UIColor *)color backGroundImage: (UIImage *)BGImage target: (id)object Selector: (SEL)sec selectorState: (UIControlEvents)buttonEvent title: (NSString *)title cornerRadius:(CGFloat)radius;
/**
 *  创建BUtton 无图
 *
 *  @param type        type description
 *  @param frame       frame description
 *  @param color       color description
 *  @param object      object description
 *  @param sec         sec description
 *  @param buttonEvent buttonEvent description
 *  @param title       title description
 *  @param radius      radius description
 *
 *  @return
 */
+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  titleColor: (UIColor *)color  target: (id)object Selector: (SEL)sec selectorState: (UIControlEvents)buttonEvent title: (NSString *)title cornerRadius:(CGFloat)radius;


+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  titleColor: (UIColor *)color title: (NSString *)title cornerRadius:(CGFloat)radius;

+(NSMutableArray *) setButtonArrayName:(NSArray *)nameArray selectImageArray:(NSArray *)selectImageArray image:(NSArray *)imageArray fontSize:(CGFloat)fontSize;


+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  tintColor:(UIColor *)color fontSize:(CGFloat)size image:(NSString*)imageName;
@end
