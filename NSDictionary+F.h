//
//  NSDictionary+F.h
//  Functional
//
//  Created by Hannes Walz on 07.04.12.
//  Copyright 2012 leuchtetgruen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F.h"

@interface NSDictionary(F)
    - (void) each:(EachDictBlock) block;
    - (NSDictionary *) map:(MapDictBlock) block;
    - (NSObject *) reduce:(ReduceDictBlock) block withInitialMemo:(NSObject *) memo;

    - (NSDictionary*) filter:(FilterDictionaryBlock) block;

@end
