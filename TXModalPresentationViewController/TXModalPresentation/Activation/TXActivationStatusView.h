//
//  TXActivationContentView.h
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TXActivationStatus) {
    TXActivationStatusSuccess = 1,   // 成功
    TXActivationStatusFailed = 2,   // 失败
    TXActivationStatusUnknowError = 3,   // 出现位置错误
};

@class TXActivationStatusView;
@protocol TXActivationStatusViewDelegate <NSObject> 
- (void)activationStatusView:(TXActivationStatusView *)activationStatusView
        didConfirmWithStatus:(TXActivationStatus)status;
@end

@interface TXActivationStatusView : UIView
@property (nonatomic, weak) id<TXActivationStatusViewDelegate> delegate;
- (void)updateStatus:(TXActivationStatus)status;
@end

NS_ASSUME_NONNULL_END
