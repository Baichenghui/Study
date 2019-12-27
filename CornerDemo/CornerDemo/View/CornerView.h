//
//  CornerView.h
//  CornerDemo
//
//  Created by tianxi on 2019/12/12.
//  Copyright © 2019 hh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CornerView : UIView
- (void)cornerWithRadius:(CGFloat)radius
                    size:(CGSize)size
                  corner:(UIRectCorner)corner
               fillColor:(UIColor *)fillColor;
@end

NS_ASSUME_NONNULL_END
