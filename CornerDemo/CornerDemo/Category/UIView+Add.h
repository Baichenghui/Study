//
//  UIView+Add.h
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//
 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Add)

//注意：存在一个问题，当多次调用该方法时会添加多次圆角，也就是调用一次就会添加一个layer.可使用自定义的CornerView实现方案
- (void)cc_addRounderCornerWithRadius:(CGFloat)radius
                                 size:(CGSize)size
                              corners:(UIRectCorner)corner;
 
@end

NS_ASSUME_NONNULL_END
