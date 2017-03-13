//
//  ExamplePrivate.h
//  ObjCSumType
//
//  Created by Borders, Heath on 3/13/17.
//  Copyright © 2017 Heath Borders. All rights reserved.
//

// https://gist.github.com/hborders/12fcbe34cf4de68c2317bad92a8e223d

#import "Example.h"

@interface Example ()
- (instancetype _Nonnull)initPrivate NS_DESIGNATED_INITIALIZER;
@end

@interface ExampleFoo()
- (instancetype _Nonnull)initPrivate NS_UNAVAILABLE;
@end

@interface ExampleBar()
- (instancetype _Nonnull)initPrivate NS_UNAVAILABLE;
@end
