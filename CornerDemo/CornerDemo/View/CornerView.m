//
//  CornerView.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/12.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerView.h"
#import "UIImage+Add.h"

@interface CornerView()
@property (nonatomic,strong) CALayer * cornerLayer;
@end

@implementation CornerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInitialize];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self didInitialize];
}

- (void)didInitialize {
    [self.layer insertSublayer:self.cornerLayer atIndex:0];
}
  
- (void)cornerWithRadius:(CGFloat)radius
                    size:(CGSize)size
                  corner:(UIRectCorner)corner
               fillColor:(UIColor *)fillColor {
    if (self.cornerLayer.contents == nil) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *image = [UIImage cc_imageByRoundCornerRadius:radius corners:corner size:size fillColor:fillColor];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cornerLayer.frame = CGRectMake(0, 0, size.width, size.height);
                self.cornerLayer.contents = (__bridge id _Nullable)(image.CGImage);
            });
        });
    }
}
  
- (CALayer *)cornerLayer {
    if (!_cornerLayer) {
        _cornerLayer = [CALayer layer]; 
        _cornerLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _cornerLayer;
}
 
@end
