//
//  F.m
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import "F.h"

@implementation F

+ (void) eachInArray:(NSArray *) arr withBlock:(VoidIteratorArrayBlock) block {
    [arr enumerateObjectsUsingBlock:^(__strong id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

+ (void) eachInDict:(NSDictionary *) dict withBlock:(VoidIteratorDictBlock) block {
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

+ (NSArray *) filterArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSObject *obj in arr) {
        if (block(obj)) [mutArr addObject:obj];
    }
    return [NSArray arrayWithArray:mutArr];
}

+ (NSDictionary *) filterDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    for (NSString *key in dict) {
        if (block(key, [dict objectForKey:key])) [mutDict setObject:[dict objectForKey:key]  forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDict];
}

+ (NSArray *) rejectArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSObject *obj in arr) {
        if (!block(obj)) [mutArr addObject:obj];
    }
    return [NSArray arrayWithArray:mutArr];
}

+ (NSDictionary *) rejectDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    for (NSString *key in dict) {
        if (!block(key, [dict objectForKey:key])) [mutDict setObject:[dict objectForKey:key]  forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDict];
}

+ (BOOL) allInArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    BOOL validForAll = true;
    for (NSObject *obj in arr) {
        validForAll = (validForAll && block(obj));
    }
    return validForAll;
}

+ (BOOL) allInDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    BOOL validForAll = true;
    for (NSString *key in dict) {
        validForAll = (validForAll && block(key, [dict objectForKey:key]));
    }
    return validForAll;
}

+ (BOOL) anyInArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    BOOL validForAny = false;
    for (NSObject *obj in arr) {
        validForAny = (validForAny || block(obj));
    }
    return validForAny;
}

+ (BOOL) anyInDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    BOOL validForAny = false;
    for (NSString *key in dict) {
        validForAny = (validForAny || block(key, [dict objectForKey:key]));
    }
    return validForAny;    
}

+ (NSObject *) maxArray:(NSArray *) arr withBlock:(CompareArrayBlock) block {
    if ([arr count]<1) return NULL;
    
    NSObject *biggest = [arr objectAtIndex:0];
    for (NSObject *obj in arr) {
        if (block(biggest, obj) == NSOrderedAscending) biggest = obj;
    }
    return biggest;
}

+ (NSObject *) maxDict:(NSDictionary *) dict withBlock:(CompareDictBlock) block {
    if ([dict count] < 1) return NULL;
    
    NSObject *biggest = NULL;
    NSString *biggestKey = @"";
    for (NSString *key in dict) {
        if (biggest == NULL) {
            biggest = [dict objectForKey:key];
            biggestKey = key;
        }
        if (block(biggestKey, biggest, key, [dict objectForKey:key]) == NSOrderedAscending) {
            biggest = [dict objectForKey:key];
            biggestKey = key;
        }
    }
    return biggest;
}

+ (NSObject *) minArray:(NSArray *) arr withBlock:(CompareArrayBlock) block {
    if ([arr count]<1) return NULL;
    
    NSObject *smallest = [arr objectAtIndex:0];
    for (NSObject *obj in arr) {
        if (block(smallest, obj) == NSOrderedDescending) smallest = obj;
    }
    return smallest;
}

+ (NSObject *) minDict:(NSDictionary *) dict withBlock:(CompareDictBlock) block {
    if ([dict count] < 1) return NULL;
    
    NSObject *smallest = NULL;
    NSString *smallestKey = @"";
    for (NSString *key in dict) {
        if (smallest == NULL) {
            smallest = [dict objectForKey:key];
            smallestKey = key;
        }
        if (block(smallestKey, smallest, key, [dict objectForKey:key]) == NSOrderedDescending) {
            smallest = [dict objectForKey:key];
            smallestKey = key;
        }
    }
    return smallest;   
}

+ (NSDictionary *) groupArray:(NSArray *) arr withBlock:(MapArrayBlock) block {
    NSMutableDictionary *mutDictOfMutArrays = [NSMutableDictionary dictionary];
    for (NSObject *obj in arr) {
        NSObject *transformed = block(obj);
        if ([mutDictOfMutArrays objectForKey:transformed]==nil) {
            [mutDictOfMutArrays setObject:[NSMutableArray array] forKey:transformed];
        }
        NSMutableArray *itemsInThisGroup = [mutDictOfMutArrays objectForKey:transformed];
        [itemsInThisGroup addObject:obj];
    }
    
    NSMutableDictionary *mutDictOfArrays = [NSMutableDictionary dictionary];
    for (NSObject *key in mutDictOfMutArrays) {
        
        NSMutableArray *mutArr = (NSMutableArray *) [mutDictOfMutArrays objectForKey:key];
        [mutDictOfArrays setObject:[NSArray arrayWithArray:mutArr] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDictOfArrays];
}

+ (void) times:(NSNumber *) nr RunBlock:(VoidBlock) block {
    for (int i=0; i < [nr intValue]; i++) block();
}
@end
