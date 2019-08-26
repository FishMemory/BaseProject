//
//  NSString+syCategory.h
//  syUtil
//
//  Created by 世缘 on 15/2/3.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (syCategory)
- (NSString *)URLEncodedStringWithEncoding:(CFStringEncoding)encoding;

/**
 时间字符串格式例如 2017-06-07 22:23:38 转换成 自定义格式
 @param formatType 自定义格式 例如 YYYY/MM/dd
 @param fromTimeType 从那种格式 例如 2017-06-07 22:23:38   对应type 传入 yyyy-MM-dd HH:mm:ss
 @return return value description
 */
-(NSString *)timeStrTotimeFormatterType:(NSString *)formatType fromTimeType:(NSString*)fromTimeType;

/**
 *  时间字符串格式例如 2017-06-07 22:23:38 转换成 时间戳
 *
 *  @param type 格式必须与传入的日期格式一致 例如 2017-06-07 22:23:38   对应type yyyy-MM-dd HH:mm:ss
 *
 *  @return  时间戳 字符串
 */
-(NSString *)dateStrToIntervalForMatterType:(NSString *)type;

/**
 *  编码
 *
 *  @return 编码后的URL
 */
-(NSString *) URLEncodingUTF8String;//编码

/**
 *  解码
 *
 *  @return 解码后的URL
 */
-(NSString *) URLDecodingUTF8String;
/**
 *  获取当前月份 天数
 *
 *  @return NSInteger
 */
+(NSInteger)getNumberOfDaysInMonth;
/**
 *  获取当前年
 *
 *  @return NSInteger
 */
+(NSInteger)getYear;

/**
 *  获取当前日
 *
 *  @return NSInteger
 */
+(NSInteger)getDay;
/**
 *  获取当前月份
 *
 *  @return NSInteger
 */
+(NSInteger)getMonth;
/**
 *  获取星期
 *
 *  @return
 */
+(NSInteger)getWeekDay;
/**
 *  获取小时
 *
 *  @return 
 */
+(NSInteger)getHour;
/**
 *  时间戳与当前时间比较，返回相隔的天数
 *
 *  @return 两个时间的间隔天数
 */
- (NSInteger)dateCalculations;

- (BOOL)stringContainsEmoji;
-(NSString *)takeOutEmoji;

- (NSString *)replaceUnicode;


- (NSString *)lowercaseFirstCharacter;

- (NSString *)escapeHTML;
- (NSInteger)Filesize;
- (NSString *)URLEncodedString;


/**
 *  标准时间格式字符串 转换成 时间戳
 *
 *  @param type 格式必须与传入的日期格式一致  2016/4/20   对应type yyyy/MM/dd
 *
 *  @return  时间戳 字符串
 */
-(NSString *)dateCustomTotimeIntervalForMatterType:(NSString *)type;


/**
 *  时间戳转格式化日期
 *
 *  @param created_at 时间戳
 *  @param formatType 格式类型
 *
 *  @return return value description
 */
-(NSString *)timeIntervalForMatterToDateformatType:(NSString *)formatType;

/**
 设置两种不同的字体大下，颜色 根据输入的rang
 @param leadRang 前部分
 @param laedColor 前部分颜色
 @param leadFontsize 前部分字号
 @param trailColor 后面的颜色
 @param trailFontsize 后面的字体大小
 @return 返回可变字符串
 */
-(NSMutableAttributedString *)setDiffFontAndColorWithRang:(NSRange)leadRang  laedColor:(UIColor *)laedColor leadFontsize:(CGFloat)leadFontsize trailColor:(UIColor *)trailColor trailFontsize:(CGFloat)trailFontsize;

/**
 设置两种不同的字体大小
 @param leadRang 前部分的rang
 @param leadsize 前部分的字体大小
 @param trailsize 后部分的字体大小
 @return  可变字符串
 */
-(NSMutableAttributedString *)setDiffFontWithRang:(NSRange)leadRang  leadFontsize:(CGFloat)leadsize  ltrailFontsize:(CGFloat)trailsize;


/**
 设置两个不同的字体颜色

 @param leadRang 前部分
 @param lColor 前面字颜色
 @param tColor 后面颜色
 @return   处理后的可变字符串
 */
-(NSMutableAttributedString *)setDiffFontColorWithleadRang:(NSRange)leadRang  laedColor:(UIColor *)lColor  trailColor:(UIColor *)tColor;
/**
 *  设置多个不同的字体颜色
 *
 *  @param leadRang        leadRang 前部分rang
 *  @param allPartColor    字体颜色
 *  @param centerPartColor 中间字体颜色
 *
 *  @return 返回可变字符串
 */
-(NSMutableAttributedString *)setDifferentColorRang:(NSRange)centerRang  centerPartColor:(UIColor *)centerPartColor  traillingPartColor:(UIColor *)traillingPartColor;
/**
 *  判断数组是否含有该字符串
 *
 *  @param array 对比的数组
 *
 *  @return 若有 返回结果数组
 */
-(NSArray *)predicateFindStfingArray:(NSArray *)array;
-(NSString *)compareTime;
/**
 *  去除字符串中空格
 *
 *  @return
 */
-(NSString *)replaceSpace;
/**
 *  设置行间距 返回 NSAttributedString
 *
 *  @param lineSpace lineSpace description
 *  @param font
 *
 *  @return return NSAttributedString
 */
-(NSAttributedString *)setTextSpace:(CGFloat)lineSpace withFont:(UIFont*)font;
-(NSString *)PriceSet;

/**
 *  删除文件 要删除的文件路径调用此方法
 *
 *  @return 是否成功 YES NO
 */
-(BOOL)removeFile;

-(NSString*)TimeformatFromSeconds;

//根据时间戳判断状态
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;
//获取当前日期
+(NSString *)getTodayDate;
//获取当前日期时间戳
+(NSString *)getNowtImeInterval;

/**
 设置文字删除线
 
 @param color 删除线颜色
 @return NSMutableAttributedString
 */
-(NSMutableAttributedString *)setTextLine:(UIColor *)color font:(UIFont *)font;

/**
 设置行间距
 
 @param height 间距
 @return 可变字串
 */
-(NSMutableAttributedString *)setTextLineSpace:(CGFloat)height;

// 设置不同字体
-(NSMutableAttributedString *)setDifFont:(UIFont *)leadfont leadpartRang:(NSRange)leadRang trailFont:(UIFont *)trailFont;

/**
 设置多段字体颜色 及字体加粗

 @param firstRang firstRang description
 @param firstColor firstColor description
 @param secondColor secondColor description
 @param sRang sRang description
 @param otherColor otherColor description
 @param fontSize fontSize description
 @return return value description
 */
-(NSMutableAttributedString *)setDifColorRang:(NSRange)firstRang  firstColor:(UIColor *)firstColor  second:(UIColor *)secondColor secondRang:(NSRange)sRang other:(UIColor*)otherColor  fontSize:(CGFloat)fontSize;

/// 时长秒数 转时间 时分秒格式 11：34：45
+(NSString*)durationChangeStrWithtimeInterval:(NSInteger)duration;

/// 字符串encode
- (NSString*)urlencode;
@end
