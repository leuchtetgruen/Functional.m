#Functional.m

Functional.m is an extension for objective-c, that can be used to do functional programming.

Here's the documentation for the individual functions:



##each

- `- (void) each:(VoidIteratorArrayBlock) block;`
- `- (void) each:(VoidIteratorDictBlock) block;`

```objc
	// Array each
    [arr each:^(NSObject *obj) {
        NSLog(@"Object %@", obj);
    }];
    
    // Dict each
    [dict each:^(NSObject *__strong key, NSObject *__strong value) {
        NSLog(@"Key %@ Val %@", key, value);
    }];
```