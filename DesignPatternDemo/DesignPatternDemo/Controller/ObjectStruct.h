//
//  ObjectStruct.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IElementProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObjectStruct : NSObject

@property (nonatomic,strong)NSMutableArray <id<IElementProtocol>> *list;

- (void)accept:(id<IVisitorProtocol>)visitor;

@end

NS_ASSUME_NONNULL_END
