//
//  Director.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDateBuilderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuilderDirector : NSObject
 
- (void)builderWithbuilder:(id<IDateBuilderProtocol>)builder;

@end

NS_ASSUME_NONNULL_END
