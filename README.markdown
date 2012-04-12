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