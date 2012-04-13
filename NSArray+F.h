//
//  NSArray+F.h
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F.h"

@interface NSArray(F)
    - (void) each:(VoidIteratorArrayBlock) block;
    - (NSArray *) map:(MapArrayBlock) block;
    - (NSObject *) reduce:(ReduceArrayBlock) block withInitialMemo:(NSObject *) memo;
    - (NSArray *) filter:(BoolArrayBlock) block;
    - (NSArray *) reject:(BoolArrayBlock) block;
    - (BOOL) isValidForAll:(BoolArrayBlock) block;
    - (BOOL) isValidForAny:(BoolArrayBlock) block;
    - (NSObject *) max:(CompareArrayBlock) block;
    - (NSObject *) min:(CompareArrayBlock) block;
    - (NSArray *) sort:(NSComparator) block;
    - (NSDictionary *) group:(MapArrayBlock) block;

    - (NSObject *) first;
    + (NSArray *) arrayFrom:(NSInteger) from To:(NSInteger) to;
@end
