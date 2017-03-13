//
//  Example.h
//  ObjCSumType
//
//  Created by Borders, Heath on 3/13/17.
//  Copyright © 2017 Heath Borders. All rights reserved.
//

#import <Foundation/Foundation.h>

// https://gist.github.com/hborders/2af9b39e27b62ef9e68c65085126fe4a

@class ExampleFoo;
@class ExampleBar;

@interface Example : NSObject
// notice there is no public designated initializer, so consumers can't instantiate Example directly.
// They must instantiate a subclass.
+ (instancetype _Nonnull)new NS_UNAVAILABLE;
- (instancetype _Nonnull)init NS_UNAVAILABLE;

// Consumers will use this method to unpack the sum type
- (void)switchFoo:(void (^ _Nonnull)(ExampleFoo * _Nonnull foo_))fooBlock
              bar:(void (^ _Nonnull)(ExampleBar * _Nonnull bar_))barBlock NS_REQUIRES_SUPER;
@end

// https://gist.github.com/hborders/2af9b39e27b62ef9e68c65085126fe4a

@interface ExampleSwitcher<ReturnType : NSObject *> : NSObject
+ (instancetype _Nonnull)new NS_UNAVAILABLE;
- (instancetype _Nonnull)init NS_UNAVAILABLE;

+ (ReturnType _Nonnull)nonnullValueFrom:(Example * _Nonnull)example
switchFoo:(ReturnType _Nonnull (^ _Nonnull)(ExampleFoo * _Nonnull foo_))fooBlock
bar:(ReturnType _Nonnull (^ _Nonnull)(ExampleBar * _Nonnull bar_))barBlock;
+ (ReturnType _Nullable)nullableValueFrom:(Example * _Nonnull)example
switchFoo:(ReturnType _Nullable (^ _Nonnull)(ExampleFoo * _Nonnull foo_))fooBlock
bar:(ReturnType _Nullable (^ _Nonnull)(ExampleBar * _Nonnull bar_))barBlock;
@end

// https://gist.github.com/hborders/2af9b39e27b62ef9e68c65085126fe4a

@interface ExampleFoo : Example
@property (nonatomic, readonly) NSString * _Nonnull f;
@property (nonatomic, readonly) NSString * _Nonnull g;

+ (instancetype _Nonnull)new NS_UNAVAILABLE;
- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithF:(NSString * _Nonnull)f
                                 g:(NSString * _Nonnull)g NS_DESIGNATED_INITIALIZER;
@end

// https://gist.github.com/hborders/2af9b39e27b62ef9e68c65085126fe4a

@interface ExampleBar : Example
@property (nonatomic, readonly) NSInteger b;
@property (nonatomic, readonly) NSInteger c;

+ (instancetype _Nonnull)new NS_UNAVAILABLE;
- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithB:(NSInteger)b
                                 c:(NSInteger)c NS_DESIGNATED_INITIALIZER;
@end
