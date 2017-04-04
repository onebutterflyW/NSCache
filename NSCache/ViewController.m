//
//  ViewController.m
//  NSCache
//
//  Created by 415 on 17/4/4.
//  Copyright © 2017年 415. All rights reserved.
//

#import "ViewController.h"
#import "DataCache.h"

@interface ViewController ()<NSCacheDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self useCache];
    
    [self useDefineCache];
    
}



-(void)useDefineCache{

    DataCache *cache = [[DataCache alloc]init];
    for (int i = 0; i < 10 ; i ++) {
        
        NSString *key = [NSString stringWithFormat:@"key_%d",i];
        NSString *value = [NSString stringWithFormat:@"value_%d",i];
        NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
        //写入cache
        [cache writeDataToCache:data forKey:key];
    }
    
    
    for (int j = 0; j < 10; j ++) {
        NSString *key = [NSString stringWithFormat:@"key_%d",j];;
      
       NSData *data = [cache readDataFromCacheForKey:key];
        NSLog(@"cache中的数据:key=%@,value=%@",key,data);
    }
    


}


-(void)useCache{

    NSCache *cache = [[NSCache alloc]init];
    cache.delegate = self;
    cache.countLimit = 5;
    
    for (int i = 0; i < 10 ; i ++) {
        
        NSString *key = [NSString stringWithFormat:@"key_%d",i];
        NSString *value = [NSString stringWithFormat:@"value_%d",i];
        //写入cache
        [cache setObject:value forKey:key];
    }
    
    
    for (int j = 0; j < 10; j ++) {
        NSString *key = [NSString stringWithFormat:@"key_%d",j];;
        NSString *value = [cache objectForKey:key ];
        
        NSLog(@"cache中的数据:key=%@,value=%@",key,value);
    }
    
    


}

#pragma  mark NSCacheDelegate
-(void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"%s",__func__);
    NSLog(@"%@",obj);

}


@end
