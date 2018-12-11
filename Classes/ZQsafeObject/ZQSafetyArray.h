//
//  ZQSafetyArray.h
//  ZQFoundation
//
//

#import <Foundation/Foundation.h>

@interface ZQSafetyArray : NSObject

+ (instancetype)safetyArray;
+ (instancetype)safetyArrayWithArray:(NSArray *)array;
+ (instancetype)arrayWithCapacity:(NSUInteger)capacity;


- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initWithCapacity:(NSUInteger)capacity;


/** 数组getter */
@property (readonly,copy) NSArray *objects;


- (NSString *)componentsJoinedByString:(NSString *)separator;
- (BOOL)containsObject:(id)anObject;



- (NSUInteger)indexOfObject:(id)anObject;
- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range;
- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject;
- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (BOOL)isEqualToArray:(NSArray *)otherArray;


- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;



- (void)addObjectsFromArray:(NSArray *)otherArray;
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)removeAllObjects;
- (void)removeObject:(id)anObject inRange:(NSRange)range;
- (void)removeObject:(id)anObject;



@end
