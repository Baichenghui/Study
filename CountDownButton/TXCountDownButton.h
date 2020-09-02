//
//  TXCountDownButton.h
//  QZX
//
//  Created by tianxi on 2020/9/1.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXCountDownButton : UIButton
@property (nonatomic, assign) NSUInteger timeInterval;
@property (nonatomic, assign) NSInteger maxInteger;
@property (nonatomic, assign) NSInteger minInteger;

- (void)startCountdown;
- (void)stopCountdown;
@end

NS_ASSUME_NONNULL_END
