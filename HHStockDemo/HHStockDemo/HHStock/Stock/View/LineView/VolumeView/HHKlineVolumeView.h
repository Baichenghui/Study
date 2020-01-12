//
//  HHKlineVolumeView.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HHDataModelProtocol.h"
#import "HHLinePositionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHKlineVolumeView : UIView
@property (nonatomic, weak) UIScrollView *parentScrollView;

- (void)drawViewWithXPosition:(CGFloat)xPosition
                   drawModels:(NSArray <id<HHDataModelProtocol>>*)drawLineModels
           linePositionModels:(NSArray <HHLinePositionModel *>*)linePositionModels;
@end

NS_ASSUME_NONNULL_END
