//
//  TXRecapitalizeView.h
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXBaseAlertView.h"
#import "TXExceptionSolutionModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TXRecapitalizeView;
@protocol TXRecapitalizeViewDelegate <NSObject>
- (void)recapitalizeViewDidConfirm:(TXRecapitalizeView *)recapitalizeView;
@end

@interface TXRecapitalizeView : TXBaseAlertView
@property (nonatomic, weak) id<TXRecapitalizeViewDelegate> delegate; 
- (void)setExceptions:(NSArray<TXExceptionModel *> *)exceptions ;
- (void)setSolutionSteps:(NSString *)formatSolutionSteps;
@end
NS_ASSUME_NONNULL_END
