//
//  TXExceptionAdviceViewController.h
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
     TXExceptionAdviceViewController *contentVC = [[TXExceptionAdviceViewController alloc] initWithModalPresentationController:modalVC];
 //    modalVC.animationStyle = TXModalPresentationAnimationStyleSlide; 
     modalVC.contentViewController = contentVC;
     modalVC.contentViewMargins = UIEdgeInsetsMake(0, 12, 0, 12);
     [modalVC showWithAnimated:YES completion:nil];
 */

@interface TXExceptionAdviceViewController : TXBaseModalPresentationViewController
@end

NS_ASSUME_NONNULL_END
