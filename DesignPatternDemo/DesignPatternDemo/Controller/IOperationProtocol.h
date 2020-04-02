//
//  ICalculateProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

@protocol IOperationProtocol <NSObject>

@property (nonatomic,assign) CGFloat numA;
@property (nonatomic,assign) CGFloat numB;

- (CGFloat)getResult;

@end
