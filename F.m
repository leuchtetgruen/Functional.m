//
//  F.m
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import "F.h"

@implementation F

+ (void) eachInArray:(NSArray *) arr withBlock:(EachArrayBlock) block {
    [arr enumerateObjectsUsingBlock:^(__strong id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

+ (void) eachInDict:(NSDictionary *) dict withBlock:(EachDictBlock) block {
    [dict enumerateKeysAndObjectsUsingBlock:^(__strong id key, __strong id obj, BOOL *stop) {
        block((NSString *) key, obj);
    }];
}


+ (NSArray *) mapArray:(NSArray *) arr withBlock:(MapArrayBlock) block {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSObject *obj in arr) {
        [mutArr addObject:block(obj)];
    }
    return [NSArray arrayWithArray:mutArr];    
}

+ (NSDictionary *) mapDict:(NSDictionary *) dict withBlock:(MapDictBlock) block {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    for (NSString *key in dict) {
        NSObject *obj = [dict objectForKey:key];
        [mutDict setValue:block(key, obj) forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDict];
}

+ (NSObject *) reduceArray:(NSArray *) arr withBlock:(ReduceArrayBlock) block andInitialMemo:(NSObject *) memo {
    for (NSObject *obj in arr) {
        memo = block(memo, obj);
    }
    return memo;
}

+ (NSObject *) reduceDictionary:(NSDictionary *) dict withBlock:(ReduceDictBlock) block andInitialMemo:(NSObject *) memo {
    for (NSString *key in dict) {
        NSObject *obj = [dict objectForKey:key];
        memo = block(memo, key, obj);
    }
    return memo;
}

+ (NSArray *) filterArray:(NSArray *) arr withBlock:(FilterArrayBlock) block {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSObject *obj in arr) {
        if (block(obj)) [mutArr addObject:obj];
    }
    return [NSArray arrayWithArray:mutArr];
}

+ (NSDictionary *) filterDictionary:(NSDictionary *) dict withBlock:(FilterDictionaryBlock) block {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    for (NSString *key in dict) {
        if (block(key, [dict objectForKey:key])) [mutDict setObject:[dict objectForKey:key]  forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDict];
}


@end
