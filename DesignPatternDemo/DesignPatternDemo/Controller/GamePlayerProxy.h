//
//  GamePlayerProxy.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGamePlayerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface GamePlayerProxy : NSObject<IGamePlayerProtocol> 
 @property (nonatomic,weak) id<IGamePlayerProtocol> delegate;
@end

NS_ASSUME_NONNULL_END
