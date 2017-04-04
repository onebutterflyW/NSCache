//
//  CacheImage.m
//  NSCache
//
//  Created by 415 on 17/4/4.
//  Copyright © 2017年 415. All rights reserved.
//

#import "CacheData.h"

@interface CacheData (){

    NSData *returnData;
}


@end

static CacheData *shareInstance = nil;

@implementation CacheData
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
//+(CacheData *)sharedCacheInstance{
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
    }
    
    return self;
}


-(void)writeDataToCache:(NSData *)data forKey:(NSString *)key{

    //写入缓存
    [self.cache setObject:data forKey:key];
    
    //建一个文件路径,只执行一次，将数据写到同一个文件
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    NSArray *documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documentDir objectAtIndex:0];
    filePath= [path stringByAppendingPathComponent:@"key"];

    });
  
        NSFileManager *manager = [NSFileManager defaultManager];
        if(![manager fileExistsAtPath:filePath]){
        
            if([data writeToFile:filePath atomically:YES]){
            
                NSLog(@"新建文件并写入成功");
            
            }else{
            
                NSLog(@"写入新建文件失败");
            }
        
        }else{
        
            NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            
            [handle seekToEndOfFile];
            [handle writeData:data];
            [handle closeFile];
            NSLog(@"追加文件成功");
        
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
        
       returnData = [[NSFileManager defaultManager]contentsAtPath:filePath];
    
   
    }
    
    return returnData;
}




@end
