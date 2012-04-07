//
//  NSDictionary+F.m
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import "NSDictionary+F.h"

@implementation NSDictionary(F)

- (void) each:(EachDictBlock) block {
    [F eachInDict:self withBlock:block];
}

- (NSDictionary *) map:(MapDictBlock) block {
    return [F mapDict:self withBlock:block];
}

- (NSObject *) reduce:(ReduceDictBlock) block withInitialMemo:(NSObject *) memo {
    return [F reduceDictionary:self withBlock:block andInitialMemo:memo];
}

- filter:(FilterDictionaryBlock) block {
    return [F filterDictionary:self withBlock:block];
}
@end
