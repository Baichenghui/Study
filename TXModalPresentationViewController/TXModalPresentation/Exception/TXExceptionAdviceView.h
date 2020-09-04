//
//  TXExceptionAdviceView.h
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

/// 已申请协助标记key
static NSString * const kExceptionAdviceHasApplyKey = @"kExceptionAdviceHasApplyKey";

@class TXExceptionAdviceView;
@protocol TXExceptionAdviceViewDelegate <NSObject>
@required
- (void)exceptionAdviceViewDidToggle:(TXExceptionAdviceView *)exceptionAdviceView;
@optional
- (void)exceptionAdviceViewDidApply:(TXExceptionAdviceView *)exceptionAdviceView;
@end

@interface TXExceptionAdviceView : TXBaseAlertView
@property (nonatomic, weak) id<TXExceptionAdviceViewDelegate> delegate;
- (void)setApplyed:(BOOL)applyed;
@end

NS_ASSUME_NONNULL_END
