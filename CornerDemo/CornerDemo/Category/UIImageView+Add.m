//
//  UIImageView+Add.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "UIImageView+Add.h"
#import <SDWebImage/SDWebImage.h>
#import "UIImage+Add.h"

@implementation UIImageView (Add)

- (UIImageView *)cc_roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius
                                                 corners:(UIRectCorner)corners {
    UIBezierPath *bezierPath =  
    [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    self.layer.mask = layer;

    return self;
}

#pragma mark - Network image

- (void)cc_setImageWithURLString:(NSString *)urlString
                           placeholder:(nullable UIImage *)image
                             fillColor:(nullable UIColor *)color {
    [self cc_setImageWithURLString:urlString placeholder:image fillColor:color opaque:color != nil];
}

- (void)cc_setImageWithURLString:(NSString *)urlString
                           placeholder:(nullable UIImage *)image{
    [self cc_setImageWithURLString:urlString placeholder:image fillColor:nil opaque:NO];
}

- (void)cc_setImageWithURLString:(NSString *)urlString
                              placeholder:(nullable UIImage *)image
                                fillColor:(nullable UIColor *)color
                             cornerRadius:(CGFloat) cornerRadius{
    [self cc_setImageWithURLString:urlString
                                placeholder:image
                                  fillColor:color
                                     opaque:color
                               cornerRadius:cornerRadius];
}

- (void)cc_setImageWithURLString:(NSString *)urlString
                              placeholder:(nullable UIImage *)image
                             cornerRadius:(CGFloat) cornerRadius{
    [self cc_setImageWithURLString:urlString
                                placeholder:image
                                  fillColor:nil
                                     opaque:NO
                               cornerRadius:cornerRadius];
}

- (void)cc_setImageWithURLString:(NSString *)urlString
                           placeholder:(nullable UIImage *)placeholder
                             fillColor:(nullable UIColor *)color
                                opaque:(BOOL)opaque{
    [self cc_setImageWithURLString:urlString
                                placeholder:placeholder
                                  fillColor:nil
                                     opaque:NO
                               cornerRadius:self.bounds.size.width * 0.5];
}

- (void)cc_setImageWithURLString:(NSString *)urlString
                              placeholder:(nullable UIImage *)placeholder
                                fillColor:(nullable UIColor *)color
                                   opaque:(BOOL)opaque
                             cornerRadius:(CGFloat) cornerRadius{ 
     [self cc_setImageWithURLString:urlString
                                 placeholder:placeholder
                                   fillColor:nil
                                      opaque:NO
                                cornerRadius:cornerRadius
                                 contentMode:(UIViewContentModeScaleToFill)];
}

- (void)cc_setImageWithURLString:(NSString *)urlString
                              placeholder:(nullable UIImage *)image
                                fillColor:(nullable UIColor *)color
                                   opaque:(BOOL)opaque
                             cornerRadius:(CGFloat) cornerRadius
                              contentMode:(UIViewContentMode)contentMode {
    NSURL *url = [NSURL URLWithString:urlString];
    __weak typeof(self) weakSelf = self;
    CGSize size = self.frame.size;

    NSString *cacheurlString = [url.absoluteString stringByAppendingString:[NSString stringWithFormat:@"radiusCache%.f",cornerRadius]];
    if (image) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //避免在主线程，因为IO操作非常耗时
            UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlString];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cacheImage) {
                    weakSelf.image = cacheImage;
                }
                else {
                    [image cc_roundRectImageWithSize:size fillColor:color opaque:opaque radius:cornerRadius completion:^(UIImage *roundRectPlaceHolder) {
                        [weakSelf sd_setImageWithURL:url placeholderImage:roundRectPlaceHolder completed:^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             
                            [[img cc_imageByResizeToSize:size contentMode:contentMode] cc_roundRectImageWithSize:size fillColor:color opaque:opaque radius:cornerRadius completion:^(UIImage *radiusImage) {
                                weakSelf.image = radiusImage;

                                [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlString completion:nil];
                                //清除原有非圆角图片缓存,也可以不清除
                                [[SDImageCache sharedImageCache] removeImageForKey:url.absoluteString withCompletion:nil];
                            }];
                        }];
                    }];
                }
            });
        });
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //避免在主线程，因为IO操作非常耗时
            UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlString];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cacheImage) {
                    weakSelf.image = cacheImage;
                }
                else {
                    [weakSelf sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        [[img cc_imageByResizeToSize:size contentMode:contentMode] cc_roundRectImageWithSize:size fillColor:color opaque:opaque radius:cornerRadius completion:^(UIImage *radiusImage) {
                            weakSelf.image = radiusImage;
                            
                            [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlString completion:nil];
                            //清除原有非圆角图片缓存,也可以不清除
                            [[SDImageCache sharedImageCache] removeImageForKey:url.absoluteString withCompletion:nil];
                        }];
                    }];
                }
            });
        });
    }
} 

@end
