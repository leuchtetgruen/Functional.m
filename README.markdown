#Functional.m

Functional.m is an extension for objective-c, that can be used to do functional programming.

```objc
	// Filter -> Array
	NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4], nil];


	NSArray *filteredArr = [arr filter:^BOOL (NSObject *obj) {
	    return (([((NSNumber *) obj) intValue] % 2) == 0);
	}];

	NSLog(@"Filter(Array) returned %@", filteredArr);

	// Filter Dictionary
	NSDictionary *dict = [NSDictionary dictionaryWithObjects:arr forKeys:[NSArray arrayWithObjects:@"one", @"two", @"three", @"four", nil]];

	NSDictionary *filteredDict = [dict filter:^BOOL (NSString *key, NSObject *val) {
	    return (([((NSNumber *) val) intValue] % 2) == 0);
	}];
	NSLog(@"Filter(Dictionary) returned %@", filteredDict);

	// Array each
	[arr each:^(NSObject *__strong obj) {
	    NSLog(@"Object %@", obj);
	}];

	// Dict each
	[dict each:^(NSString *__strong key, NSObject *__strong value) {
	    NSLog(@"Key %@ Val %@", key, value);
	}];

	// Map array
	NSArray *doubleArr = [arr map:^NSObject *(NSObject *__strong obj) {
	    return [NSNumber numberWithInt:([((NSNumber *) obj) intValue] * 2)];
	}];
	NSLog(@"The Double array is : %@", doubleArr);

	// Map dict
	NSDictionary *doubleDict = [dict map:^NSObject *(NSString *__strong key, NSObject *__strong obj) {
	    return [NSNumber numberWithInt:([((NSNumber *) obj) intValue] * 2)];
	}];
	NSLog(@"Double Dict %@", doubleDict);

	//Array reduce
	NSNumber *memo = [NSNumber numberWithInt:0];
	NSNumber *reducedArr = (NSNumber *) [arr reduce:^NSObject *(NSObject *__strong memo, NSObject *__strong obj) {
	    return [NSNumber numberWithInt:([((NSNumber *) memo) intValue]) + ([((NSNumber *) obj) intValue])];
	} withInitialMemo:memo];

	NSLog(@"Reduced Array : %@", reducedArr);

	//Dict reduce
	NSNumber *reducedDict = (NSNumber *) [dict reduce:^NSObject *(NSObject *__strong memo, NSString *__strong key, NSObject *__strong value) {
	    return [NSNumber numberWithInt:([((NSNumber *) memo) intValue]) + ([((NSNumber *) value) intValue])];
	} withInitialMemo:memo];
	NSLog(@"Reduced Dict : %@", reducedDict);
```