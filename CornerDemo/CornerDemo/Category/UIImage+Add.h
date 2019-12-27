//
//  UIImage+Add.h
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Add)
- (UIImage*)cc_imageCornerWithRadius:(CGFloat)radius
                             corners:(UIRectCorner)corners
                             andSize:(CGSize)size;
 
- (void)cc_roundRectImageWithSize:(CGSize)size
                        fillColor:(UIColor *)fillColor
                           opaque:(BOOL)opaque
                           radius:(CGFloat)radius
                       completion:(void (^)(UIImage *))completion;

- (UIImage *)cc_imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

+ (UIImage *)cc_imageByRoundCornerRadius:(CGFloat)radius
                                 corners:(UIRectCorner)corners
                                    size:(CGSize)size
                               fillColor:(UIColor *)fillColor;

+ (UIImage *)cc_pureColorImageWithSize:(CGSize)size
                                 color:(UIColor *)color
                            cornRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
