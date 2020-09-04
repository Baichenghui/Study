//
//  TXBaseAlertView.h
//  QZX
//
//  Created by tianxi on 2020/9/3.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TXBaseAlertView;
@protocol TXBaseAlertViewProtocol <NSObject>
- (CGSize)preferredContentSizeInAlertView:(TXBaseAlertView *)alertView limitSize:(CGSize)limitSize;
@end

@interface TXBaseAlertView : UIView<TXBaseAlertViewProtocol>

@property(nonatomic, assign) UIEdgeInsets contentViewMargins;
@property(nonatomic, assign) UIEdgeInsets maskViewMargins;

- (void)showInView:(UIView *)superView;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
