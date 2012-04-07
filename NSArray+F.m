//
//  NSArray+F.m
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import "NSArray+F.h"

@implementation NSArray(F)

- (void) each:(EachArrayBlock) block {
    [F eachInArray:self withBlock:block];
}

- (NSArray *) map:(MapArrayBlock) block {
    return [F mapArray:self withBlock:block];
}

- (NSObject *) reduce:(ReduceArrayBlock) block withInitialMemo:(NSObject *) memo {
    return [F reduceArray:self withBlock:block andInitialMemo:memo];
}

- (NSArray *) filter:(FilterArrayBlock) block {
    return [F filterArray:self withBlock:block];
}
@end
