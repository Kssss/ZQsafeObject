//
//  ZQSafetyDictionary.h
//  ZQFoundation
//
//

#import <Foundation/Foundation.h>

@interface ZQSafetyDictionary : NSObject

+ (instancetype)safetyDictionary;

+ (instancetype)safetyDictionaryWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (readonly) NSUInteger count;
- (id)objectForKey:(id<NSCopying>)aKey;

@property (readonly, copy) NSArray<id <NSCopying>> *allKeys;
- (NSArray <id <NSCopying>> *)allKeysForObject:(id)anObject;
@property (readonly, copy) NSArray<id> *allValues;
@property (readonly, copy) NSDictionary *keyValues;



- (void)setObject:(id)object forKey:(id<NSCopying>)key;
- (void)setDictionary:(NSDictionary *)otherDictionary;

- (void)removeObjectForKey:(id<NSCopying>)key;
- (void)removeObjectsForKeys:(NSArray<id<NSCopying>> *)keyArray;
- (void)removeAllObjects;

- (void)enumerateKeysAndObjectsUsingBlock:(void (NS_NOESCAPE ^)(id<NSCopying> key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id<NSCopying> key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);


- (BOOL)isEqualToDictionary:(id)dictionary;

@end
