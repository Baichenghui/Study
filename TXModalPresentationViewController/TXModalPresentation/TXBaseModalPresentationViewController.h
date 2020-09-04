//
//  TXBaseModalPresentationViewController.h
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXModalPresentationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TXBaseModalPresentationViewController : UIViewController<TXModalPresentationContentViewProtocol>
- (instancetype)initWithModalPresentationController:(TXModalPresentationViewController *)modalVC;
- (TXModalPresentationViewController *)getModalVC;
@end

NS_ASSUME_NONNULL_END
