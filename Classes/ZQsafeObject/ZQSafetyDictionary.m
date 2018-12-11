//
//  ZQSafetyDictionary.m
//  ZQFoundation
//
//

#import "ZQSafetyDictionary.h"


@interface ZQSafetyDictionary ()
{
    dispatch_semaphore_t _lock;
    NSMutableDictionary *_dict;
}
@end



@implementation ZQSafetyDictionary
#pragma mark - init
+ (instancetype)safetyDictionaryWithDictionary:(NSDictionary *)dict {
   return  [[self alloc] initWithDictionary:dict];
}

+ (instancetype)safetyDictionary {
    return [[self alloc] init];
}

- (instancetype)init {
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setUpsWithDictionary:dict];
    }
    return self;
}

- (void)setUpsWithDictionary:(NSDictionary *)dict {
    _lock = dispatch_semaphore_create(1);
    _dict = [dict isKindOfClass:[NSDictionary class]] ? [NSMutableDictionary dictionaryWithDictionary:dict] : [NSMutableDictionary dictionary];
}

#pragma mark - getter
- (NSDictionary *)keyValues {
    NSDictionary *dict = nil;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    dict = [_dict copy];
    dispatch_semaphore_signal(_lock);
    return dict;
}
- (id)objectForKey:(id<NSCopying>)aKey {
    id obj = nil;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    obj = [_dict objectForKey:aKey];
    dispatch_semaphore_signal(_lock);
    return obj;
}

- (NSUInteger)count {
    NSUInteger count = 0;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    count = [_dict count];
    dispatch_semaphore_signal(_lock);
    return count;
}
- (NSArray<id<NSCopying>> *)allKeys {
    return self.keyValues.allKeys;
}
- (NSArray<id> *)allValues {
    return self.keyValues.allValues;
}
- (NSArray<id<NSCopying>> *)allKeysForObject:(id)anObject {
    return [self.keyValues allKeysForObject:anObject];
}

#pragma mark - setter
- (void)setValue:(id)value forKey:(NSString *)key {
    return [self setObject:value forKey:key];
}
- (void)setObject:(id)object forKey:(id)key {
    if (!key) {
        return;
    }
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
   
    object ? [_dict setObject:object forKey:key] : [_dict removeObjectForKey:key];
    
    dispatch_semaphore_signal(_lock);
}

- (void)removeObjectForKey:(id)key {
    if (!key) {
        return;
    }
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_dict removeObjectForKey:key];
    dispatch_semaphore_signal(_lock);
}

- (void)removeAllObjects {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_dict removeAllObjects];
    dispatch_semaphore_signal(_lock);
}

- (void)removeObjectsForKeys:(NSArray<id<NSCopying>> *)keyArray {
    if (keyArray.count == 0) {
        return;
    }
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_dict removeObjectsForKeys:keyArray];
    dispatch_semaphore_signal(_lock);
}
- (void)setDictionary:(NSDictionary *)otherDictionary {
    if ([otherDictionary isKindOfClass:[NSDictionary class]]) {
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [_dict setDictionary:otherDictionary];
        dispatch_semaphore_signal(_lock);
    }
}
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    return [self setDictionary:keyedValues];
}
#pragma mark - enumerate
- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id<NSCopying>, id, BOOL *))block {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_dict enumerateKeysAndObjectsUsingBlock:block];
    dispatch_semaphore_signal(_lock);
}

- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id<NSCopying>, id, BOOL *))block {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_dict enumerateKeysAndObjectsWithOptions:opts usingBlock:block];
    dispatch_semaphore_signal(_lock);
}
#pragma mark - description
- (NSString *)description {
    return [NSString stringWithFormat:@"%@",[self keyValues]];
}

#pragma mark - is equal
- (BOOL)isEqualToDictionary:(id)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return [self.keyValues isEqual:dictionary];
    }else if ([dictionary isKindOfClass:self.class]) {
        return [self.keyValues isEqual:[(ZQSafetyDictionary *)dictionary keyValues]];
    }
    return NO;
}

- (BOOL)isEqual:(id)object {
    return [self isEqualToDictionary:object];
}

@end
