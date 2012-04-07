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
    - (void) each:(EachArrayBlock) block;
    - (NSArray *) map:(MapArrayBlock) block;
    - (NSObject *) reduce:(ReduceArrayBlock) block withInitialMemo:(NSObject *) memo;

    - (NSArray *) filter:(FilterArrayBlock) block;
@end
