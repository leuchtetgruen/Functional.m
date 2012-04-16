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
        block(key, obj);
    }];
}


+ (NSArray *) mapArray:(NSArray *) arr withBlock:(MapArrayBlock) block {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (id obj in arr) {
        [mutArr addObject:block(obj)];
    }
    return [NSArray arrayWithArray:mutArr];    
}

+ (NSDictionary *) mapDict:(NSDictionary *) dict withBlock:(MapDictBlock) block {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    for (id key in dict) {
        id obj = [dict objectForKey:key];
        [mutDict setValue:block(key, obj) forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDict];
}

+ (NSObject *) reduceArray:(NSArray *) arr withBlock:(ReduceArrayBlock) block andInitialMemo:(NSObject *) memo {
    for (id obj in arr) {
        memo = block(memo, obj);
    }
    return memo;
}

+ (NSObject *) reduceDictionary:(NSDictionary *) dict withBlock:(ReduceDictBlock) block andInitialMemo:(NSObject *) memo {
    for (id key in dict) {
        id obj = [dict objectForKey:key];
        memo = block(memo, key, obj);
    }
    return memo;
}

+ (NSArray *) filterArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (id obj in arr) {
        if (block(obj)) [mutArr addObject:obj];
    }
    return [NSArray arrayWithArray:mutArr];
}

+ (NSDictionary *) filterDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    for (id key in dict) {
        if (block(key, [dict objectForKey:key])) [mutDict setObject:[dict objectForKey:key]  forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDict];
}

+ (NSArray *) rejectArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (id obj in arr) {
        if (!block(obj)) [mutArr addObject:obj];
    }
    return [NSArray arrayWithArray:mutArr];
}

+ (NSDictionary *) rejectDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    for (id key in dict) {
        if (!block(key, [dict objectForKey:key])) [mutDict setObject:[dict objectForKey:key]  forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDict];
}

+ (BOOL) allInArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    BOOL validForAll = true;
    for (id obj in arr) {
        validForAll = (validForAll && block(obj));
        if (!validForAll) break;
    }
    return validForAll;
}

+ (BOOL) allInDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    BOOL validForAll = true;
    for (id key in dict) {
        validForAll = (validForAll && block(key, [dict objectForKey:key]));
        if (!validForAll) break;
    }
    return validForAll;
}

+ (BOOL) anyInArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    BOOL validForAny = false;
    for (id obj in arr) {
        validForAny = (validForAny || block(obj));
        if (validForAny) break;
    }
    return validForAny;
}

+ (BOOL) anyInDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    BOOL validForAny = false;
    for (id key in dict) {
        validForAny = (validForAny || block(key, [dict objectForKey:key]));
        if (validForAny) break;
    }
    return validForAny;    
}

+ (NSNumber *) countInArray:(NSArray *) arr withBlock:(BoolArrayBlock) block {
    NSInteger ctr = 0;
    for (id obj in arr) {
        if(block(obj)) ctr++;
    }
    return [NSNumber numberWithInt:ctr];
}

+ (NSNumber *) countInDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block {
    NSInteger ctr = 0;
    for (id key in dict) {
        if (block(key, [dict objectForKey:key])) ctr++;
    }
    return [NSNumber numberWithInt:ctr];
}



+ (id) maxArray:(NSArray *) arr withBlock:(CompareArrayBlock) block {
    if ([arr count]<1) return NULL;
    
    id biggest = [arr objectAtIndex:0];
    for (id obj in arr) {
        if (block(biggest, obj) == NSOrderedAscending) biggest = obj;
    }
    return biggest;
}

+ (id) maxDict:(NSDictionary *) dict withBlock:(CompareDictBlock) block {
    if ([dict count] < 1) return NULL;
    
    id biggest = NULL;
    id biggestKey = @"";
    for (id key in dict) {
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

+ (id) minArray:(NSArray *) arr withBlock:(CompareArrayBlock) block {
    if ([arr count]<1) return NULL;
    
    id smallest = [arr objectAtIndex:0];
    for (id obj in arr) {
        if (block(smallest, obj) == NSOrderedDescending) smallest = obj;
    }
    return smallest;
}

+ (id) minDict:(NSDictionary *) dict withBlock:(CompareDictBlock) block {
    if ([dict count] < 1) return NULL;
    
    id smallest = NULL;
    id smallestKey = @"";
    for (id key in dict) {
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
    for (id obj in arr) {
        id transformed = block(obj);
        if ([mutDictOfMutArrays objectForKey:transformed]==nil) {
            [mutDictOfMutArrays setObject:[NSMutableArray array] forKey:transformed];
        }
        NSMutableArray *itemsInThisGroup = [mutDictOfMutArrays objectForKey:transformed];
        [itemsInThisGroup addObject:obj];
    }
    
    NSMutableDictionary *mutDictOfArrays = [NSMutableDictionary dictionary];
    for (id key in mutDictOfMutArrays) {
        
        NSMutableArray *mutArr = (NSMutableArray *) [mutDictOfMutArrays objectForKey:key];
        [mutDictOfArrays setObject:[NSArray arrayWithArray:mutArr] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:mutDictOfArrays];
}

+ (void) times:(NSNumber *) nr RunBlock:(VoidBlock) block {
    for (int i=0; i < [nr intValue]; i++) block();
}
@end
