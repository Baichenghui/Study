//
//  TXActivationLoadingView.m
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXActivationLoadingView.h"
 
@interface TXProgressView : UIView
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, strong) UIView *tView;
@end
 
@implementation TXProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor tx_colorNamed:@"#000000"];
        UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
        borderView.layer.cornerRadius = self.bounds.size.height * 0.5;
        borderView.layer.masksToBounds = YES;
        borderView.backgroundColor = [UIColor tx_colorNamed:@"#000000"];
        [self addSubview:borderView];
         
        //进度
        UIView *tView = [[UIView alloc] init];
        tView.backgroundColor = [UIColor tx_colorNamed:@"#3C62F5"];
        tView.layer.cornerRadius = self.bounds.size.height * 0.5;
        tView.layer.masksToBounds = YES;
        [self addSubview:tView];
        self.tView = tView;
        
        self.maxValue = 1;
        self.minValue = 0;
    }
    return self;
}

- (void)configMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    if (maxValue < 1) {
        maxValue = 1;
    }
    if (minValue < 0) {
        minValue = 0;
    }
    self.maxValue = maxValue;
    self.minValue = minValue;
}

- (void)updateProgress:(CGFloat)progress {
    _progress = progress;
    CGFloat unitWidth = self.bounds.size.width / self.maxValue;
    CGFloat heigth = self.bounds.size.height;
    _tView.frame = CGRectMake(0, 0, unitWidth * progress, heigth);
}

@end

@interface TXActivationLoadingView()
@property (nonatomic, strong) UIImageView *loadingImageView;
@property (nonatomic, strong) CABasicAnimation* rotationAnimation;
@property (nonatomic, strong) UILabel *loadingTipLable;
@property (nonatomic, strong) TXProgressView *progressView;
@end

@implementation TXActivationLoadingView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
        [self initSubviews];
//        [self initLayoutSubviews];
    }
    return self;
}
  
- (void)initSubviews {
    self.layer.cornerRadius = 10;
    [self addSubview:self.loadingImageView];
    [self addSubview:self.loadingTipLable];
    [self addSubview:self.progressView];
}

#pragma mark - Public
 
- (void)configMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    [self.progressView configMaxValue:maxValue minValue:minValue];
}

- (void)updateProgress:(CGFloat)progress {
    if (progress >= self.progressView.maxValue) {
        progress = self.progressView.maxValue;
        [self removeLoadingAnimation];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(activationLoadingView:finish:)]) {
//            [self.delegate activationLoadingView:self finish:YES];
//        }
    } else {
        [self startLoadingAnimation];
    }
    [self.progressView updateProgress:progress];
}

#pragma mark - Private

- (void)startLoadingAnimation {
     [self.loadingImageView.layer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
}

- (void)removeLoadingAnimation {
    [self.loadingImageView.layer removeAnimationForKey:@"rotationAnimation"];
}
 
#pragma mark - Getter/Setter

- (UIImageView *)loadingImageView {
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(TXAdaptWidth(118.5), TXAdaptHeight(150), 17, 17)];
        _loadingImageView.image = [UIImage imageNamed:@"activation_loading_icon"];
    }
    return _loadingImageView;
}

- (CABasicAnimation *)rotationAnimation {
    if (!_rotationAnimation) {
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.5;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 100000;
        _rotationAnimation = rotationAnimation;
    }
    return _rotationAnimation;
}

- (UILabel *)loadingTipLable {
    if (!_loadingTipLable) {
        _loadingTipLable = [[UILabel alloc] initWithFrame:CGRectMake(TXAdaptWidth(118.5) + 29, TXAdaptHeight(150) + 1.5, 115, 15)];
        _loadingTipLable.textAlignment = NSTextAlignmentLeft;
        _loadingTipLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _loadingTipLable.textColor = [UIColor tx_colorNamed:@"#A4A4A4"];
        _loadingTipLable.text = @"量化模式激活中....";
    }
    return _loadingTipLable;
}

- (TXProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[TXProgressView alloc] initWithFrame:CGRectMake(TXAdaptWidth(73.5), TXAdaptHeight(151.5) + 35, TXAdaptWidth(229), 4)];
    }
    return _progressView;
}

@end
