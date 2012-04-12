//
//  F.h
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidIteratorArrayBlock)(NSObject *obj);
typedef void (^VoidIteratorDictBlock)(NSObject *key, NSObject *value);

typedef NSObject* (^MapArrayBlock)(NSObject *obj);
typedef NSObject* (^MapDictBlock)(NSObject *key, NSObject *obj);

typedef NSObject* (^ReduceArrayBlock)(NSObject *memo, NSObject *obj);
typedef NSObject* (^ReduceDictBlock)(NSObject *memo, NSObject *key, NSObject *value);

typedef BOOL (^BoolArrayBlock)(NSObject *obj);
typedef BOOL (^BoolDictionaryBlock)(NSObject *key, NSObject *value);

typedef NSComparisonResult (^CompareArrayBlock) (NSObject *a, NSObject *b);
typedef NSComparisonResult (^CompareDictBlock) (NSObject *k1, NSObject *v1 , NSObject *k2, NSObject *v2);

typedef void (^VoidBlock) ();



@interface F : NSObject
    + (void) eachInArray:(NSArray *) arr withBlock:(VoidIteratorArrayBlock) block;
    + (void) eachInDict:(NSDictionary *) dict withBlock:(VoidIteratorDictBlock) block;

    + (NSArray *) mapArray:(NSArray *) arr withBlock:(MapArrayBlock) block;
    + (NSDictionary *) mapDict:(NSDictionary *) dict withBlock:(MapDictBlock) block;

    + (NSObject *) reduceArray:(NSArray *) arr withBlock:(ReduceArrayBlock) block andInitialMemo:(NSObject *) memo;
    + (NSObject *) reduceDictionary:(NSDictionary *) dict withBlock:(ReduceDictBlock) block andInitialMemo:(NSObject *) memo; 

    + (NSArray *) filterArray:(NSArray *) arr withBlock:(BoolArrayBlock) block;
    + (NSDictionary *) filterDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block;

    + (NSArray *) rejectArray:(NSArray *) arr withBlock:(BoolArrayBlock) block;
    + (NSDictionary *) rejectDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block;

    + (BOOL) allInArray:(NSArray *) arr withBlock:(BoolArrayBlock) block;
    + (BOOL) allInDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block;

    + (BOOL) anyInArray:(NSArray *) arr withBlock:(BoolArrayBlock) block;
    + (BOOL) anyInDictionary:(NSDictionary *) dict withBlock:(BoolDictionaryBlock) block;

    + (NSObject *) maxArray:(NSArray *) arr withBlock:(CompareArrayBlock) block;
    + (NSObject *) maxDict:(NSDictionary *) dict withBlock:(CompareDictBlock) block;
    + (NSObject *) minArray:(NSArray *) arr withBlock:(CompareArrayBlock) block;
    + (NSObject *) minDict:(NSDictionary *) dict withBlock:(CompareDictBlock) block;

    + (NSDictionary *) groupArray:(NSArray *) arr withBlock:(MapArrayBlock) block;
//    + (NSDictionary *) groupDictionary:(NSDictionary *) dict withBlock:(MapDictBlock) block;

    + (void) times:(NSNumber *) nr RunBlock:(VoidBlock) block;
@end
