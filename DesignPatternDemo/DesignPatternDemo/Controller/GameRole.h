//
//  GameRole.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameMemeno.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameRole : NSObject

@property (nonatomic,copy) NSString *value;

- (GameMemeno *)saveState;
- (void)recovery:(GameMemeno *)memeno;

@end

NS_ASSUME_NONNULL_END
