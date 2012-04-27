#Functional.m

Functional.m is an extension for objective-c, that can be used to do functional programming.

Here's the documentation for the individual functions:

The numberArray NSArray contains a collection of NSNumbers, The dict NSDictionary contains the same collection - the keys are the names of the numbers

```objc
    NSArray *numberArray = [NSArray arrayFrom:1 To:5];
    NSArray *numberNamesArray = [NSArray arrayWithObjects:@"one", @"two", @"three", @"four", @"five", nil];
    NSDictionary *numberDict = [NSDictionary dictionaryWithObjects:numberArray forKeys:numberNamesArray];
```

##each

The given iterator runs for each object in the collection.

- `- (void) each:(VoidIteratorArrayBlock) block;`
- `- (void) each:(VoidIteratorDictBlock) block;`

Example:

```objc
    [numberArray each:^(id obj) {
        NSLog(@"Current Object : %@", obj);
    }];
    
    [numberDict each:^(id key, id value) {
        NSLog(@"%@ => %@", key, value);
    }];
```

##map

Each object in the collection can be transformed in the iterator.

- `- (NSArray *) map:(MapArrayBlock) block;`
- `- (NSDictionary *) map:(MapDictBlock) block;`

Example:

```objc
    NSArray *doubleArray = [numberArray map:^NSNumber*(NSNumber *obj) {
        return [NSNumber numberWithInt:([obj intValue]*2)];
    }];
    NSDictionary *doubleDict = [numberDict map:^NSNumber*(id key, NSNumber *obj) {
        return [NSNumber numberWithInt:([obj intValue]*2)];
    }];
    
    NSLog(@"Double : Array %@ - Dict %@", doubleArray, doubleDict);
```

##reduce

Reduces all objects in the collection to a single value (something like computing the average etc.)

- `- (id) reduce:(ReduceArrayBlock) block withInitialMemo:(id) memo;`
- `- (id) reduce:(ReduceDictBlock) block withInitialMemo:(id) memo;`

Example - adds all NSNumbers in the array or dictionary.

```objc 
    NSNumber *memo = [NSNumber numberWithInt:0];
    
    NSNumber *sumArray = [numberArray reduce:^NSNumber*(NSNumber *memo, NSNumber *cur) {
        return [NSNumber numberWithInt:([memo intValue] + [cur intValue])];
    } withInitialMemo:memo];
    
    NSNumber *sumDict = [numberDict reduce:^NSNumber*(NSNumber *memo, id key, NSNumber *cur) {
        return [NSNumber numberWithInt:([memo intValue] + [cur intValue])];
    } withInitialMemo:memo];
    
    NSLog(@"Sum : Array %@ - Dict %@", sumArray, sumDict);
```

##filter and reject

`Filter` gives you only those objects, for that the iterator returns true. `Reject` removes all objects for that the iterator returns true.

- `- (NSArray *) filter:(BoolArrayBlock) block;`
- `- (NSArray *) reject:(BoolArrayBlock) block;`

- `- (NSDictionary*) filter:(BoolDictionaryBlock) block;`
- `- (NSDictionary*) reject:(BoolDictionaryBlock) block;`

This example gives you all even (filter) or odd (reject) numbers in the array / dict:

```objc
        BoolArrayBlock isEvenArrayBlock = ^BOOL(NSNumber *obj) {
            return (([obj intValue] % 2) == 0);
        };
        BoolDictionaryBlock isEvenDictBlock = ^BOOL(id key, NSNumber *obj) {
            return (([obj intValue] % 2) == 0);
        };
    
        NSArray *evenArr    = [numberArray filter:isEvenArrayBlock];
        NSDictionary *evenDict   = [numberDict filter:isEvenDictBlock];
        NSLog(@"The following elements are even : Array %@ - Dict %@", evenArr, evenDict);
    
    #pragma mark - reject
        NSArray *oddArr = [numberArray reject:isEvenArrayBlock];
        NSDictionary *oddDict = [numberDict reject:isEvenDictBlock];
        NSLog(@"The following elements are odd : Array %@ - Dict %@", oddArr, oddDict);   
```

##isValidForAll and isValidForAny

`isValidForAll` returns YES if the iterator returns YES for all elements in the collection. `isValidForAny` returns YES if the iterator returns YES for at least one object in the collection.

- `- (BOOL) isValidForAll:(BoolArrayBlock) block;`
- `- (BOOL) isValidForAny:(BoolArrayBlock) block;`

- `- (BOOL) isValidForAll:(BoolDictionaryBlock) block;`
- `- (BOOL) isValidForAny:(BoolDictionaryBlock) block;`

This example checks if all or any elements in the collection are even numbers

```objc
    BoolArrayBlock isEvenArrayBlock = ^BOOL(NSNumber *obj) {
        return (([obj intValue] % 2) == 0);
    };
    BoolDictionaryBlock isEvenDictBlock = ^BOOL(id key, NSNumber *obj) {
        return (([obj intValue] % 2) == 0);
    };

    NSLog(@"Only even numbers : Array %d - Dict %d", [numberArray isValidForAll:isEvenArrayBlock], [numberDict isValidForAll:isEvenDictBlock]);
    # pragma mark - isValidForAny
    NSLog(@"Any even numbers : Array %d - Dict %d", [numberArray isValidForAny:isEvenArrayBlock], [numberDict isValidForAny:isEvenDictBlock]);

```
##countValidEntries

Counts the number of entries in a set, for which the given block returns true:

- `- (NSNumber *) countValidEntries:(BoolArrayBlock) block;`
- `- (NSNumber *) countValidEntries:(BoolDictionaryBlock) block;`

```objc
    BoolArrayBlock isEvenArrayBlock = ^BOOL(NSNumber *obj) {
        return (([obj intValue] % 2) == 0);
    };
    BoolDictionaryBlock isEvenDictBlock = ^BOOL(id key, NSNumber *obj) {
        return (([obj intValue] % 2) == 0);
    };

    NSNumber *ctEvenArr     = [numberArray countValidEntries:isEvenArrayBlock];
    NSNumber *ctEvenDict    = [numberDict countValidEntries:isEvenDictBlock];
    NSLog(@"The number of even elements are : Array %@ - Dict %@", ctEvenArr, ctEvenDict);
```

##dropWhile

Drops every entry before the first item the block returns true for.

- `- (NSArray *) dropWhile:(BoolArrayBlock) block;`

```objc
	NSArray *droppedUntilThree = [numberArray dropWhile:^BOOL(NSNumber *nr) {
	    return ([nr integerValue] < 3);
	}];
	NSLog(@"Array from 3 : %@", droppedUntilThree);
```

##max and min

Return the maximum and the minimum values in a collection. You will have to write a comperator, which compares two elements.

- `- (id) max:(CompareArrayBlock) block;`
- `- (id) min:(CompareArrayBlock) block;`

- `- (id) max:(CompareDictBlock) block;`
- `- (id) min:(CompareDictBlock) block;`

Here's an example that gets the minimum and the maximum value from the array and dict described above:

```objc
        CompareArrayBlock compareArrBlock = ^NSComparisonResult(NSNumber *a, NSNumber *b) {
            return [a compare:b];
        };
    
        CompareDictBlock compareDictBlock = ^NSComparisonResult(id k1, NSNumber *v1, id k2, NSNumber *v2) {
            return [v1 compare:v2];
        };
    
        NSNumber *maxArr    = [numberArray max:compareArrBlock];
        NSNumber *maxDict   = [numberDict max:compareDictBlock];
        NSLog(@"Max : Array %@ - Dict %@", maxArr, maxDict);
    
    #pragma mark - min
        NSNumber *minArr    = [numberArray min:compareArrBlock];
        NSNumber *minDict   = [numberDict min:compareDictBlock];
        NSLog(@"Min : Array %@ - Dict %@", minArr, minDict);
```

##sort

Sort is actually just an alias for `[self sortedArrayUsingComparator:block];`

- `- (NSArray *) sort:(NSComparator) block;`

See [NSArray sortedArrayUsingComperator:](http://developer.apple.com/library/ios/DOCUMENTATION/Cocoa/Reference/Foundation/Classes/NSArray_Class/NSArray.html#//apple_ref/occ/instm/NSArray/sortedArrayUsingComparator:) for reference.

Here's an example:

```objc
    NSComperator compareArrBlock = ^NSComparisonResult(NSNumber *a, NSNumber *b) {
        return [a compare:b];
    };

    NSArray *nrReversed = [numberArray reverse];
    NSArray *sorted     = [nrReversed sort:compareArrBlock];
    NSLog(@"%@ becomes %@ when sorted", nrReversed, sorted);
```

##group

Groups an array by the values returned by the iterator.

- `- (NSDictionary *) group:(MapArrayBlock) block;`

Here's an example that groups an array into an odd numbers section and an even numbers section:

```objc
	NSDictionary *oddEvenArray = [numberArray group:^NSString *(NSNumber *obj) {
        if (([obj intValue] % 2) == 0) return @"even";
        else return @"odd";
    }];
	NSLog(@"Grouped array %@", oddEvenArray);
```

##times

Call times on an `NSNumber` (n) to iterate n times over the given block.

- `- (void) times:(VoidBlock) block;`

Here's a simple example - it prints 'have i told you' once:

```objc
    NSNumber *howMany   = [numberArray first];
    [howMany times:^{
        NSLog(@"have i told you?");
    }];
```

##NSArray additions

###arrayFrom:To:

Creates an array, that contains the range as individual NSNumbers

- `+ (NSArray *) arrayFrom:(NSInteger) from To:(NSInteger) to;`

Example:

```objc
	NSArray *rArr = [NSArray arrayFrom:0 To:3];
    NSLog(@"Array from 0 to 3 %@", rArr);
```

###first

- `- (id) first;`

Just a shortcut for `[array objectAtIndex:0]`;

###reverse

- `- (NSArray *) reverse;`

Returns the reversed array

###arrayUntilIndex and arrayFromIndexOn

These are helper functions. They return the elements of the array they are called on until (excluding) the given index or from the given index on (including).

- `- (NSArray *) arrayUntilIndex:(NSInteger) idx;`
- `- (NSArray *) arrayFromIndexOn:(NSInteger) idx;`

```objc
	NSArray *untilTwo = [numberArray arrayUntilIndex:2];
	NSArray *afterTwo = [numberArray arrayFromIndexOn:2];
	NSLog(@"The array until idx 2 : %@ and thereafter : %@", untilTwo, afterTwo); // 1,2 and 3,4,5
```