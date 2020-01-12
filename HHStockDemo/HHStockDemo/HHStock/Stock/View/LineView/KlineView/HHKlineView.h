//
//  HHKlineView.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHDataModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHKlineView : UIView

- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition
                        drawModels:(NSMutableArray <id<HHDataModelProtocol>>*)drawLineModels
                          maxValue:(CGFloat)maxValue
                          minValue:(CGFloat)minValue;

@end

NS_ASSUME_NONNULL_END
