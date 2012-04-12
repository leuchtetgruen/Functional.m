#Functional.m

Functional.m is an extension for objective-c, that can be used to do functional programming.

Here's the documentation for the individual functions:

The arr NSArray contains a collection of NSNumbers, The dict NSDictionary contains the same collection - the keys are the names of the numbers

##each

The given iterator runs for each object in the collection.

- `- (void) each:(VoidIteratorArrayBlock) block;`
- `- (void) each:(VoidIteratorDictBlock) block;`

Example:

```objc
	// Array each
    [arr each:^(NSObject *obj) {
        NSLog(@"Object %@", obj);
    }];
    
    // Dict each
    [dict each:^(NSObject *key, NSObject *value) {
        NSLog(@"Key %@ Val %@", key, value);
    }];
```

##map

Each object in the collection can be transformed in the iterator.

- `- (NSArray *) map:(MapArrayBlock) block;`
- `- (NSDictionary *) map:(MapDictBlock) block;`

Example:

```objc
	// Map array
    NSArray *doubleArr = [arr map:^NSObject *(NSObject *obj) {
        return [NSNumber numberWithInt:([((NSNumber *) obj) intValue] * 2)];
    }];
    NSLog(@"The Double array is : %@", doubleArr);
    
    // Map dict
    NSDictionary *doubleDict = [dict map:^NSObject *(NSObject *key, NSObject *obj) {
        return [NSNumber numberWithInt:([((NSNumber *) obj) intValue] * 2)];
    }];
    NSLog(@"Double Dict %@", doubleDict);
```

##reduce

Reduces all objects in the collection to a single value (something like computing the average etc.)

- `- (NSObject *) reduce:(ReduceArrayBlock) block withInitialMemo:(NSObject *) memo;`
- `- (NSObject *) reduce:(ReduceDictBlock) block withInitialMemo:(NSObject *) memo;`

Example - adds all NSNumbers in the array or dictionary.

```objc 
	//Array reduce
    NSNumber *memo = [NSNumber numberWithInt:0];
    NSNumber *reducedArr = (NSNumber *) [arr reduce:^NSObject *(NSObject *memo, NSObject *obj) {
        return [NSNumber numberWithInt:([((NSNumber *) memo) intValue]) + ([((NSNumber *) obj) intValue])];
    } withInitialMemo:memo];
    
    NSLog(@"Reduced Array : %@", reducedArr);
    
    //Dict reduce
    NSNumber *reducedDict = (NSNumber *) [dict reduce:^NSObject *(NSObject *memo, NSObject *key, NSObject *value) {
        return [NSNumber numberWithInt:([((NSNumber *) memo) intValue]) + ([((NSNumber *) value) intValue])];
    } withInitialMemo:memo];
    NSLog(@"Reduced Dict : %@", reducedDict);
```

##filter and reject

`Filter` gives you only those objects, for that the iterator returns true. `Reject` removes all objects for that the iterator returns true.

- `- (NSArray *) filter:(BoolArrayBlock) block;`
- `- (NSArray *) reject:(BoolArrayBlock) block;`

- `- (NSDictionary*) filter:(BoolDictionaryBlock) block;`
- `- (NSDictionary*) reject:(BoolDictionaryBlock) block;`

This example gives you all even (filter) or odd (reject) numbers in the array / dict:

```objc
	BoolArrayBlock isEvenArrayBlock = ^BOOL (NSObject *obj) {
        return (([((NSNumber *) obj) intValue] % 2) == 0);
    };
    NSArray *filteredArr = [arr filter:isEvenArrayBlock];
    NSArray *rejectedArr = [arr reject:isEvenArrayBlock];
    
    NSLog(@"Filter(Array) returned %@", filteredArr);
    NSLog(@"Array with only odd numbers %@", rejectedArr);


    BoolDictionaryBlock isEvenDictBlock = ^BOOL (NSObject *key, NSObject *value) {
        return (([((NSNumber *) value) intValue] % 2) == 0);
    };
    
    NSDictionary *filteredDict = [dict filter:isEvenDictBlock];
    NSDictionary *rejectedDict = [dict reject:isEvenDictBlock];

    NSLog(@"Filter(Dictionary) returned %@", filteredDict);
    NSLog(@"Reject(Dictionary) returned %@", rejectedDict);    
```

##isValidForAll and isValidForAny

`isValidForAll` returns YES if the iterator returns YES for all elements in the collection. `isValidForAny` returns YES if the iterator returns YES for at least one object in the collection.

- `- (BOOL) isValidForAll:(BoolArrayBlock) block;`
- `- (BOOL) isValidForAny:(BoolArrayBlock) block;`

- `- (BOOL) isValidForAll:(BoolDictionaryBlock) block;`
- `- (BOOL) isValidForAny:(BoolDictionaryBlock) block;`

This example checks if all or any elements in the collection are even numbers

```objc
	BoolArrayBlock isEvenArrayBlock = ^BOOL (NSObject *obj) {
        return (([((NSNumber *) obj) intValue] % 2) == 0);
    };
    BOOL allEvenInArray = [arr isValidForAll:isEvenArrayBlock];    
    BOOL someEvenInArray = [arr isValidForAny:isEvenArrayBlock];
    NSLog(@"Only even numbers in array : %d - some even numbers in array %d", allEvenInArray, someEvenInArray);


    BoolDictionaryBlock isEvenDictBlock = ^BOOL (NSObject *key, NSObject *value) {
        return (([((NSNumber *) value) intValue] % 2) == 0);
    };
    BOOL allEvenInDictionary = [dict isValidForAll:isEvenDictBlock];    
    BOOL someEvenInDictionary = [dict isValidForAny:isEvenDictBlock];
    NSLog(@"Only even numbers in dictionary : %d - some even numbers in dictionary %d", allEvenInDictionary, someEvenInDictionary);

```

##max and min

Return the maximum and the minimum values in a collection. You will have to write a comperator, which compares two elements.

- `- (NSObject *) max:(CompareArrayBlock) block;`
- `- (NSObject *) min:(CompareArrayBlock) block;`

- `- (NSObject *) max:(CompareDictBlock) block;`
- `- (NSObject *) min:(CompareDictBlock) block;`

Here's an example that gets the minimum and the maximum value from the array and dict described above:

```objc
    CompareArrayBlock arrCompare = ^NSComparisonResult(NSObject *a, NSObject *b) {
        return [(NSNumber *) a compare:(NSNumber *) b];
    };
    
    CompareDictBlock dictCompare = ^NSComparisonResult(NSObject *k1, NSObject *v1, NSObject *k2, NSObject *v2) {
        return [(NSNumber *) v1 compare:(NSNumber *) v2];
    };
    
    NSNumber *maxInArray = (NSNumber *) [arr max:arrCompare];
    NSNumber *minInArray = (NSNumber *) [arr min:arrCompare];
    
    NSNumber *maxInDict = (NSNumber *) [dict max:dictCompare];
    NSNumber *minInDict = (NSNumber *) [dict min:dictCompare];
    
    NSLog(@"Max in Array %@ - Min %@", maxInArray, minInArray);
    NSLog(@"Max in Dict %@ - Min %@", maxInDict, minInDict);
```

##sort

Sort is actually just an alias for `[self sortedArrayUsingComparator:block];`

- `- (NSArray *) sort:(NSComparator) block;`

See [NSArray sortedArrayUsingComperator:](http://developer.apple.com/library/ios/DOCUMENTATION/Cocoa/Reference/Foundation/Classes/NSArray_Class/NSArray.html#//apple_ref/occ/instm/NSArray/sortedArrayUsingComparator:) for reference.

##group

Groups an array by the values returned by the iterator.

- `- (NSDictionary *) group:(MapArrayBlock) block;`

Here's an example that groups an array into an odd numbers section and an even numbers section:

```objc
	NSDictionary *oddEvenArray = [arr group:^NSObject *(NSObject *obj) {
        if (([(NSNumber *) obj intValue] % 2) == 0) return @"even";
        else return @"odd";
    }];
	NSLog(@"Grouped array %@", oddEvenArray);
```

##times

Call times on an `NSNumber` (n) to iterate n times over the given block.

- `- (void) times:(VoidBlock) block;`

Here's a simple example:

```objc
	[[NSNumber numberWithInt:5] times:^{
        NSLog(@"I do this 5 times");
    }];
```