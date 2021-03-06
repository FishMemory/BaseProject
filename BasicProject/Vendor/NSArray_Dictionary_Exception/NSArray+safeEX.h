//
//  NSArrayEX.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSArray (safeEX)

- (id)safeObjectAtIndex:(NSUInteger)index;

//- (NSString*)urlEncodedString;

- (void)safeAddObject:(id)anObject;

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

@end


/************************************************分割线*****************************************/
@interface NSArray (HYUtil)

/*!
 @method anyObject
 @abstract 获取数组里的一个对象，索引号小的优先返回
 @result 返回数组里的一个对象
 */
- (id)anyObject;

/*!
 @method isEmpty
 @abstract 是否没有对象，没有对象也是为YES；
 @result 返回BOOL
 */
- (BOOL)isEmptyEX;

/*!
 @method objectAtIndexCheck:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
 */
- (id)objectAtIndexCheck:(NSUInteger)index;

/*!
 @method objectAtIndexCheck:class:defaultValue:
 @abstract 获取指定index的对象并检查是否越界和NSNull如果是返回nil
 @param index 索引号
 @param aClass 检查类型
 @result 返回对象
 */
- (id)objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass;

/*!
 @method objectAtIndexCheck:class:defaultValue:
 @abstract 获取指定index的对象并检查是否越界和NSNull如果是返回nil,获取失败返回为指定的defaultValue
 @param index 索引号
 @param aClass 检查类型
 @param defaultValue 获取失败要返回的值
 @result 返回对象，获取失败为指定的defaultValue
 */
- (id)objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue;

/*!
 @method arrayAtIndex:
 @abstract 获取指定index的NSArray类型值
 @param index 索引号
 @result 返回NSArray，获取失败为nil
 */
- (NSArray *)arrayAtIndex:(NSUInteger)index;

/*!
 @method arrayAtIndex:defaultValue:
 @abstract 获取指定index的NSArray类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSArray，获取失败为指定的defaultValue
 */
- (NSArray *)arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue;

/*!
 @method mutableArrayAtIndex:
 @abstract 获取指定index的NSMutableArray类型值
 @param index 索引号
 @result 返回NSMutableArray，获取失败为nil
 */
- (NSMutableArray *)mutableArrayAtIndex:(NSUInteger)index;

/*!
 @method mutableArrayAtIndex:defaultValue:
 @abstract 获取指定index的NSMutableArray类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSMutableArray，获取失败为指定的defaultValue
 */
- (NSMutableArray *)mutableArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue;

/*!
 @method dictionaryAtIndex:
 @abstract 获取指定index的NSDictionary类型值
 @param index 索引号
 @result 返回NSDictionary，获取失败为nil
 */
- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index;

/*!
 @method dictionaryAtIndex:defaultValue:
 @abstract 获取指定index的NSDictionary类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSDictionary，获取失败为指定的defaultValue
 */
- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue;

/*!
 @method mutableDictionaryAtIndex:
 @abstract 获取指定index的NSMutableDictionary类型值
 @param index 索引号
 @result 返回NSMutableDictionary，获取失败为nil
 */
- (NSMutableDictionary *)mutableDictionaryAtIndex:(NSUInteger)index;

/*!
 @method mutableDictionaryAtIndex:defaultValue:
 @abstract 获取指定index的NSMutableDictionary类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSMutableDictionary，获取失败为指定的defaultValue
 */
- (NSMutableDictionary *)mutableDictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue;

/*!
 @method dataAtIndex:
 @abstract 获取指定index的NSData类型值
 @param index 索引号
 @result 返回NSData，获取失败为nil
 */
- (NSData *)dataAtIndex:(NSUInteger)index;

/*!
 @method dataAtIndex:defaultValue:
 @abstract 获取指定index的NSData类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSData，获取失败为指定的defaultValue
 */
- (NSData *)dataAtIndex:(NSUInteger)index defaultValue:(NSData *)defaultValue;

/*!
 @method stringAtIndex:
 @abstract 获取指定index的NSString类型值
 @param index 索引号
 @result 返回NSString，获取失败为nil
 */
- (NSString *)stringAtIndex:(NSUInteger)index;

/*!
 @method stringAtIndexToString:
 @abstract 获取指定index的NSString类型值
 @param index 索引号
 @result 返回字NSString，获取失败为@""
 */
- (NSString *)stringAtIndexToString:(NSUInteger)index;

/*!
 @method stringAtIndex:defaultValue:
 @abstract 获取指定index的NSString类型值,获取失败返回为指定的defaultValue
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSString，获取失败为指定的defaultValue
 */
- (NSString *)stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue;

/*!
 @method numberAtIndex:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @result 返回NSNumber，获取失败为nil
 */
//- (NSNumber *)numberAtIndex:(NSUInteger)index;

/*!
 @method numberAtIndex:defaultValue:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSNumber，获取失败为指定的defaultValue
 */
//- (NSNumber *)numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue;

/*!
 @method charAtIndex:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @result 返回char
 */
- (char)charAtIndex:(NSUInteger)index;

/*!
 @method unsignedCharAtIndex:
 @abstract 获取指定index的unsigned char类型值
 @param index 索引号
 @result 返回unsigned char
 */
- (unsigned char)unsignedCharAtIndex:(NSUInteger)index;

/*!
 @method shortAtIndex:
 @abstract 获取指定index的short类型值
 @param index 索引号
 @result 返回short，获取失败为0
 */
- (short)shortAtIndex:(NSUInteger)index;

/*!
 @method shortAtIndex:defaultValue:
 @abstract 获取指定index的short类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回short，获取失败为指定的defaultValue
 */
- (short)shortAtIndex:(NSUInteger)index defaultValue:(short)defaultValue;

/*!
 @method unsignedShortAtIndex:
 @abstract 获取指定index的unsigned short类型值
 @param index 索引号
 @result 返回unsigned short，获取失败为0
 */
- (unsigned short)unsignedShortAtIndex:(NSUInteger)index;

/*!
 @method unsignedShortAtIndex:defaultValue:
 @abstract 获取指定index的unsigned short类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned short，获取失败为指定的defaultValue
 */
- (unsigned short)unsignedShortAtIndex:(NSUInteger)index defaultValue:(unsigned short)defaultValue;

/*!
 @method intAtIndex:
 @abstract 获取指定index的int类型值
 @param index 索引号
 @result 返回int，获取失败为0
 */
- (int)intAtIndex:(NSUInteger)index;

/*!
 @method intAtIndex:defaultValue:
 @abstract 获取指定index的int类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回int，获取失败为指定的defaultValue
 */
- (int)intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue;

/*!
 @method unsignedIntAtIndex:
 @abstract 获取指定index的unsigned int类型值
 @param index 索引号
 @result 返回unsigned int，获取失败为0
 */
- (unsigned int)unsignedIntAtIndex:(NSUInteger)index;

/*!
 @method unsignedIntAtIndex:defaultValue:
 @abstract 获取指定index的unsigned int类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned int，获取失败为指定的defaultValue
 */
- (unsigned int)unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue;

/*!
 @method longAtIndex:
 @abstract 获取指定index的long类型值
 @param index 索引号
 @result 返回long，获取失败为0
 */
- (long)longAtIndex:(NSUInteger)index;

/*!
 @method longAtIndex:defaultValue:
 @abstract 获取指定index的long类型值
 @param defaultValue 获取失败要返回的值
 @result 返回long，获取失败为指定的defaultValue
 */
- (long)longAtIndex:(NSUInteger)index defaultValue:(long)defaultValue;

/*!
 @method unsignedLongAtIndex:
 @abstract 获取指定index的unsigned long类型值
 @param index 索引号
 @result 返回unsigned long，获取失败为0
 */
- (unsigned long)unsignedLongAtIndex:(NSUInteger)index;

/*!
 @method unsignedLongAtIndex:defaultValue:
 @abstract 获取指定index的unsigned long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned long，获取失败为指定的defaultValue
 */
- (unsigned long)unsignedLongAtIndex:(NSUInteger)index defaultValue:(unsigned long)defaultValue;

/*!
 @method longLongAtIndex:
 @abstract 获取指定index的long long类型值
 @param index 索引号
 @result 返回long long，获取失败为0
 */
- (long long)longLongAtIndex:(NSUInteger)index;

/*!
 @method longLongAtIndex:defaultValue:
 @abstract 获取指定index的long long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回long long，获取失败为指定的defaultValue
 */
- (long long)longLongAtIndex:(NSUInteger)index defaultValue:(long long)defaultValue;

/*!
 @method unsignedLongLongAtIndex:
 @abstract 获取指定index的unsigned long long类型值
 @param index 索引号
 @result 返回unsigned long long，获取失败为0
 */
- (unsigned long long)unsignedLongLongAtIndex:(NSUInteger)index;

/*!
 @method unsignedLongLongAtIndex:defaultValue:
 @abstract 获取指定index的unsigned long long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned long long，获取失败为指定的defaultValue
 */
- (unsigned long long)unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long)defaultValue;

/*!
 @method floatAtIndex:
 @abstract 获取指定index的float类型值
 @param index 索引号
 @result 返回float，获取失败为0.0
 */
- (float)floatAtIndex:(NSUInteger)index;

/*!
 @method floatAtIndex:defaultValue:
 @abstract 获取指定index的float类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回float，获取失败为指定的defaultValue
 */
- (float)floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue;

/*!
 @method doubleAtIndex:
 @abstract 获取指定index的double类型值
 @param index 索引号
 @result 返回double，获取失败为0.0
 */
- (double)doubleAtIndex:(NSUInteger)index;

/*!
 @method doubleAtIndex:defaultValue:
 @abstract 获取指定index的double类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回double，获取失败为指定的defaultValue
 */
- (double)doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue;

/*!
 @method boolAtIndex:
 @abstract 获取指定index的BOOL类型值
 @param index 索引号
 @result 返回BOOL，获取失败为NO
 */
- (BOOL)boolAtIndex:(NSUInteger)index;

/*!
 @method boolAtIndex:
 @abstract 获取指定index的BOOL类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回BOOL，获取失败为指定的defaultValue
 */
- (BOOL)boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue;

/*!
 @method integerAtIndex:
 @abstract 获取指定index的NSInteger类型值
 @param index 索引号
 @result 返回NSInteger，获取失败为0
 */
- (NSInteger)integerAtIndex:(NSUInteger)index;

/*!
 @method integerAtIndex:defaultValue:
 @abstract 获取指定index的NSInteger类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSInteger，获取失败为指定的defaultValue
 */
- (NSInteger)integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue;

/*!
 @method unsignedIntegerAtIndex:
 @abstract 获取指定index的NSUInteger类型值
 @param index 索引号
 @result 返回NSUInteger，获取失败为0
 */
- (NSUInteger)unsignedIntegerAtIndex:(NSUInteger)index;

/*!
 @method unsignedIntegerAtIndex:defaultValue:
 @abstract 获取指定index的NSUInteger类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSUInteger，获取失败为指定的defaultValue
 */
- (NSUInteger)unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue;

/*!
 @method pointAtIndex:
 @abstract 获取指定index的CGPoint类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGPointZero
 */
- (CGPoint)pointAtIndex:(NSUInteger)index;

/*!
 @method pointAtIndex:defaultValue:
 @abstract 获取指定index的CGPoint类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGPoint，获取失败为指定的defaultValue
 */
- (CGPoint)pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue;

/*!
 @method sizeAtIndex:
 @abstract 获取指定index的CGSize类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGSizeZero
 */
- (CGSize)sizeAtIndex:(NSUInteger)index;

/*!
 @method sizeAtIndex:defaultValue:
 @abstract 获取指定index的CGSize类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGSize，获取失败为指定的defaultValue
 */
- (CGSize)sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue;

/*!
 @method rectAtIndex:
 @abstract 获取指定index的CGRect类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGRectZero
 */
- (CGRect)rectAtIndex:(NSUInteger)index;

/*!
 @method rectAtIndex:
 @abstract 获取指定index的CGRect类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGRect，获取失败为指定的defaultValue
 */
- (CGRect)rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue;

@end

@interface NSMutableArray (HYUtil)

/*!
 @method addObjects:
 @abstract 把多个对象添加到数组里
 @param objects 要添加对象
 */
- (void)addObjects:(id)objects, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 @method addObjectCheck:
 @abstract 检查对象是不是为 nil ;不是则添加
 @param anObject 要添加对象
 */
- (void)addObjectCheck:(id)anObject;

/*!
 @method addChar:
 @abstract 添加char类型值，到数组里
 @param value 值
 */
- (void)addChar:(char)value;

/*!
 @method addUnsignedChar:
 @abstract 添加unsigned char类型值，到数组里
 @param value 值
 */
- (void)addUnsignedChar:(unsigned char)value;

/*!
 @method addShort:
 @abstract 添加short类型值，到数组里
 @param value 值
 */
- (void)addShort:(short)value;

/*!
 @method addUnsignedShort:
 @abstract 添加unsigned short类型值，到数组里
 @param value 值
 */
- (void)addUnsignedShort:(unsigned short)value;

/*!
 @method addInt:
 @abstract 添加int类型值，到数组里
 @param value 值
 */
- (void)addInt:(int)value;

/*!
 @method addUnsignedInt:
 @abstract 添加unsigned int类型值，到数组里
 @param value 值
 */
- (void)addUnsignedInt:(unsigned int)value;

/*!
 @method addLong:
 @abstract 添加long类型值，到数组里
 @param value 值
 */
- (void)addLong:(long)value;

/*!
 @method addUnsignedLong:
 @abstract 添加unsigned long类型值，到数组里
 @param value 值
 */
- (void)addUnsignedLong:(unsigned long)value;

/*!
 @method addLongLong:
 @abstract 添加long long类型值，到数组里
 @param value 值
 */
- (void)addLongLong:(long long)value;

/*!
 @method addUnsignedLongLong:
 @abstract 添加unsigned long long类型值，到数组里
 @param value 值
 */
- (void)addUnsignedLongLong:(unsigned long long)value;

/*!
 @method addFloat:
 @abstract 添加float类型值，到数组里
 @param value 值
 */
- (void)addFloat:(float)value;

/*!
 @method addDouble:
 @abstract 添加double类型值，到数组里
 @param value 值
 */
- (void)addDouble:(double)value;

/*!
 @method addBool:
 @abstract 添加BOOL类型值，到数组里
 @param value 值
 */
- (void)addBool:(BOOL)value;

/*!
 @method addInteger:
 @abstract 添加NSInteger类型值，到数组里
 @param value 值
 */
- (void)addInteger:(NSInteger)value;

/*!
 @method addUnsignedInteger:
 @abstract 添加NSUInteger类型值，到数组里
 @param value 值
 */
- (void)addUnsignedInteger:(NSUInteger)value;

/*!
 @method addPointValue:
 @abstract 添加CGPoint类型值，到数组里
 @param value 值
 */
- (void)addPointValue:(CGPoint)value;

/*!
 @method addSizeValue:
 @abstract 添加CGSize类型值，到数组里
 @param value 值
 */
- (void)addSizeValue:(CGSize)value;

/*!
 @method addRectValue:
 @abstract 添加CGRect类型值，到数组里
 @param value 值
 */
- (void)addRectValue:(CGRect)value;

/*!
 @method insertObjectCheck:atIndex:
 @abstract 检查插入指定索引号的对象是不是为nil和越界，不是则插入
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertObjectCheck:(id)anObject atIndex:(NSUInteger)index;

/*!
 @method insertChar:atIndex:
 @abstract 插入指定索引号的char类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertChar:(char)value atIndex:(NSUInteger)index;

/*!
 @method insertUnsignedChar:atIndex:
 @abstract 插入指定索引号的unsigned char类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertUnsignedChar:(unsigned char)value atIndex:(NSUInteger)index;

/*!
 @method insertShort:atIndex:
 @abstract 插入指定索引号的short类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertShort:(short)value atIndex:(NSUInteger)index;

/*!
 @method insertUnsignedShort:atIndex:
 @abstract 插入指定索引号的unsigned short类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertUnsignedShort:(unsigned short)value atIndex:(NSUInteger)index;

/*!
 @method insertInt:atIndex:
 @abstract 插入指定索引号的int类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertInt:(int)value atIndex:(NSUInteger)index;

/*!
 @method insertUnsignedInt:atIndex:
 @abstract 插入指定索引号的unsigned int类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertUnsignedInt:(unsigned int)value atIndex:(NSUInteger)index;

/*!
 @method insertLong:atIndex:
 @abstract 插入指定索引号的long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertLong:(long)value atIndex:(NSUInteger)index;

/*!
 @method insertUnsignedLong:atIndex:
 @abstract 插入指定索引号的unsigned long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertUnsignedLong:(unsigned long)value atIndex:(NSUInteger)index;

/*!
 @method insertLongLong:atIndex:
 @abstract 插入指定索引号的long long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertLongLong:(long long)value atIndex:(NSUInteger)index;

/*!
 @method insertUnsignedLongLong:atIndex:
 @abstract 插入指定索引号的unsigned long long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertUnsignedLongLong:(unsigned long long)value atIndex:(NSUInteger)index;

/*!
 @method insertFloat:atIndex:
 @abstract 插入指定索引号的float类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertFloat:(float)value atIndex:(NSUInteger)index;

/*!
 @method insertDouble:atIndex:
 @abstract 插入指定索引号的double类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertDouble:(double)value atIndex:(NSUInteger)index;

/*!
 @method insertBool:atIndex:
 @abstract 插入指定索引号的BOOL类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertBool:(BOOL)value atIndex:(NSUInteger)index;

/*!
 @method insertInteger:atIndex:
 @abstract 插入指定索引号的NSInteger类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertInteger:(NSInteger)value atIndex:(NSUInteger)index;

/*!
 @method insertUnsignedInteger:atIndex:
 @abstract 插入指定索引号的NSUInteger类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertUnsignedInteger:(NSUInteger)value atIndex:(NSUInteger)index;

/*!
 @method insertPointValue:atIndex:
 @abstract 插入指定索引号的CGPoint类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertPointValue:(CGPoint)value atIndex:(NSUInteger)index;

/*!
 @method insertSizeValue:atIndex:
 @abstract 插入指定索引号的CGSize类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertSizeValue:(CGSize)value atIndex:(NSUInteger)index;

/*!
 @method insertRectValue:atIndex:
 @abstract 插入指定索引号的CGRect类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)insertRectValue:(CGRect)value atIndex:(NSUInteger)index;

/*!
 @method replaceObjectCheckAtIndex:withChar:
 @abstract 检查指定索引号,的对象是不是为nil和越界，不是则替换
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceObjectCheckAtIndex:(NSUInteger)index withObject:(id)anObject;

/*!
 @method replaceCharAtIndex:withChar:
 @abstract 指定索引号,替换char类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceCharAtIndex:(NSUInteger)index withChar:(char)value;

/*!
 @method replaceUnsignedCharAtIndex:withUnsignedChar:
 @abstract 指定索引号,替换unsigned char类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceUnsignedCharAtIndex:(NSUInteger)index withUnsignedChar:(unsigned char)value;

/*!
 @method replaceShortAtIndex:withShort:
 @abstract 指定索引号,替换short类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceShortAtIndex:(NSUInteger)index withShort:(short)value;

/*!
 @method replaceUnsignedShortAtIndex:withUnsignedShort:
 @abstract 指定索引号,替换unsigned short类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceUnsignedShortAtIndex:(NSUInteger)index withUnsignedShort:(unsigned short)value;

/*!
 @method replaceIntAtIndex:withInt:
 @abstract 指定索引号,替换int类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceIntAtIndex:(NSUInteger)index withInt:(int)value;

/*!
 @method replaceUnsignedIntAtIndex:withUnsignedInt:
 @abstract 指定索引号,替换unsigned int类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceUnsignedIntAtIndex:(NSUInteger)index withUnsignedInt:(unsigned int)value;

/*!
 @method replaceLongAtIndex:withLong:
 @abstract 指定索引号,替换long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceLongAtIndex:(NSUInteger)index withLong:(long)value;

/*!
 @method replaceUnsignedLongAtIndex:withUnsignedLong:
 @abstract 指定索引号,替换unsigned long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceUnsignedLongAtIndex:(NSUInteger)index withUnsignedLong:(unsigned long)value;

/*!
 @method replaceLongLongAtIndex:withLongLong:
 @abstract 指定索引号,替换long long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceLongLongAtIndex:(NSUInteger)index withLongLong:(long long)value;

/*!
 @method replaceUnsignedLongLongAtIndex:withUnsignedLongLong:
 @abstract 指定索引号,替换unsigned long long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceUnsignedLongLongAtIndex:(NSUInteger)index withUnsignedLongLong:(unsigned long long)value;

/*!
 @method replaceFloatAtIndex:withFloat:
 @abstract 指定索引号,替换float类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceFloatAtIndex:(NSUInteger)index withFloat:(float)value;

/*!
 @method replaceDoubleAtIndex:withDouble:
 @abstract 指定索引号,替换double类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceDoubleAtIndex:(NSUInteger)index withDouble:(double)value;

/*!
 @method replaceBoolAtIndex:withBool:
 @abstract 指定索引号,替换BOOL类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceBoolAtIndex:(NSUInteger)index withBool:(BOOL)value;

/*!
 @method replaceIntegerAtIndex:withInteger:
 @abstract 指定索引号,替换NSInteger类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceIntegerAtIndex:(NSUInteger)index withInteger:(NSInteger)value;

/*!
 @method replaceUnsignedIntegerAtIndex:withUnsignedInteger:
 @abstract 指定索引号,替换NSUInteger类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceUnsignedIntegerAtIndex:(NSUInteger)index withUnsignedInteger:(NSUInteger)value;

/*!
 @method replacePointValueAtIndex:withPointValue:
 @abstract 指定索引号,替换CGPoint类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replacePointValueAtIndex:(NSUInteger)index withPointValue:(CGPoint)value;

/*!
 @method replaceSizeValueAtIndex:withSizeValue:
 @abstract 指定索引号,替换CGSize类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceSizeValueAtIndex:(NSUInteger)index withSizeValue:(CGSize)value;

/*!
 @method replaceRectValueAtIndex:withRectValue:
 @abstract 指定索引号,替换CGRect类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)replaceRectValueAtIndex:(NSUInteger)index withRectValue:(CGRect)value;

@end

/************************************************分割线*****************************************/

@interface NSArray(NSDictionaryEXMethodsProtect)

- (id)safeValueForKey:(NSString *)key;

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;

- (void)safeSetValue:(id)value forKey:(NSString *)key;

+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data;

- (id)objectForKeyCheck:(id)aKey;

- (id)objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass;

- (id)objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue;

- (NSArray *)arrayForKey:(id)key;

- (NSArray *)arrayForKey:(id)key defaultValue:(NSArray *)defaultValue;

- (NSMutableArray *)mutableArrayForKey:(id)key;

- (NSMutableArray *)mutableArrayForKey:(id)key defaultValue:(NSArray *)defaultValue;

- (NSDictionary *)dictionaryForKey:(id)key;

- (NSDictionary *)dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue;

- (NSMutableDictionary *)mutableDictionaryForKey:(id)key;

- (NSMutableDictionary *)mutableDictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue;

- (NSData *)dataForKey:(id)key;

- (NSData *)dataForKey:(id)key defaultValue:(NSData *)defaultValue;

- (NSString *)stringForKey:(id)key;

- (NSString *)stringForKeyToString:(id)key;

- (NSString *)stringForKey:(id)key defaultValue:(NSString *)defaultValue;

- (NSNumber *)numberForKey:(id)key;

//- (NSNumber *)numberForKey:(id)key defaultValue:(NSNumber *)defaultValue;

- (char)charForKey:(id)key;

- (unsigned char)unsignedCharForKey:(id)key;

- (short)shortForKey:(id)key;

- (short)shortForKey:(id)key defaultValue:(short)defaultValue;

- (unsigned short)unsignedShortForKey:(id)key;

- (unsigned short)unsignedShortForKey:(id)key defaultValue:(unsigned short)defaultValue;

- (int)intForKey:(id)key;

- (int)intForKey:(id)key defaultValue:(int)defaultValue;

- (unsigned int)unsignedIntForKey:(id)key;

- (unsigned int)unsignedIntForKey:(id)key defaultValue:(unsigned int)defaultValue;

- (long)longForKey:(id)key;

- (long)longForKey:(id)key defaultValue:(long)defaultValue;

- (unsigned long)unsignedLongForKey:(id)key;

- (unsigned long)unsignedLongForKey:(id)key defaultValue:(unsigned long)defaultValue;

- (long long)longLongForKey:(id)key;

- (long long)longLongForKey:(id)key defaultValue:(long long)defaultValue;

- (unsigned long long)unsignedLongLongForKey:(id)key;

- (unsigned long long)unsignedLongLongForKey:(id)key defaultValue:(unsigned long long)defaultValue;

- (float)floatForKey:(id)key;

- (float)floatForKey:(id)key defaultValue:(float)defaultValue;

- (double)doubleForKey:(id)key;

- (double)doubleForKey:(id)key defaultValue:(double)defaultValue;

- (BOOL)boolForKey:(id)key;

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue;

- (NSInteger)integerForKey:(id)key;

- (NSInteger)integerForKey:(id)key defaultValue:(NSInteger)defaultValue;

- (NSUInteger)unsignedIntegerForKey:(id)key;

- (NSUInteger)unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue;

- (CGPoint)pointForKey:(id)key;

- (CGPoint)pointForKey:(id)key defaultValue:(CGPoint)defaultValue;

- (CGSize)sizeForKey:(id)key;

- (CGSize)sizeForKey:(id)key defaultValue:(CGSize)defaultValue;

- (CGRect)rectForKey:(id)key;

- (CGRect)rectForKey:(id)key defaultValue:(CGRect)defaultValue;

- (void)setObjectCheck:(id)anObject forKey:(id <NSCopying>)aKey;

- (void)removeObjectForKeyCheck:(id)aKey;

- (void)setChar:(char)value forKey:(id<NSCopying>)key;

- (void)setUnsignedChar:(unsigned char)value forKey:(id<NSCopying>)key;

- (void)setShort:(short)value forKey:(id<NSCopying>)key;

- (void)setUnsignedShort:(unsigned short)value forKey:(id<NSCopying>)key;

- (void)setInt:(int)value forKey:(id<NSCopying>)key;

- (void)setUnsignedInt:(unsigned int)value forKey:(id<NSCopying>)key;

- (void)setLong:(long)value forKey:(id<NSCopying>)key;

- (void)setUnsignedLong:(unsigned long)value forKey:(id<NSCopying>)key;

- (void)setLongLong:(long long)value forKey:(id<NSCopying>)key;

- (void)setUnsignedLongLong:(unsigned long long)value forKey:(id<NSCopying>)key;

- (void)setFloat:(float)value forKey:(id<NSCopying>)key;

- (void)setDouble:(double)value forKey:(id<NSCopying>)key;

- (void)setBool:(BOOL)value forKey:(id<NSCopying>)key;

- (void)setInteger:(NSInteger)value forKey:(id<NSCopying>)key;

- (void)setUnsignedInteger:(NSUInteger)value forKey:(id<NSCopying>)key;

- (void)setPointValue:(CGPoint)value forKey:(id<NSCopying>)key;

- (void)setSizeValue:(CGSize)value forKey:(id<NSCopying>)key;

- (void)setRectValue:(CGRect)value forKey:(id<NSCopying>)key;


/**
 *  判断数组为empty或nil
 *
 *  @param aArray 源数组
 *
 *  @return YES/NO
 */
+ (BOOL)checkArrayIsEmptyOrNil:(NSArray *)aArray;


-(NSMutableArray *)setDicWithkey:(id)key dataDic:(NSMutableDictionary *)dataDic;
@end
