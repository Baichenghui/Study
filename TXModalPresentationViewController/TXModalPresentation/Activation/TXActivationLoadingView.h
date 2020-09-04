//
//  TXActivationLoadingView.h
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@class TXActivationLoadingView;
//@protocol TXActivationLoadingViewDelegate <NSObject>
//- (void)activationLoadingView:(TXActivationLoadingView *)activationLoadingView finish:(BOOL)finish;
//@end

@interface TXActivationLoadingView : UIView
///// delegate
//@property (nonatomic, weak) id<TXActivationLoadingViewDelegate> delegate;
/// 设置进度条最大最小值
/// @param maxValue 最大值，默认为1
/// @param minValue 最小值，默认为0
- (void)configMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue;
/// 进度设置
/// @param progress 进度值
- (void)updateProgress:(CGFloat)progress;
@end


NS_ASSUME_NONNULL_END
