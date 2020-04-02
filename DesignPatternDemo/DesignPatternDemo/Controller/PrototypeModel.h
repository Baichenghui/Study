//
//  PrototypeModel.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPrototypeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrototypeModel : NSObject<NSCopying,IPrototypeProtocol>
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,copy) NSString *hobby;
@end

NS_ASSUME_NONNULL_END
