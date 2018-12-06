//
//  ZQSafetySet.m
//  ZQFoundation
//
//

#import "ZQSafetySet.h"

@interface ZQSafetySet ()
{
    dispatch_semaphore_t _lock;
    NSMutableSet *_set;
}

@end



@implementation ZQSafetySet
#pragma mark - init
+ (instancetype)safetySetWithSet:(NSSet *)set {
    return [[self alloc] initWithSet:set];
}
+ (instancetype)safetySetWithArray:(NSArray *)array {
    return [[self alloc] initWithArray:array];
}
+ (instancetype)safetySet {
    return [[self alloc] init];
}

- (instancetype)init {
    return [self initWithSet:nil];
}
- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        _lock = dispatch_semaphore_create(1);
        _set  = [array isKindOfClass:NSArray.class] ? [NSMutableSet setWithArray:array] : [NSMutableSet set];
    }
    return self;

}
- (instancetype)initWithSet:(NSSet *)set {
    if (self = [super init]) {
        [self setUpsWithSet:set];
    }
    return self;
}
- (void)setUpsWithSet:(NSSet *)set {
    _lock = dispatch_semaphore_create(1);
    _set  = [set isKindOfClass:NSSet.class] ? [NSMutableSet setWithSet:set] : [NSMutableSet set];
}

#pragma mark - getter
- (NSUInteger)count {
    NSUInteger count = 0;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    count = _set.count;
    dispatch_semaphore_signal(_lock);
    return count;
}
- (id)anyObject {
    id obj = nil;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    obj = _set.anyObject;
    dispatch_semaphore_signal(_lock);
    return obj;
}
- (NSArray *)allObjects {
    NSArray *objects = nil;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    objects = _set.allObjects;
    dispatch_semaphore_signal(_lock);
    return objects;
}
- (NSSet *)objcSet {
    NSSet *set = nil;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    set = _set.copy;
    dispatch_semaphore_signal(_lock);
    return set;
}
- (BOOL)containsObject:(id)anObject {
    if (!anObject) {
        return NO;
    }
    BOOL isContain = NO;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    isContain = [_set containsObject:anObject];
    dispatch_semaphore_signal(_lock);
    return isContain;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@",self.objcSet];
}

#pragma mark - setter
- (void)addObject:(id)object; {
    if (object) {
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [_set addObject:object];
        dispatch_semaphore_signal(_lock);
    }
}
- (void)removeObject:(id)object; {
    if (object) {
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [_set removeObject:object];
        dispatch_semaphore_signal(_lock);
    }
}

- (void)removeAllObjects {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_set removeAllObjects];
    dispatch_semaphore_signal(_lock);
}

- (void)addObjectsFromArray:(NSArray *)array {
    if (array.count) {
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [_set addObjectsFromArray:array];
        dispatch_semaphore_signal(_lock);
    }
}
- (void)intersectSet:(NSSet *)otherSet {
    if (otherSet.count) {
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [_set intersectSet:otherSet];
        dispatch_semaphore_signal(_lock);
    }
}
- (void)removeObjectsFromArray:(NSArray *)array {
    if (array.count) {
        dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_set removeObject:obj];
        }];
        dispatch_semaphore_signal(_lock);
    }
}
#pragma mark - enumerate
- (void)enumerateObjectsUsingBlock:(void (^)(id obj, BOOL *stop))block{
    
    //[self.objcSet enumerateObjectsUsingBlock:block];
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    BOOL stop = NO;
    for (id obj in _set) {
        if (stop) {
            break;
        }
        !block ? : block(obj,&stop);
    }
    //[_set enumerateObjectsUsingBlock:block];
    dispatch_semaphore_signal(_lock);
}

- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0); {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_set enumerateObjectsWithOptions:opts usingBlock:block];
    dispatch_semaphore_signal(_lock);
}

#pragma mark - equal
- (BOOL)isEqualToSet:(NSSet *)set {
    if ([set isKindOfClass:NSSet.class]) {
        return [self.objcSet isEqualToSet:set];
    }
    return NO;
}
- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        return [self.objcSet isEqualToSet:[(ZQSafetySet *)object objcSet]];
    }
    return [self isEqual:object];
}


@end
