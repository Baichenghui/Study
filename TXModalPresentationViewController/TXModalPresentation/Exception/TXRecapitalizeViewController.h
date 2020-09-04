//
//  TXRecapitalizeViewController.h
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXBaseModalPresentationViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 //Demo:
 TXModalPresentationViewController *modalVC = [[TXModalPresentationViewController alloc] init];
 TXRecapitalizeViewController *contentVC = [[TXRecapitalizeViewController alloc] initWithModalPresentationController:modalVC];
 //    modalVC.animationStyle = TXModalPresentationAnimationStyleSlide;
 modalVC.contentViewController = contentVC;
 modalVC.didDimmingViewToHidden = YES;
 modalVC.contentViewMargins = UIEdgeInsetsMake(44.5, 12, 44.5, 12);
 [modalVC showWithAnimated:YES completion:nil];
 */

@interface TXRecapitalizeViewController : TXBaseModalPresentationViewController

@end

NS_ASSUME_NONNULL_END
