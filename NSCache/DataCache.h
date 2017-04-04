//
//  DataCache.h
//  NSCache
//
//  Created by 415 on 17/4/4.
//  Copyright © 2017年 415. All rights reserved.
//使用说明：此处采用两级缓存，在写入cache的同时，以key建一个文件路径将data写入文件；读取数据时先去cache中读取，如果cache中没有会去文件中读取
//使用是一种缓存类型开辟一块cache，建一个文件；如果是组件间共享可以在此例上拓展实现为单例，然后在每次写入文件时将内容使用NSFileHanler追加到文件中(只创建一次文件)

#import <Foundation/Foundation.h>

@interface DataCache : NSObject{
    
    NSString *filePath;
    NSCache *cache;
}

@property (nonatomic, retain) NSCache *cache;

//写入缓存
-(void)writeDataToCache:(NSData *)data forKey:(NSString *)key;

//读缓存内容
-(NSData*)readDataFromCacheForKey:(NSString *)key;
//+(CacheData *)sharedCacheInstance;
//+(void)destroyShareCacheInstance;
@end
