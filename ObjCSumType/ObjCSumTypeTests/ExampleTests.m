//
//  ExampleTests.m
//  ObjCSumType
//
//  Created by Borders, Heath on 3/13/17.
//  Copyright © 2017 Heath Borders. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Example.h"

@interface ExampleTests : XCTestCase

@end

@implementation ExampleTests

// https://gist.github.com/hborders/02b12ba1059946409bdaa555c1441520

static void printExample(Example * _Nonnull example) {
    [example switchFoo:^(ExampleFoo * _Nonnull foo_) {
        NSLog(@"Foo: %@, %@", foo_.f, foo_.g);
    }
                   bar:^(ExampleBar * _Nonnull bar_) {
                       NSLog(@"Bar: %@, %@", @(bar_.b), @(bar_.c));
                   }];
}

- (void)testPrintExample {
    Example * _Nonnull fooExample = [[ExampleFoo alloc] initWithF:@"foo"
                                                                g:@"goo"];
    Example * _Nonnull barExample = [[ExampleBar alloc] initWithB:2
                                                                c:3];
    
    printExample(fooExample); // Foo: foo, goo
    printExample(barExample); // Bar: 2, 3
}

// https://gist.github.com/hborders/92515b39d6a287e9cdb2331303b74fd3

static NSNumber * _Nonnull transformExample(Example * _Nonnull example) {
    return [ExampleSwitcher<NSNumber *> nonnullValueFrom:example
                                               switchFoo:^NSNumber * _Nonnull (ExampleFoo * _Nonnull foo_) {
                                                   return @(foo_.f.length + foo_.g.length);
                                               }
                                                     bar:^NSNumber * _Nonnull (ExampleBar * _Nonnull bar_) {
                                                         return @(bar_.b + bar_.c);
                                                     }];
}

- (void)testTransformExample {
    Example * _Nonnull fooExample = [[ExampleFoo alloc] initWithF:@"foo"
                                                                g:@"goo"];
    Example * _Nonnull barExample = [[ExampleBar alloc] initWithB:2
                                                                c:3];
    
    NSLog(@"transformed Foo: %@", transformExample(fooExample)); // transformed Foo: 6
    NSLog(@"transformed Bar: %@", transformExample(barExample)); // transformed Bar: 5
}

@end
