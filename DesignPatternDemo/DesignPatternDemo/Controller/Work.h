//
//  Work.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IStateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Work : NSObject
@property (nonatomic,strong) id<IStateProtocol> currentState; 
@property (nonatomic,assign) NSInteger hours;
@property (nonatomic,assign) BOOL isCompeleted;

- (void)doWork;
@end

NS_ASSUME_NONNULL_END
