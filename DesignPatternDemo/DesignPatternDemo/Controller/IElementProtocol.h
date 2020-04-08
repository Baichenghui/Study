//
//  IElementProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "IVisitorProtocol.h"

@protocol IElementProtocol <NSObject>

- (void)accept:(id<IVisitorProtocol>) visitor;

@end
