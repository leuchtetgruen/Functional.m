//
//  F.h
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^EachArrayBlock)(NSObject *obj);
typedef void (^EachDictBlock)(NSString *key, NSObject *value);

typedef NSObject* (^MapArrayBlock)(NSObject *obj);
typedef NSObject* (^MapDictBlock)(NSString *key, NSObject *obj);

typedef NSObject* (^ReduceArrayBlock)(NSObject *memo, NSObject *obj);
typedef NSObject* (^ReduceDictBlock)(NSObject *memo, NSString *key, NSObject *value);

typedef BOOL (^FilterArrayBlock)(NSObject *obj);
typedef BOOL (^FilterDictionaryBlock)(NSString *key, NSObject *value);

@interface F : NSObject
    + (void) eachInArray:(NSArray *) arr withBlock:(EachArrayBlock) block;
    + (void) eachInDict:(NSDictionary *) dict withBlock:(EachDictBlock) block;

    + (NSArray *) mapArray:(NSArray *) arr withBlock:(MapArrayBlock) block;
    + (NSDictionary *) mapDict:(NSDictionary *) dict withBlock:(MapDictBlock) block;

    + (NSObject *) reduceArray:(NSArray *) arr withBlock:(ReduceArrayBlock) block andInitialMemo:(NSObject *) memo;
    + (NSObject *) reduceDictionary:(NSDictionary *) dict withBlock:(ReduceDictBlock) block andInitialMemo:(NSObject *) memo; 

    + (NSArray *) filterArray:(NSArray *) arr withBlock:(FilterArrayBlock) block;
    + (NSDictionary *) filterDictionary:(NSDictionary *) dict withBlock:(FilterDictionaryBlock) block;


@end
