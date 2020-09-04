//
//  TXBaseAlertView.m
//  QZX
//
//  Created by tianxi on 2020/9/3.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXBaseAlertView.h"

CG_INLINE CGFloat
flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    scale = scale == 0 ? [[UIScreen mainScreen] scale] : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
flat(CGFloat floatValue) {
    return flatSpecificScale(floatValue, 0);
}

/// 用于居中运算
CG_INLINE CGFloat
CGFloatGetCenter(CGFloat parent, CGFloat child) {
    return flat((parent - child) / 2.0);
} 
 
/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

@interface TXBaseAlertView()
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation TXBaseAlertView

/**
 视图层级说明：self (content )===》maskView(mask)===》containerView (container)
 */

#pragma mark - Public

- (void)showInView:(UIView *)containerView {
    if (containerView == nil) {
        return;
    } else {
        self.containerView = containerView;
        if (self.superview) {
            [self removeFromSuperview];
        }
        if (self.maskView.superview) {
            [self.maskView removeFromSuperview];
        }
    }
     
    [self.maskView addSubview:self];
    [self.containerView addSubview:self.maskView];
    [self.containerView bringSubviewToFront:self.maskView];
    
    self.frame = [self contentViewFrameForShowing];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES; 
}

- (void)hide {
    if (self.superview) {
        [self removeFromSuperview];
    }
    if (self.maskView.superview) {
        [self.maskView removeFromSuperview];
    }
}

#pragma mark - TXBaseAlertViewProtocol

- (CGSize)preferredContentSizeInAlertView:(TXBaseAlertView *)alertView limitSize:(CGSize)limitSize {
    return CGSizeZero;
}

#pragma mark - Getter

- (UIView *)maskView {
    if (!_maskView) {
        CGRect frame = CGRectMake(0, self.maskViewMargins.top, self.containerView.bounds.size.width, self.containerView.bounds.size.height - self.maskViewMargins.top - self.maskViewMargins.bottom);
        _maskView = [[UIView alloc] initWithFrame:frame];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    }
    return _maskView;
}

- (CGRect)contentViewFrameForShowing{
    CGSize contentViewContainerSize = CGSizeMake(CGRectGetWidth(self.maskView.bounds) - UIEdgeInsetsGetHorizontalValue(self.contentViewMargins), CGRectGetHeight(self.maskView.bounds)- UIEdgeInsetsGetVerticalValue(self.contentViewMargins));
    CGSize contentViewLimitSize = CGSizeMake(MIN(kScreenWidth, contentViewContainerSize.width), contentViewContainerSize.height);
    CGSize contentViewSize = CGSizeZero;
    if ([self respondsToSelector:@selector(preferredContentSizeInAlertView:limitSize:)]) {
        contentViewSize = [self preferredContentSizeInAlertView:self limitSize:contentViewLimitSize];
    } else {
        contentViewSize = [self sizeThatFits:contentViewLimitSize];
    }
    contentViewSize.width = fminf(contentViewLimitSize.width, contentViewSize.width);
    contentViewSize.height = fminf(contentViewLimitSize.height, contentViewSize.height);
    CGRect contentViewFrame = CGRectMake(CGFloatGetCenter(contentViewContainerSize.width, contentViewSize.width) + self.contentViewMargins.left, CGFloatGetCenter(contentViewContainerSize.height, contentViewSize.height) + self.contentViewMargins.top, contentViewSize.width, contentViewSize.height); 
    contentViewFrame = CGRectApplyAffineTransform(contentViewFrame, self.transform);
    return contentViewFrame;
}

@end
