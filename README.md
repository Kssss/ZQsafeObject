# ZQsafeObject
iOS 多线程安全的数组/字典/集合 类 
在项目中使用到的数组/字典/集合一般都是单线程安全的。但是在多线程环境下是不安全的。通常给数据写入加锁。但是写起来会有一些麻烦。故将这些数组/字典/集合封装起来。更加面向对象。
框架中使用信号量dispatch_semaphore_t做为线程控制，确保数据安全。