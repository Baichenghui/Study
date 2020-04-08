//
//  IVisitorProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

@class ElementA;
@class ElementB;

@protocol IVisitorProtocol <NSObject>

- (void)visitorElementA:(ElementA *)elementA;
- (void)visitorElementB:(ElementB *)elementB;

@end
