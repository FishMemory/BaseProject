//
//  NSString+syCategory.m
//  syUtil
//
//  Created by 世缘 on 15/2/3.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import "NSString+syCategory.h"
@implementation NSString (syCategory)
-(NSString *)URLEncodingUTF8String{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    
    return result;
}


#pragma mark - 编码
- (NSString *)URLEncodedStringWithEncoding:(CFStringEncoding)encoding
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             encoding));
    return result;
}

#pragma mark - 解码
-(NSString *)URLDecodingUTF8String{
    if(self){
        NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self,
CFSTR(""), kCFStringEncodingUTF8));
        return result;
    }
    
    return self;
}


/**
 时间字符串格式例如 2017-06-07 22:23:38 转换成 自定义格式
 @param formatType 自定义格式 例如 YYYY/MM/dd
 @param fromTimeType 从那种格式 例如 2017-06-07 22:23:38   对应type 传入 yyyy-MM-dd HH:mm:ss
 @return return value description
 */
-(NSString*)timeStrTotimeFormatterType:(NSString *)formatType fromTimeType:(NSString*)fromTimeType{
    if (!(self.length > 0)) {
        return @"";
    }
    NSString *timeInterval = [self dateStrToIntervalForMatterType:formatType];
    NSString *updateTime = [timeInterval timeIntervalForMatterToDateformatType:fromTimeType];
    return updateTime;
}

/**
 *  时间字符串格式例如 2017-06-07 22:23:38 转换成 时间戳
 *
 *  @param type 格式必须与传入的日期格式一致 例如 2017-06-07 22:23:38   对应type yyyy-MM-dd HH:mm:ss
 *
 *  @return  时间戳 字符串
 */
-(NSString *)dateStrToIntervalForMatterType:(NSString *)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:type];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate* dates = [formatter dateFromString:self]; //------------将字符串按formatter转成nsdate
    
    //    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    //    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
    //    时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%lu", (long)[dates timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp);
    return timeSp;
}


+(NSInteger)getNumberOfDaysInMonth{
    NSCalendar *calendars = [NSCalendar currentCalendar];
    NSRange range = [calendars rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}
+(NSInteger)getDay{
    
    return [self getTimeWithString:@"day"];
}

+(NSInteger)getYear{
    
    return [self getTimeWithString:@"year"];
}
+(NSInteger)getMonth{
    
    return [self getTimeWithString:@"month"];
}
+(NSInteger)getWeekDay{
    
    return [self getTimeWithString:@"weekDay"];
}
+(NSInteger)getHour{
    
    return [self getTimeWithString:@"Hour"];
}
+(NSInteger)getTimeWithString:(NSString *)time
{
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    if ([time isEqualToString:@"day"]) {
         NSInteger day = [dateComponent day];
        return day;
    }else if ([time isEqualToString:@"month"]){
         NSInteger month = [dateComponent month];
        return month;
    }else if ([time isEqualToString:@"year"]){
        NSInteger years = [dateComponent year];
        return years;
    }else if ([time isEqualToString:@"weekDay"]){
        NSInteger weekdays = [dateComponent weekday];
        return weekdays;
    }else if ([time isEqualToString:@"Hour"]){
        NSInteger hours = [dateComponent hour];
        return hours;
    }
    
    return 0;
 
}
//FIXME: 获取当前时间戳
+(NSString *)getNowtImeInterval{
    NSDate *senddate = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
//    NSLog(@"date2时间戳 = %@",date2);
    return date2;
}
//FIXME:  获取当前日期
+(NSString *)getTodayDate
{
    NSDate *senddate = [NSDate date];
//    NSLog(@"date1时间戳 = %ld",time(NULL));
//    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
//    NSLog(@"date2时间戳 = %@",date2);
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date1 = [dateformatter stringFromDate:senddate];
//    NSLog(@"获取当前时间   = %@",date1);
    
    // 时间戳转时间
    
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[senddate timeIntervalSince1970]];
//    NSString *confromTimespStr = [dateformatter stringFromDate:confromTimesp];
//    NSLog(@"时间戳转时间   = %@",confromTimespStr);
    return date1;
}

/**
 *  标准时间格式字符串 转换成 想要 时间格式  使用转换的时间直接调用 2014080911223
 *  
 *  @param type 格式必须与传入的日期格式一致  2016/4/20   对应type yyyy/MM/dd
 *
 *  @return  时间戳 字符串
 */
-(NSString *)dateCustomTotimeIntervalForMatterType:(NSString *)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:type];

    NSDate* dates = [formatter dateFromString:self]; //------------将字符串按formatter转成nsdate
    
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
//    时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%lu", (long)[dates timeIntervalSince1970]];
    
    return timeSp;
    NSLog(@"timeSp:%@",timeSp); 
}

/**
 *  时间戳 转换成时间
 *
 *  @return NSString
 */
-(NSString *)timeIntervalForMatterToDateformatType:(NSString *)formatType{
    NSString * str = self.length > 0 ? self : @"" ;//时间戳
    NSTimeInterval time = [str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //    NSLog(@"date:%@",[detaildate description]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatType];
    NSString* currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}




- (NSInteger)dateCalculations{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //创建了两个日期对象
    NSDate *newDate=[NSDate date];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[date2 timeIntervalSinceDate:newDate];
    
    int days=abs(((int)time)/(3600*24));
    //    int hours=fabs(((int)time)%(3600*24)/3600);
    return days;
}
//判断字符串中是否有emoji表情

-(BOOL)stringContainsEmoji


{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}
/**
 *  emji表情过滤
 *
 *  @return 过滤之后的 NSString 字串
 */
-(NSString *)takeOutEmoji{
    __block NSString * returnValue = [NSString stringWithString:self];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if (substring.length == 2){
                                  
                                  returnValue =  [returnValue stringByReplacingOccurrencesOfString:substring withString:@""];
                                  
                                  
                              }
                          }];
    return returnValue;
}
// unicode 转utf8
- (NSString *)replaceUnicode
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    //NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}
#pragma mark - 转换string大小写

- (NSString *)lowercaseFirstCharacter {
    NSRange range = NSMakeRange(0,1);
    NSString *lowerFirstCharacter = [[self substringToIndex:1] lowercaseString];
    return [self stringByReplacingCharactersInRange:range withString:lowerFirstCharacter];
}

- (NSString *)uppercaseFirstCharacter {
    NSRange range = NSMakeRange(0,1);
    NSString *upperFirstCharacter = [[self substringToIndex:1] uppercaseString];
    return [self stringByReplacingCharactersInRange:range withString:upperFirstCharacter];
}
//替换HTML代码
- (NSString *)escapeHTML {
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    [result replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'" withString:@"&#39;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    return result;
}
//返回一个文件夹的大小
- (NSInteger)Filesize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL dir;
    BOOL exist =  [mgr fileExistsAtPath:self isDirectory:&dir];
    if (exist == NO) return 0;
    if (dir) {//self是一个文件夹
        //找出文件夹中的文件名
        NSArray *subpaths = [mgr subpathsAtPath:self];
        //获得全路径
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths)
        {
            NSString *fullpath = [self stringByAppendingPathComponent:subpath];
            //遍历文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullpath isDirectory:&dir];
            if (dir == NO) {
                totalByteSize +=[[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize]integerValue];
            }
            
        }
        return totalByteSize;
        
    }else
    {
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize]integerValue];
    }
    
    
}
//在不是用autolayoyt下计算文本的次存
//- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
//    CGSize expectedLabelSize = CGSizeZero;
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
//        
//        expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    }
//    else {
//        
//        expectedLabelSize = [self sizeWithFont:font
//                             constrainedToSize:size
//                                 lineBreakMode:NSLineBreakByWordWrapping];
//    }
//    
//    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
//}

- (NSString *)URLEncodedString
{
    
    //NSAssert(<#condition#>, <#desc, ...#>)
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,  NULL,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

/**
 设置两种不同的字体大下，颜色 根据输入的rang
 @param leadRang 前部分
 @param laedColor 前部分颜色
 @param leadFontsize 前部分字号
 @param trailColor 后面的颜色
 @param trailFontsize 后面的字体大小
 @return 返回可变字符串
 */
-(NSMutableAttributedString *)setDiffFontAndColorWithRang:(NSRange)leadRang  laedColor:(UIColor *)laedColor leadFontsize:(CGFloat)leadFontsize trailColor:(UIColor *)trailColor trailFontsize:(CGFloat)trailFontsize  {
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (!(self.length >0)) {
        return AttributedStr;
    }
    // 设置 前面字体颜色
    [AttributedStr addAttribute:NSForegroundColorAttributeName  value:laedColor  range:leadRang];
    // 设置 后面字体颜色
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:trailColor  range:NSMakeRange(leadRang.length, AttributedStr.length- leadRang.length)];
    // 设置 前面字体大小
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:leadFontsize] range:leadRang];
    // 设置 后面字体大小
    [AttributedStr addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:trailFontsize] range:NSMakeRange(leadRang.length, AttributedStr.length-leadRang.length)];
    
    return AttributedStr;
}

/**
 设置两种不同的字体大小
 @param leadRang 前部分的rang
 @param leadsize 前部分的字体大小
 @param trailsize 后部分的字体大小
 @return  可变字符串
 */
-(NSMutableAttributedString *)setDiffFontWithRang:(NSRange)leadRang  leadFontsize:(CGFloat)leadsize  ltrailFontsize:(CGFloat)trailsize  {
    NSString *string = self.length>0?self:@"";
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    
    // 设置 前面字体大小
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:leadsize] range:leadRang];
    // 设置 后面字体大小
    [AttributedStr addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:trailsize] range:NSMakeRange(leadRang.length, AttributedStr.length-leadRang.length)];
    
    return AttributedStr;
}
/**
 *  设置两个不同的字体颜色
 *
 *  @param editString         editString 改变的文字
 *  @param leadRang           leadRang 前部分rang
 *  @param laedPartColor      前面字体颜色
 *  @param traillingPartColor 后面字体颜色
 *
 *  @return 返回可变字符串
 */
-(NSMutableAttributedString *)setDiffFontColorWithleadRang:(NSRange)leadRang  laedColor:(UIColor *)lColor  trailColor:(UIColor *)tColor {
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (AttributedStr == nil || !(AttributedStr.length > 0) ) {
        return AttributedStr;
    }
    // 设置 前面字体颜色
    [AttributedStr addAttribute:NSForegroundColorAttributeName  value:lColor  range:leadRang];
    // 设置 后面字体颜色
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:tColor  range:NSMakeRange(leadRang.length, AttributedStr.length - leadRang.length)];
    
    return AttributedStr;
}

-(NSMutableAttributedString *)setDifferentColorRang:(NSRange)centerRang  centerPartColor:(UIColor *)centerPartColor  traillingPartColor:(UIColor *)traillingPartColor {
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (AttributedStr == nil || !(AttributedStr.length > 0) ) {
        return AttributedStr;
    }
    // 设置 字体颜色
    [AttributedStr addAttribute:NSForegroundColorAttributeName  value:traillingPartColor  range:NSMakeRange(0, self.length)];
    // 设置 中间字体颜色
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:centerPartColor range:centerRang];
    return AttributedStr;
}
// 评论 回复 回复
-(NSMutableAttributedString *)setDifColorRang:(NSRange)firstRang  firstColor:(UIColor *)firstColor  second:(UIColor *)secondColor secondRang:(NSRange)sRang other:(UIColor*)otherColor  fontSize:(CGFloat)fontSize{
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (AttributedStr == nil || !(AttributedStr.length > 0) ) {
        return AttributedStr;
    }
    // 设置 全部字体颜色
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, self.length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName  value:otherColor  range:NSMakeRange(0, self.length)];
    //   第一
    if (firstRang.length > 0) {
        // 设置 第一字体
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontSize] range:firstRang];
      [AttributedStr addAttribute:NSForegroundColorAttributeName  value:firstColor  range:firstRang];
    }
    
    // 设置 第二字体
    if(sRang.length > 0){
       [AttributedStr addAttribute:NSFontAttributeName  value:[UIFont boldSystemFontOfSize:fontSize] range:sRang];
      // 设置 中间字体颜色
      [AttributedStr addAttribute:NSForegroundColorAttributeName value:secondColor range:sRang];
    }
   
    return AttributedStr;
  
   
}


-(NSString *)replaceSpace
{
    if (self.length > 0) {
        NSString *string =  [self stringByReplacingOccurrencesOfString:@" " withString:@""];
        return string;
    }
    NSString *string  = @"";
    return string;
}

/**
 *  判断数组是否含有该字符串
 *
 *  @param array 对比的数组
 *
 *  @return 若有 返回结果数组
 */
-(NSArray *)predicateFindStfingArray:(NSArray *)array{
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"SELF == %@",self ];
    NSArray *plartformArray = [array filteredArrayUsingPredicate:thePredicate];
    return plartformArray;
}
-(NSString *)compareTime{
    NSString *timeString =self;
    //    NSArray *array =  [timeString componentsSeparatedByString:@"yue"];
    //    NSString *firstYearString = [array firstObject];
    //    NSString *lastString = [array objectAtIndex:1];
    //    NSString *firstMonthString = [[lastString componentsSeparatedByString:@"月"] firstObject];
    //
    //    NSString *lastMonthString = [[[array lastObject] componentsSeparatedByString:@"月"] firstObject];
    //    NSString *lastYearString = [[lastString componentsSeparatedByString:@"月"] lastObject];
    
    timeString  = [timeString substringToIndex:timeString.length-1];
    NSArray *array =  [timeString componentsSeparatedByString:@"月"];
    
    NSString *firstYearString = [[array firstObject] substringToIndex:4];
    
    NSString *firstMonthString = [[array firstObject] substringFromIndex:4];
    
    NSString *lastMonthString = [[array lastObject]substringFromIndex:4];
    NSString *lastYearString = [[array lastObject] substringToIndex:4];
    
    NSString *dataTimeString = [NSString stringWithFormat:@"%@年%@月-%@年%@月",firstYearString,firstMonthString,lastYearString,lastMonthString];
    NSLog(@"%@",dataTimeString);
    NSLog(@"起始%@ 年 %@月 \n 结束时间 %@ 年 %@月",firstYearString,firstMonthString,lastYearString,lastMonthString);
    if ([lastYearString integerValue]>[firstYearString integerValue]) {
        return dataTimeString;
    }else if ([lastYearString integerValue]==[firstYearString integerValue]) {
        if ([firstMonthString integerValue]< [lastMonthString integerValue]) {
            return dataTimeString;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
    return dataTimeString;
}
/**
 *  设置行间距 返回 NSAttributedString
 *
 *  @param lineSpace lineSpace description
 *  @param font
 *
 *  @return return NSAttributedString
 */
-(NSAttributedString *)setTextSpace:(CGFloat)lineSpace withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;  //
    paraStyle.alignment = NSTextAlignmentLeft;  //
    paraStyle.lineSpacing = lineSpace;  //设置行间距
    paraStyle.hyphenationFactor = 1;  // 连字属性
    paraStyle.firstLineHeadIndent = 0.0;  // //首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;  // 段首行空白空
    paraStyle.headIndent = 0; // 整体缩进(首行除外)
    paraStyle.tailIndent = 0; //
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self attributes:dic];
    return attributeStr;
}
-(NSString *)PriceSet{
    NSString *price = self;
    if (price.length > 0) {
        if ([price integerValue] > 0) {
            NSString *send = [NSString stringWithFormat:@"%@",@([price integerValue])];
            return send;
        }else{
            return price;
        }
    }
    
    return price;
}
-(NSString*)TimeformatFromSeconds
{
    if (!(self.length > 0)) {
        return nil;
    }
    long seconds = [self integerValue];
    //format of hour
    //    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
}
-(BOOL)removeFile{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    BOOL bRet = [fileMgr fileExistsAtPath:self];
    if (bRet) {
        NSError *err;
        [fileMgr removeItemAtPath:self error:&err];
        return YES;
    }else{
        return NO;
    }
    return YES ;
}

//根据时间戳判断状态
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    } else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    } else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){//时间小于2天
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }else{
        [df setDateFormat:@"yyyy/MM/dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}


-(NSMutableAttributedString *)setTextLine:(UIColor *)color font:(UIFont *)font
{
    //设置显示的价格
    NSString *oldPrice = self;
    //获取字符串的长度
    NSUInteger length = [oldPrice length];
    if (!(length > 0)) {
        return nil;
    }
    
    NSMutableAttributedString *attritu = [[NSMutableAttributedString alloc]initWithString:oldPrice];
    [attritu addAttributes:@{ NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),
                              NSForegroundColorAttributeName: color,
                              NSBaselineOffsetAttributeName: @(0),  NSFontAttributeName: font
                              } range:NSMakeRange(0, length)];
    
    //        NSMutableAttributedString *attritu = [[NSMutableAttributedString alloc]initWithString:oldPrice];
    //        [attritu addAttributes:@{ NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),
    //                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
    //                                  NSBaselineOffsetAttributeName: @(0),  NSFontAttributeName: FONT(PX(24))
    //                                  } range:NSMakeRange(0, length)];
    return attritu;
}

-(NSMutableAttributedString *)setTextLineSpace:(CGFloat)height{
    
    if (!(self.length > 0)) {
        return nil;
    }
    NSMutableAttributedString *attributed   = [[NSMutableAttributedString alloc]initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return attributed;
}

// 设置不同字体
-(NSMutableAttributedString *)setDifFont:(UIFont *)leadfont leadpartRang:(NSRange)leadRang trailFont:(UIFont *)trailFont{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (!(self.length >0)) {
        return AttributedStr;
    }
    // 设置 前面字体
    [AttributedStr addAttribute:NSFontAttributeName value:leadfont range:leadRang];
    // 设置 后面字体
    [AttributedStr addAttribute:NSFontAttributeName  value:trailFont range:NSMakeRange(leadRang.length, AttributedStr.length-leadRang.length)];
    
    return AttributedStr;
}
// 时间转成 02：01：12
+(NSString*)durationChangeStrWithtimeInterval:(NSInteger)duration{
    NSInteger second = 0;
    NSInteger minutes = 0;
    NSInteger hours = 0;
    hours = duration / 3600;
    second = duration % 60;
    minutes = (duration % 3600) / 60;
  
    NSString *secondStr =  @":00";
    secondStr = second > 9 ? [NSString stringWithFormat:@":%@",@(second)] : [NSString stringWithFormat:@":0%@",@(second)];
    NSString *minutesStr = @"00";
    minutesStr = minutes > 9 ? [NSString stringWithFormat:@"%@",@(minutes)] : [NSString stringWithFormat:@"0%@",@(minutes)];
    NSString *hoursStr = hours > 0 ? [NSString stringWithFormat:@"%@:",@(hours)] : @"";
    NSString *title = [NSString stringWithFormat:@"%@%@%@",hoursStr,minutesStr,secondStr];
    return title;
}

- (NSString*)urlencode{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char*)source);
    for(int i =0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if(thisChar ==' '){
            [output appendString:@"+"];
        }else if(thisChar =='.'|| thisChar =='-'|| thisChar =='_'|| thisChar =='~'|| (thisChar >='a'&& thisChar <='z') ||(thisChar >='A'&& thisChar <='Z') || (thisChar >='0'&& thisChar <='9')) {
            [output appendFormat:@"%c", thisChar];
        }else{
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end
