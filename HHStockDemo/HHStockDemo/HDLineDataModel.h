//
//  HDLineDataModel.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "HHDataModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HDLineDataModel : NSObject<HHDataModelProtocol>

- (void)updateMA:(NSArray *)parentDictArray index:(NSInteger)index;
 
@property (nonatomic, strong) id<HHDataModelProtocol> preDataModel;
@end

NS_ASSUME_NONNULL_END
