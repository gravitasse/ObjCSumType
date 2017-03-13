//
//  Example.m
//  ObjCSumType
//
//  Created by Borders, Heath on 3/13/17.
//  Copyright © 2017 Heath Borders. All rights reserved.
//

// https://gist.github.com/hborders/c58b26ee0acb30c9a8bc74a5fd591284

#import "ExamplePrivate.h"

@implementation Example
- (instancetype _Nonnull)initPrivate {
    return [super init];
}
- (void)switchFoo:(void (^ _Nonnull)(ExampleFoo * _Nonnull foo_))fooBlock
              bar:(void (^ _Nonnull)(ExampleBar * _Nonnull bar_))barBlock {
    // Subclasses must implement and call
}
@end

// https://gist.github.com/hborders/6dcd08ce0a744d3a691461ce1fd9a8d2

@implementation ExampleSwitcher
+ (NSObject * _Nonnull)nonnullValueFrom:(Example * _Nonnull)example
                              switchFoo:(NSObject * _Nonnull (^ _Nonnull)(ExampleFoo * _Nonnull foo_))fooBlock
                                    bar:(NSObject * _Nonnull (^ _Nonnull)(ExampleBar * _Nonnull bar_))barBlock {
    NSParameterAssert(example);
    NSParameterAssert(fooBlock);
    NSParameterAssert(barBlock);
    
    // Unfortunately, we still have this local block assignment,
    // but at least it's only in one spot. All other code will
    // be verified correct by the compiler.
    NSObject * _Nullable __block maybeValue;
    [example switchFoo:^(ExampleFoo * _Nonnull foo_) {
        maybeValue = fooBlock(foo_);
    }
                   bar:^(ExampleBar * _Nonnull bar_) {
                       maybeValue = barBlock(bar_);
                   }];
    assert(maybeValue);
    return (NSObject * _Nonnull) maybeValue;
}

+ (NSObject * _Nullable)nullableValueFrom:(Example * _Nonnull)example
                                switchFoo:(NSObject * _Nullable (^ _Nonnull)(ExampleFoo * _Nonnull foo_))fooBlock
                                      bar:(NSObject * _Nullable (^ _Nonnull)(ExampleBar * _Nonnull bar_))barBlock {
    NSParameterAssert(example);
    NSParameterAssert(fooBlock);
    NSParameterAssert(barBlock);
    
    // Unfortunately, we still have this local block assignment,
    // but at least it's only in one spot. All other code will
    // be verified correct by the compiler.
    NSObject * _Nullable __block maybeValue;
    [example switchFoo:^(ExampleFoo * _Nonnull foo_) {
        maybeValue = fooBlock(foo_);
    }
                   bar:^(ExampleBar * _Nonnull bar_) {
                       maybeValue = barBlock(bar_);
                   }];
    return maybeValue;
}
@end

// https://gist.github.com/hborders/06af193c6f44788fa3bb5d84c8818cc0

@implementation ExampleFoo
- (instancetype _Nonnull)initPrivate {
    NSLog(@"Unavailable");
    abort();
}
- (instancetype _Nonnull)initWithF:(NSString * _Nonnull)f
                                 g:(NSString * _Nonnull)g {
    NSParameterAssert(f);
    NSParameterAssert(g);
    self = [super initPrivate];
    if (self) {
        _f = f;
        _g = g;
    }
    return self;
}
- (void)switchFoo:(void (^ _Nonnull)(ExampleFoo * _Nonnull foo_))fooBlock
              bar:(void (^ _Nonnull)(ExampleBar * _Nonnull bar_))barBlock {
    NSParameterAssert(fooBlock);
    NSParameterAssert(barBlock);
    [super switchFoo:fooBlock
                 bar:barBlock];
    fooBlock(self);
}
@end

// https://gist.github.com/hborders/4dd32a239e572666787793607d6c1b78

@implementation ExampleBar
- (instancetype _Nonnull)initPrivate {
    NSLog(@"Unavailable");
    abort();
}
- (instancetype _Nonnull)initWithB:(NSInteger)b
                                 c:(NSInteger)c {
    self = [super initPrivate];
    if (self) {
        _b = b;
        _c = c;
    }
    return self;
}

- (void)switchFoo:(void (^ _Nonnull)(ExampleFoo * _Nonnull foo_))fooBlock
              bar:(void (^ _Nonnull)(ExampleBar * _Nonnull bar_))barBlock {
    NSParameterAssert(fooBlock);
    NSParameterAssert(barBlock);
    [super switchFoo:fooBlock
                 bar:barBlock];
    barBlock(self);
}
@end
