# ZQsafeObject
ZQsafeObject     | version | 日期
------- | ------------------|---------
iOS     |  1.0 | 2018-12

#### 要求
iOS8.0 和Xcode 8以上
## 一、简介
    在项目中使用到的数组/字典/集合一般都是单线程安全的。但是在多线程环境下是不安全的。通常给数据写入加锁。但是写起来会有一些麻烦。故将这些数组/字典/集合封装起来，更加面向对象。框架中使用信号量dispatch_semaphore_t做为线程控制，确保数据安全。使用和原生API类似。

## 二、使用
#### （1）数组

```js
+ (instancetype)safetyArray;
+ (instancetype)safetyArrayWithArray:(NSArray *)array;
+ (instancetype)arrayWithCapacity:(NSUInteger)capacity;

```

#### （2）字典

```js
+ (instancetype)safetyDictionary;
+ (instancetype)safetyDictionaryWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
```
#### （3）set

```js
+ (instancetype)safetySetWithSet:(NSSet *)set;
+ (instancetype)safetySetWithArray:(NSArray *)array;
- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initWithSet:(NSSet *)set;

```

