//
//  NSArray+F.m
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import "NSArray+F.h"

@implementation NSArray(F)

- (void) each:(VoidIteratorArrayBlock) block {
    [F eachInArray:self withBlock:block];
}

- (NSArray *) map:(MapArrayBlock) block {
    return [F mapArray:self withBlock:block];
}

- (id) reduce:(ReduceArrayBlock) block withInitialMemo:(id) memo {
    return [F reduceArray:self withBlock:block andInitialMemo:memo];
}

- (NSArray *) filter:(BoolArrayBlock) block {
    return [F filterArray:self withBlock:block];
}

- (NSArray *) reject:(BoolArrayBlock) block {
    return [F rejectArray:self withBlock:block];
}

- (BOOL) isValidForAll:(BoolArrayBlock) block {
    return [F allInArray:self withBlock:block];
}

- (BOOL) isValidForAny:(BoolArrayBlock) block {
    return [F anyInArray:self withBlock:block];
}

- (NSNumber *) countValidEntries:(BoolArrayBlock) block {
    return [F countInArray:self withBlock:block];
}

- (id) max:(CompareArrayBlock) block {
    return [F maxArray:self withBlock:block];
}

- (id) min:(CompareArrayBlock) block {
    return [F minArray:self withBlock:block];
}

// This is really just an alias
- (NSArray *) sort:(NSComparator) block {
    return [self sortedArrayUsingComparator:block];
}

- (NSDictionary *) group:(MapArrayBlock) block {
    return [F groupArray:self withBlock:block];
}

// Just a helper method
- (id) first {
    return [self objectAtIndex:0];
}

+ (NSArray *) arrayFrom:(NSInteger) from To:(NSInteger) to {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSInteger i=from; i <= to; i++) {
        [mutArr addObject:[NSNumber numberWithInteger:i]];
    }
    return [NSArray arrayWithArray:mutArr];
}

@end
