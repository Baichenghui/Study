//
//  TXActivationConfirmView.h
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TXActivationConfirmView;
@protocol TXActivationConfirmViewDelegate <NSObject>
- (void)activationConfirmViewDidConfirm:(TXActivationConfirmView *)activationConfirmView;
@end

@interface TXActivationConfirmView : UIView
@property (nonatomic, weak) id<TXActivationConfirmViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
