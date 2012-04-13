//
//  F.h
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidIteratorArrayBlock)(id obj);
typedef void (^VoidIteratorDictBlock)(id key, id value);

typedef id (^MapArrayBlock)(id obj);
typedef id (^MapDictBlock)(id key, id obj);

typedef id (^ReduceArrayBlock)(id memo, id obj);
typedef id (^ReduceDictBlock)(id memo, id key, id value);

typedef BOOL (^BoolArrayBlock)(id obj);
typedef BOOL (^BoolDictionaryBlock)(id key, id value);

typedef NSComparisonResult (^CompareArrayBlock) (id a, id b);
typedef NSComparisonResult (^CompareDictBlock) (id k1, id v1 , id k2, id v2);

typedef void (^VoidBlock) ();



@interface F : NSObject
    + (void) eachInArray:(NSArray *) arr withBlock:(VoidIteratorArrayBlock) block;
    + (void) eachInDict:(NSDictionary *) dict withBlock:(VoidIteratorDictBlock) block;

    + (NSArray *) mapArray:(NSArray *) arr withBlock:(MapArrayBlock) block;
    + (NSDictionary *) mapDict:(NSDictionary *) dict withBlock:(MapDictBlock) block;

    + (NSObject *) reduceArray:(NSArray *) arr withBlock:(ReduceArrayBlock) block andInitialMemo:(id) memo;
    + (NSObject *) reduceDictionary:(NSDictionary *) dict withBlock:(ReduceDictBlock) block andInitialMemo:(id) memo; 

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
