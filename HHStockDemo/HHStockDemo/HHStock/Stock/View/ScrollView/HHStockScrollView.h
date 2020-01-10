//
//  HHStockScrollView.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHStockConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHStockScrollView : UIScrollView

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) HHStockType stockType;

@property (nonatomic, assign) BOOL isShowBgLine;

@end

NS_ASSUME_NONNULL_END
