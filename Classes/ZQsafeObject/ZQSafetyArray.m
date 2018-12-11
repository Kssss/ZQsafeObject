//
//  ZQSafetyArray.m
//  ZQFoundation
//
//

#import "ZQSafetyArray.h"

@interface ZQSafetyArray ()
{
    dispatch_semaphore_t _lock;
    NSMutableArray *_array;
}
@end



@implementation ZQSafetyArray

#pragma mark - init
+ (instancetype)safetyArray {
    return [[self alloc] init];
}

+ (instancetype)safetyArrayWithArray:(NSArray *)array {
    return [[self alloc] initWithArray:array];
}

- (instancetype)init {
    return [self initWithArray:nil];
}

- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        [self setUpsWithArray:array];
    }
    return self;
}

+ (instancetype)arrayWithCapacity:(NSUInteger)capacity {
    return [[self alloc] initWithCapacity:0];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    if (self = [super init]) {
        _lock = dispatch_semaphore_create(1);
        _array = capacity ? [NSMutableArray arrayWithCapacity:capacity] : [NSMutableArray array];
    }
    return self;
}
- (void)setUpsWithArray:(NSArray *)array {
    _lock = dispatch_semaphore_create(1);
    _array = [array isKindOfClass:NSArray.class] ? [NSMutableArray arrayWithArray:array] : [NSMutableArray array];
}

#pragma mark - getter

- (NSArray *)objects {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    NSArray *array = [NSArray arrayWithArray:_array];
    dispatch_semaphore_signal(_lock);
    return array;
}


- (NSString *)componentsJoinedByString:(NSString *)separator {
    return [self.objects componentsJoinedByString:separator];
}
- (BOOL)containsObject:(id)anObject {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    BOOL isContain = [_array containsObject:anObject];
    dispatch_semaphore_signal(_lock);
    return isContain;
}



- (NSUInteger)indexOfObject:(id)anObject{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    NSUInteger index = [_array indexOfObject:anObject];
    dispatch_semaphore_signal(_lock);
    return index;
}


- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    NSUInteger index = [_array indexOfObject:anObject inRange:range];
    dispatch_semaphore_signal(_lock);
    return index;
}


- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    NSUInteger index = [_array indexOfObjectIdenticalTo:anObject ];
    dispatch_semaphore_signal(_lock);
    return index;
}


- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    NSUInteger index = [_array indexOfObjectIdenticalTo:anObject inRange:range];
    dispatch_semaphore_signal(_lock);
    return index;
}


- (BOOL)isEqualToArray:(NSArray *)otherArray{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    BOOL isEqual = [_array isEqualToArray:otherArray];
    dispatch_semaphore_signal(_lock);
    return isEqual;
}





#pragma mark - update
- (void)addObject:(id)anObject{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array addObject:anObject];
    dispatch_semaphore_signal(_lock);
    

}


- (void)insertObject:(id)anObject atIndex:(NSUInteger)index{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array addObject:anObject];
    dispatch_semaphore_signal(_lock);

}


- (void)removeLastObject{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array removeLastObject];
    dispatch_semaphore_signal(_lock);

}


- (void)removeObjectAtIndex:(NSUInteger)index{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array removeObjectAtIndex:index];
    dispatch_semaphore_signal(_lock);

}


- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array replaceObjectAtIndex:index withObject:anObject];
    dispatch_semaphore_signal(_lock);

}





- (void)addObjectsFromArray:(NSArray *)otherArray{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array addObjectsFromArray:otherArray];
    dispatch_semaphore_signal(_lock);

}


- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    dispatch_semaphore_signal(_lock);

}


- (void)removeAllObjects {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array removeAllObjects];
    dispatch_semaphore_signal(_lock);

}


- (void)removeObject:(id)anObject inRange:(NSRange)range {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array removeObject:anObject inRange:range];
    dispatch_semaphore_signal(_lock);

}


- (void)removeObject:(id)anObject {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_array removeObject:anObject];
    dispatch_semaphore_signal(_lock);

}





@end
