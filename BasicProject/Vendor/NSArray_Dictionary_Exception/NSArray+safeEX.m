//
//  NSArrayEX.m
//

#import "NSArray+safeEX.h"
//#import "NSStringEX.h"
@implementation NSArray (safeEX)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if(self && self.count > 0 && index < self.count)
    {
        id obj = [self objectAtIndex:index];
        if ([obj isKindOfClass:[NSNull class]])
        {
            obj = nil;
        }
        return obj;
    }
    return nil;
}

//- (NSString*)urlEncodedString
//{
//    // 91手机助手dylib的JSONString方法冲突
//#ifdef PLUGIN_FOR_TAOBAO
//    NSString *jsonString = [self tbJSONString];
//#else
//    NSString *jsonString = [self JSONString];
//#endif
//    return [jsonString urlEncodedString];
//}


- (void)safeAddObject:(id)anObject
{
    if ([self isKindOfClass:[NSMutableArray class]] && nil != anObject) {
        [(NSMutableArray *)self addObject:anObject];
    }
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if ([self isKindOfClass:[NSMutableArray class]] && nil != anObject && index <= self.count) {
        [(NSMutableArray *)self insertObject:anObject atIndex:index];
    }
}

@end

/************************************************分割线*****************************************/

@implementation NSArray (HYUtil)

- (id)anyObject
{
    return [self count] > 0 ? [self objectAtIndexCheck:0] : nil;
}

- (BOOL)isEmptyEX
{
    return ([self count] == 0);
}

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (id)objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass
{
    return [self objectAtIndexCheck:index class:aClass defaultValue:nil];
}

- (id)objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if (![value isKindOfClass:aClass]) {
        return defaultValue;
    }
    return value;
}

- (NSArray *)arrayAtIndex:(NSUInteger)index
{
    return [self arrayAtIndex:index defaultValue:nil];
}

- (NSArray *)arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return [self objectAtIndexCheck:index class:[NSArray class] defaultValue:defaultValue];
}

- (NSMutableArray *)mutableArrayAtIndex:(NSUInteger)index
{
    return [self mutableArrayAtIndex:index defaultValue:nil];
}

- (NSMutableArray *)mutableArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return [self objectAtIndexCheck:index class:[NSMutableArray class] defaultValue:defaultValue];
}

- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index
{
    return [self dictionaryAtIndex:index defaultValue:nil];
}

- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue
{
    return [self objectAtIndexCheck:index class:[NSDictionary class] defaultValue:defaultValue];
}

- (NSMutableDictionary *)mutableDictionaryAtIndex:(NSUInteger)index
{
    return [self mutableDictionaryAtIndex:index defaultValue:nil];
}

- (NSMutableDictionary *)mutableDictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue
{
    return [self objectAtIndexCheck:index class:[NSMutableDictionary class] defaultValue:defaultValue];
}

- (NSData *)dataAtIndex:(NSUInteger)index
{
    return [self dataAtIndex:index defaultValue:nil];
}

- (NSData *)dataAtIndex:(NSUInteger)index defaultValue:(NSData *)defaultValue
{
    return [self objectAtIndexCheck:index class:[NSData class] defaultValue:defaultValue];
}

- (NSString *)stringAtIndex:(NSUInteger)index
{
    return [self stringAtIndexToString:index];
}

- (NSString *)stringAtIndexToString:(NSUInteger)index
{
    return [self stringAtIndex:index defaultValue:@""];
}

- (NSString *)stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    if (![value isKindOfClass:[NSString class]]) {
        return defaultValue;
    }
    return value;
}

//- (NSNumber *)numberAtIndex:(NSUInteger)index
//{
//    return [self numberAtIndex:index defaultValue:nil];
//}

//- (NSNumber *)numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue
//{
//    id value = [self objectAtIndexCheck:index];
//    if ([value isKindOfClass:[NSString class]]){
//       return [value numberValue];
//    }
//    
//    if (![value isKindOfClass:[NSNumber class]]) {
//        return defaultValue;
//    }
//    
//    return value;
//}

- (char)charAtIndex:(NSUInteger)index
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    else {
        return 0x0;
    }
}

- (unsigned char)unsignedCharAtIndex:(NSUInteger)index
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value unsignedCharValue];
    }
    else {
        return 0x0;
    }
}

- (short)shortAtIndex:(NSUInteger)index
{
    return [self shortAtIndex:index defaultValue:0];
}

- (short)shortAtIndex:(NSUInteger)index defaultValue:(short)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value shortValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned short)unsignedShortAtIndex:(NSUInteger)index
{
    return [self unsignedShortAtIndex:index defaultValue:0];
}

- (unsigned short)unsignedShortAtIndex:(NSUInteger)index defaultValue:(unsigned short)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value unsignedShortValue];
    }
    else {
        return defaultValue;
    }
}

- (int)intAtIndex:(NSUInteger)index
{
    return [self intAtIndex:index defaultValue:0];
}

- (int)intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned int)unsignedIntAtIndex:(NSUInteger)index
{
    return [self unsignedIntAtIndex:index defaultValue:0];
}

- (unsigned int)unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value unsignedIntValue];
    }
    else {
        return defaultValue;
    }
}

- (long)longAtIndex:(NSUInteger)index
{
    return [self longAtIndex:index defaultValue:0];
}

- (long)longAtIndex:(NSUInteger)index defaultValue:(long)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned long)unsignedLongAtIndex:(NSUInteger)index
{
    return [self unsignedLongAtIndex:index defaultValue:0];
}

- (unsigned long)unsignedLongAtIndex:(NSUInteger)index defaultValue:(unsigned long)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value unsignedLongValue];
    }
    else {
        return defaultValue;
    }
}

- (long long)longLongAtIndex:(NSUInteger)index
{
    return [self longLongAtIndex:index defaultValue:0];
}

- (long long)longLongAtIndex:(NSUInteger)index defaultValue:(long long)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned long long)unsignedLongLongAtIndex:(NSUInteger)index
{
    return [self unsignedLongLongAtIndex:index defaultValue:0];
}

- (unsigned long long)unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value unsignedLongLongValue];
    }
    else {
        return defaultValue;
    }
}

- (float)floatAtIndex:(NSUInteger)index
{
    return [self floatAtIndex:index defaultValue:0.0];
}

- (float)floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        float result = [value floatValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (double)doubleAtIndex:(NSUInteger)index
{
    return [self doubleAtIndex:index defaultValue:0.0];
}

- (double)doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        double result = [value doubleValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (BOOL)boolAtIndex:(NSUInteger)index
{
    return [self boolAtIndex:index defaultValue:NO];
}

- (BOOL)boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    else {
        return defaultValue;
    }
}

- (NSInteger)integerAtIndex:(NSUInteger)index
{
    return [self integerAtIndex:index defaultValue:0];
}

- (NSInteger)integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    else {
        return defaultValue;
    }
}

- (NSUInteger)unsignedIntegerAtIndex:(NSUInteger)index
{
    return [self unsignedIntegerAtIndex:index defaultValue:0];
}

- (NSUInteger)unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value unsignedIntegerValue];
    }
    else {
        return defaultValue;
    }
}

- (CGPoint)pointAtIndex:(NSUInteger)index
{
    return [self pointAtIndex:index defaultValue:CGPointZero];
}

- (CGPoint)pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSString class]] && ![value isEmptyEX])
        return CGPointFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGPointValue];
    else
        return defaultValue;
}

- (CGSize)sizeAtIndex:(NSUInteger)index
{
    return [self sizeAtIndex:index defaultValue:CGSizeZero];
}

- (CGSize)sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSString class]] && ![value isEmptyEX])
        return CGSizeFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGSizeValue];
    else
        return defaultValue;
}

- (CGRect)rectAtIndex:(NSUInteger)index
{
    return [self rectAtIndex:index defaultValue:CGRectZero];
}

- (CGRect)rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue
{
    id value = [self objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSString class]] && ![value isEmptyEX])
        return CGRectFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGRectValue];
    else
        return defaultValue;
}

@end

@implementation NSMutableArray (HYUtil)

- (void)addObjects:(id)objects, ...
{
    if (objects == nil)
        return;
    
    [self addObjectCheck:objects];
    
    id next;
    va_list list;
    
    va_start(list, objects);
    while ((next = va_arg(list, id)) != nil)
    {
        [self addObjectCheck:next];
    }
    va_end(list);
}

- (void)addObjectCheck:(id)anObject
{
    if (anObject == nil) {
        NSLog(@"NSArray addObject: anObject 为 nil");
        return;
    }
    [self addObject:anObject];
}

- (void)addChar:(char)value
{
    [self addObjectCheck:[NSNumber numberWithChar:value]];
}

- (void)addUnsignedChar:(unsigned char)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedChar:value]];
}

- (void)addShort:(short)value
{
    [self addObjectCheck:[NSNumber numberWithShort:value]];
}

- (void)addUnsignedShort:(unsigned short)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedShort:value]];
}

- (void)addInt:(int)value
{
    [self addObjectCheck:[NSNumber numberWithInt:value]];
}

- (void)addUnsignedInt:(unsigned int)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedInt:value]];
}

- (void)addLong:(long)value
{
    [self addObjectCheck:[NSNumber numberWithLong:value]];
}

- (void)addUnsignedLong:(unsigned long)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedLong:value]];
}

- (void)addLongLong:(long long)value
{
    [self addObjectCheck:[NSNumber numberWithLongLong:value]];
}

- (void)addUnsignedLongLong:(unsigned long long)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedLongLong:value]];
}

- (void)addFloat:(float)value
{
    [self addObjectCheck:[NSNumber numberWithFloat:value]];
}

- (void)addDouble:(double)value
{
    [self addObjectCheck:[NSNumber numberWithDouble:value]];
}

- (void)addBool:(BOOL)value
{
    [self addObjectCheck:[NSNumber numberWithBool:value]];
}

- (void)addInteger:(NSInteger)value
{
    [self addObjectCheck:[NSNumber numberWithInteger:value]];
}

- (void)addUnsignedInteger:(NSUInteger)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedInteger:value]];
}

- (void)addPointValue:(CGPoint)value
{
    [self addObjectCheck:[NSValue valueWithCGPoint:value]];
}

- (void)addSizeValue:(CGSize)value
{
    [self addObjectCheck:[NSValue valueWithCGSize:value]];
}

- (void)addRectValue:(CGRect)value
{
    [self addObjectCheck:[NSValue valueWithCGRect:value]];
}

- (void)insertObjectCheck:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil) {
        NSLog(@"insertObjectCheck:atIndex: anObject 为 nil");
        return;
    }
    if (index > [self count]) {
        NSLog(@"insertObjectCheck:atIndex: index 越界");
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)insertChar:(char)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithChar:value] atIndex:index];
}

- (void)insertUnsignedChar:(unsigned char)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithUnsignedChar:value] atIndex:index];
}

- (void)insertShort:(short)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithShort:value] atIndex:index];
}

- (void)insertUnsignedShort:(unsigned short)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithUnsignedShort:value] atIndex:index];
}

- (void)insertInt:(int)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithInt:value] atIndex:index];
}

- (void)insertUnsignedInt:(unsigned int)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithUnsignedInt:value] atIndex:index];
}

- (void)insertLong:(long)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithLong:value] atIndex:index];
}

- (void)insertUnsignedLong:(unsigned long)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithUnsignedLong:value] atIndex:index];
}

- (void)insertLongLong:(long long)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithLongLong:value] atIndex:index];
}

- (void)insertUnsignedLongLong:(unsigned long long)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithUnsignedLongLong:value] atIndex:index];
}

- (void)insertFloat:(float)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithFloat:value] atIndex:index];
}

- (void)insertDouble:(double)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithDouble:value] atIndex:index];
}

- (void)insertBool:(BOOL)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithBool:value] atIndex:index];
}

- (void)insertInteger:(NSInteger)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithInteger:value] atIndex:index];
}

- (void)insertUnsignedInteger:(NSUInteger)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSNumber numberWithUnsignedInteger:value] atIndex:index];
}

- (void)insertPointValue:(CGPoint)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSValue valueWithCGPoint:value] atIndex:index];
}

- (void)insertSizeValue:(CGSize)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSValue valueWithCGSize:value] atIndex:index];
}

- (void)insertRectValue:(CGRect)value atIndex:(NSUInteger)index
{
    [self insertObjectCheck:[NSValue valueWithCGRect:value] atIndex:index];
}

- (void)replaceObjectCheckAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject == nil) {
        NSLog(@"replaceObjectCheckAtIndex:withObject: anObject 为 nil");
        return;
    }
    
    if (index >= [self count]) {
        NSLog(@"replaceObjectCheckAtIndex:withObject: index 越界");
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)replaceCharAtIndex:(NSUInteger)index withChar:(char)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithChar:value]];
}

- (void)replaceUnsignedCharAtIndex:(NSUInteger)index withUnsignedChar:(unsigned char)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedChar:value]];
}

- (void)replaceShortAtIndex:(NSUInteger)index withShort:(short)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithShort:value]];
}

- (void)replaceUnsignedShortAtIndex:(NSUInteger)index withUnsignedShort:(unsigned short)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedShort:value]];
}

- (void)replaceIntAtIndex:(NSUInteger)index withInt:(int)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithInt:value]];
}

- (void)replaceUnsignedIntAtIndex:(NSUInteger)index withUnsignedInt:(unsigned int)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedInt:value]];
}

- (void)replaceLongAtIndex:(NSUInteger)index withLong:(long)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithLong:value]];
}

- (void)replaceUnsignedLongAtIndex:(NSUInteger)index withUnsignedLong:(unsigned long)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedLong:value]];
}

- (void)replaceLongLongAtIndex:(NSUInteger)index withLongLong:(long long)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithLongLong:value]];
}

- (void)replaceUnsignedLongLongAtIndex:(NSUInteger)index withUnsignedLongLong:(unsigned long long)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedLongLong:value]];
}

- (void)replaceFloatAtIndex:(NSUInteger)index withFloat:(float)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithFloat:value]];
}

- (void)replaceDoubleAtIndex:(NSUInteger)index withDouble:(double)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithDouble:value]];
}

- (void)replaceBoolAtIndex:(NSUInteger)index withBool:(BOOL)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithBool:value]];
}

- (void)replaceIntegerAtIndex:(NSUInteger)index withInteger:(NSInteger)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithInteger:value]];
}

- (void)replaceUnsignedIntegerAtIndex:(NSUInteger)index withUnsignedInteger:(NSUInteger)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedInteger:value]];
}

- (void)replacePointValueAtIndex:(NSUInteger)index withPointValue:(CGPoint)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGPoint:value]];
}

- (void)replaceSizeValueAtIndex:(NSUInteger)index withSizeValue:(CGSize)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGSize:value]];
}

- (void)replaceRectValueAtIndex:(NSUInteger)index withRectValue:(CGRect)value
{
    [self replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGRect:value]];
}


@end

@implementation NSArray(NSDictionaryEXMethodsProtect)

- (id)safeValueForKey:(NSString *)key
{
    return nil;
}

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    // 兼容类型错误
}

- (void)safeSetValue:(id)value forKey:(NSString *)key
{
    // 兼容类型错误
}

+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data
{
    return nil;
}

- (id)objectForKeyCheck:(id)aKey
{
    return nil;
}

- (id)objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass
{
    return nil;
}

- (id)objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue
{
    return nil;
}

- (NSArray *)arrayForKey:(id)key
{
    return nil;
}

- (NSArray *)arrayForKey:(id)key defaultValue:(NSArray *)defaultValue
{
    return nil;
}

- (NSMutableArray *)mutableArrayForKey:(id)key
{
    return nil;
}

- (NSMutableArray *)mutableArrayForKey:(id)key defaultValue:(NSArray *)defaultValue
{
    return nil;
}

- (NSDictionary *)dictionaryForKey:(id)key
{
    return nil;
}

- (NSDictionary *)dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue
{
    return nil;
}

- (NSMutableDictionary *)mutableDictionaryForKey:(id)key
{
    return nil;
}

- (NSMutableDictionary *)mutableDictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue
{
    return nil;
}

- (NSData *)dataForKey:(id)key
{
    return nil;
}

- (NSData *)dataForKey:(id)key defaultValue:(NSData *)defaultValue
{
    return nil;
}

- (NSString *)stringForKey:(id)key
{
    return nil;
}

- (NSString *)stringForKeyToString:(id)key
{
    return nil;
}

- (NSString *)stringForKey:(id)key defaultValue:(NSString *)defaultValue
{
    return nil;
}

- (NSNumber *)numberForKey:(id)key
{
    return nil;
}

- (NSNumber *)numberForKey:(id)key defaultValue:(NSNumber *)defaultValue
{
    return nil;
}

- (char)charForKey:(id)key
{
    return 0x0;
}

- (unsigned char)unsignedCharForKey:(id)key
{
    return 0x0;
}

- (short)shortForKey:(id)key
{
    return 0;
}

- (short)shortForKey:(id)key defaultValue:(short)defaultValue
{
    return 0;
}

- (unsigned short)unsignedShortForKey:(id)key
{
    return 0;
}

- (unsigned short)unsignedShortForKey:(id)key defaultValue:(unsigned short)defaultValue
{
    return 0;
}

- (int)intForKey:(id)key
{
    return 0;
}

- (int)intForKey:(id)key defaultValue:(int)defaultValue
{
    return 0;
}

- (unsigned int)unsignedIntForKey:(id)key
{
    return 0;
}

- (unsigned int)unsignedIntForKey:(id)key defaultValue:(unsigned int)defaultValue
{
    return 0;
}

- (long)longForKey:(id)key
{
    return 0;
}

- (long)longForKey:(id)key defaultValue:(long)defaultValue
{
    return 0;
}

- (unsigned long)unsignedLongForKey:(id)key
{
    return 0;
}

- (unsigned long)unsignedLongForKey:(id)key defaultValue:(unsigned long)defaultValue
{
    return 0;
}

- (long long)longLongForKey:(id)key
{
    return 0;
}

- (long long)longLongForKey:(id)key defaultValue:(long long)defaultValue
{
    return 0;
}

- (unsigned long long)unsignedLongLongForKey:(id)key
{
    return 0;
}

- (unsigned long long)unsignedLongLongForKey:(id)key defaultValue:(unsigned long long)defaultValue
{
    return 0;
}

- (float)floatForKey:(id)key
{
    return 0.0;
}

- (float)floatForKey:(id)key defaultValue:(float)defaultValue
{
    return 0.0;
}

- (double)doubleForKey:(id)key
{
    return 0.0;
}

- (double)doubleForKey:(id)key defaultValue:(double)defaultValue
{
    return 0.0;
}

- (BOOL)boolForKey:(id)key
{
    return NO;
}

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue
{
    return NO;
}

- (NSInteger)integerForKey:(id)key
{
    return 0;
}

- (NSInteger)integerForKey:(id)key defaultValue:(NSInteger)defaultValue
{
     return 0;
}

- (NSUInteger)unsignedIntegerForKey:(id)key
{
    return 0;
}

- (NSUInteger)unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue
{
    return 0;
}

- (CGPoint)pointForKey:(id)key
{
    return CGPointZero;
}

- (CGPoint)pointForKey:(id)key defaultValue:(CGPoint)defaultValue
{
    return CGPointZero;
}

- (CGSize)sizeForKey:(id)key
{
    return CGSizeZero;
}

- (CGSize)sizeForKey:(id)key defaultValue:(CGSize)defaultValue
{
    return CGSizeZero;
}

- (CGRect)rectForKey:(id)key
{
    return CGRectZero;
}

- (CGRect)rectForKey:(id)key defaultValue:(CGRect)defaultValue
{
    return CGRectZero;
}

- (void)setObjectCheck:(id)anObject forKey:(id <NSCopying>)aKey{  }

- (void)removeObjectForKeyCheck:(id)aKey{  }

- (void)setChar:(char)value forKey:(id<NSCopying>)key{  }

- (void)setUnsignedChar:(unsigned char)value forKey:(id<NSCopying>)key{  }

- (void)setShort:(short)value forKey:(id<NSCopying>)key{  }

- (void)setUnsignedShort:(unsigned short)value forKey:(id<NSCopying>)key{  }

- (void)setInt:(int)value forKey:(id<NSCopying>)key{  }

- (void)setUnsignedInt:(unsigned int)value forKey:(id<NSCopying>)key{  }

- (void)setLong:(long)value forKey:(id<NSCopying>)key{  }

- (void)setUnsignedLong:(unsigned long)value forKey:(id<NSCopying>)key{  }

- (void)setLongLong:(long long)value forKey:(id<NSCopying>)key{  }

- (void)setUnsignedLongLong:(unsigned long long)value forKey:(id<NSCopying>)key{  }

- (void)setFloat:(float)value forKey:(id<NSCopying>)key{  }

- (void)setDouble:(double)value forKey:(id<NSCopying>)key{  }

- (void)setBool:(BOOL)value forKey:(id<NSCopying>)key{  }

- (void)setInteger:(NSInteger)value forKey:(id<NSCopying>)key{  }

- (void)setUnsignedInteger:(NSUInteger)value forKey:(id<NSCopying>)key{  }

- (void)setPointValue:(CGPoint)value forKey:(id<NSCopying>)key{  }

- (void)setSizeValue:(CGSize)value forKey:(id<NSCopying>)key{  }

- (void)setRectValue:(CGRect)value forKey:(id<NSCopying>)key{  }


+ (BOOL)checkArrayIsEmptyOrNil:(NSArray *)aArray
{
    if (aArray == nil || [aArray count] == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(NSMutableArray *)setDicWithkey:(id)key dataDic:(NSMutableDictionary *)dataDic{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    if (self !=nil && self.count >0) {
        [dataDic setObjectCheck:self forKey:key];
    }
    if (dataDic.count > 0) {
        [modelArray removeAllObjects];
        for ( int i = 0; i< dataDic.allKeys.count+1; i++) {
            NSArray *dataArray = [dataDic objectForKeyCheck: @(i)];
            if (dataArray.count > 0 )
            [modelArray addObjectsFromArray:dataArray];
        }
        
        return modelArray;
    }
    return nil;
}

@end
