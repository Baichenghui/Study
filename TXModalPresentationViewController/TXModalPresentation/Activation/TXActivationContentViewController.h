//
//  TXActivationContentViewController.h
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXBaseModalPresentationViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 //demo:
 
 TXModalPresentationViewController *modalVC = [[TXModalPresentationViewController alloc] init];
 TXActivationContentViewController *contentVC = [[TXActivationContentViewController alloc] initWithModalPresentationController:modalVC];
 modalVC.animationStyle = TXModalPresentationAnimationStyleSlide;
 modalVC.contentViewController = contentVC;
 modalVC.contentViewMargins = UIEdgeInsetsZero;
 __weak typeof(modalVC) weakModalVC = modalVC;
 __weak typeof(contentVC) weakContentVC = contentVC;
 modalVC.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
     weakModalVC.contentViewFrameApplyTransform = CGRectSetXY(weakContentVC.view.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(weakContentVC.view.frame)), CGRectGetHeight(containerBounds) - CGRectGetHeight(weakContentVC.view.frame));
 };
 [modalVC showWithAnimated:YES completion:nil];
 
 */

@interface TXActivationContentViewController : TXBaseModalPresentationViewController
@end

NS_ASSUME_NONNULL_END
