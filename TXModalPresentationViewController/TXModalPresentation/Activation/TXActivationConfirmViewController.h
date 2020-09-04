//
//  TXActivationConfirmViewController.h
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXBaseModalPresentationViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 //demo:
 TXModalPresentationViewController *modalVC = [[TXModalPresentationViewController alloc] init];
 TXActivationConfirmViewController *contentVC = [[TXActivationConfirmViewController alloc] initWithModalPresentationController:modalVC];
 //    modalVC.animationStyle = TXModalPresentationAnimationStyleSlide;
 modalVC.contentViewController = contentVC;
 modalVC.contentViewMargins = UIEdgeInsetsMake(0, 12, 0, 12);
 [modalVC showWithAnimated:YES completion:nil];
 */
@interface TXActivationConfirmViewController : TXBaseModalPresentationViewController 
@end

NS_ASSUME_NONNULL_END
