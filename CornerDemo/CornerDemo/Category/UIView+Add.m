//
//  UIView+Add.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "UIView+Add.h"
#import "UIImage+Add.h"
#import <objc/runtime.h>
  
@interface UIView ()

@property (nonatomic,strong) CALayer * bgLayer;
@end

@implementation UIView (Add)

- (void)cc_addRounderCornerWithRadius:(CGFloat)radius
                                 size:(CGSize)size
                              corners:(UIRectCorner)corner {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [UIImage cc_imageByRoundCornerRadius:radius corners:corner size:size fillColor:[UIColor blueColor]];
        dispatch_async(dispatch_get_main_queue(), ^{
            CALayer *bgLayer = [CALayer layer];
            bgLayer.contentsScale = [UIScreen mainScreen].scale;
            bgLayer.frame = CGRectMake(0, 0, size.width, size.height);
            bgLayer.contents = (__bridge id _Nullable)(image.CGImage);
            [self.layer insertSublayer:bgLayer atIndex:0];
        });
    });
}

- (void)cc_addRounderCornerWithRadius:(CGFloat)radius
                                 size:(CGSize)size
                              corners:(UIRectCorner)corner
                            fillColor:(UIColor *)fillColor {
    UIImage *image = [UIImage cc_imageByRoundCornerRadius:radius corners:corner size:size fillColor:fillColor];
         
    CALayer *bgLayer = [CALayer layer];
    bgLayer.contentsScale = [UIScreen mainScreen].scale;
    bgLayer.frame = CGRectMake(0, 0, size.width, size.height);
    bgLayer.contents = (__bridge id _Nullable)(image.CGImage);
    [self.layer insertSublayer:bgLayer atIndex:0];
}
 

@end
