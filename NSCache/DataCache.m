//
//  DataCache.m
//  NSCache
//
//  Created by 415 on 17/4/4.
//  Copyright © 2017年 415. All rights reserved.
//

#import "DataCache.h"


@interface DataCache ()
{
    
    NSData *returnData;
}


@end

static DataCache *shareInstance = nil;

@implementation DataCache
@synthesize cache;



//+(instancetype)allocWithZone:(struct _NSZone *)zone{
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//        shareInstance = [super allocWithZone:zone];
//
//    });
//    return shareInstance;
//}
//
//+(DataCache *)sharedCacheInstance{
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (shareInstance == nil) {
//
//            shareInstance = [[CacheData alloc]init];
//        }
//    });
//    return shareInstance;
//
//}
//
//+(void)destroyShareCacheInstance{
//
//    shareInstance = nil;
//
//}



-(id)init{
    
    self = [super init];
    
    if (self) {
        self.cache = [[NSCache alloc]init];
        self.cache.countLimit = 5;
    }
    
    return self;
}


-(void)writeDataToCache:(NSData *)data forKey:(NSString *)key{
    
    //写入缓存
    [self.cache setObject:data forKey:key];
    
    //建一个文件路径,只执行一次，将数据写到同一个文件
    //如果是组间共享时，使用GCD一次性代码创建一个文件，然后每次存时追加内容
    NSArray *documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documentDir objectAtIndex:0];
    filePath= [path stringByAppendingPathComponent:key];
   
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if(![manager fileExistsAtPath:filePath]){
        
        if([data writeToFile:filePath atomically:YES]){
            
            NSLog(@"新建文件并写入成功");
            
        }else{
            
            NSLog(@"写入新建文件失败");
        }
    }
    
    
}


-(NSData*)readDataFromCacheForKey:(NSString *)key{
    
    
    if(key==nil){
        
        return nil;
        
    }
    //从缓存中获取
    NSData *cacheData = [self.cache objectForKey:key];
    
    
    //如果缓存没有，读文件，文件没有则下载
    if(cacheData){
        
        NSLog(@"从缓存中获取数据");
        
        returnData = cacheData;
      
        
    }else{
        
        NSData *dataOfFile = [[NSFileManager defaultManager]contentsAtPath:filePath];
        returnData = dataOfFile;
         NSLog(@"从文件中获取数据");
      
        
        NSArray *arr = [filePath componentsSeparatedByString:@"/"];
        NSInteger index = [arr count];
        NSString *key = arr[index-1];

        [self.cache setObject:dataOfFile forKey:key];
       
        
        
    }
    
    return returnData;
}




@end

