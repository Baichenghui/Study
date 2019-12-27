//
//  UIImageView+Add.h
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//
 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Add)

/// 非常不推荐使用 ，会造成离屏渲染
- (UIImageView *)cc_roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius
                                                 corners:(UIRectCorner)corners;


#pragma mark - Network image

- (void)cc_setImageWithURLString:(NSString *)urlString
                           placeholder:(nullable UIImage *)image
                             fillColor:(nullable UIColor *)color;

- (void)cc_setImageWithURLString:(NSString *)urlString
                           placeholder:(nullable UIImage *)image;

- (void)cc_setImageWithURLString:(NSString *)urlString
                              placeholder:(nullable UIImage*)image
                                fillColor:(nullable UIColor *)color
                             cornerRadius:(CGFloat) cornerRadius;


- (void)cc_setImageWithURLString:(NSString *)urlString
                              placeholder:(nullable UIImage *)image
                             cornerRadius:(CGFloat) cornerRadius;

- (void)cc_setImageWithURLString:(NSString *)urlString
                           placeholder:(nullable UIImage *)image
                             fillColor:(nullable UIColor *)color
                                opaque:(BOOL)opaque;

@end

NS_ASSUME_NONNULL_END
