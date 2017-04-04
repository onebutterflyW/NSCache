//
//  CacheImage.h
//  NSCache
//
//  Created by 415 on 17/4/4.
//  Copyright © 2017年 415. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheData : NSObject{
    
    NSString *filePath;
    NSCache *cache;
}

@property (nonatomic, retain) NSCache *cache;

-(void)writeDataToCache:(NSData *)data forKey:(NSString *)key;
-(NSData*)readDataFromCacheForKey:(NSString *)key;
//+(CacheData *)sharedCacheInstance;
//+(void)destroyShareCacheInstance;
@end
