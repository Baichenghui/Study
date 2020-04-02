//
//  SqlserverUser.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

//类比Dao的实现层

#import <Foundation/Foundation.h>
#import "IUserProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SqlserverUser : NSObject<IUserProtocol>

@end

NS_ASSUME_NONNULL_END
