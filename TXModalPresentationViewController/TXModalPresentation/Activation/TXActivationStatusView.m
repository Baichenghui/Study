//
//  TXActivationStatusView.m
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXActivationStatusView.h"
  

@interface TXActivationStatusView()
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UILabel *statusTipLable;
@property (nonatomic, strong) UILabel *statusLable;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, assign) TXActivationStatus status;
@end

@implementation TXActivationStatusView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
        [self initSubviews]; 
    }
    return self;
}
  
- (void)initSubviews {
    self.layer.cornerRadius = 10;
    [self addSubview:self.statusImageView];
    [self addSubview:self.statusLable];
    [self addSubview:self.statusTipLable];
    [self addSubview:self.confirmBtn];
}

#pragma mark - Event

- (void)confirmAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(activationStatusView:didConfirmWithStatus:)]) {
        [self.delegate activationStatusView:self didConfirmWithStatus:self.status];
    }
}

#pragma mark - Public

- (void)updateStatus:(TXActivationStatus)status {
    self.status = status;
    
    switch (status) {
        case TXActivationStatusFailed:
        {
            [self layoutFailed];
        }
            break;
        case TXActivationStatusSuccess:
        {
            [self layoutSuccess];
        }
            break;
        case TXActivationStatusUnknowError:
        {
            [self layoutUnknowError];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Private

- (void)layoutFailed {
    self.statusImageView.image = [UIImage imageNamed:@"activation_failed_icon"];
    self.statusLable.text = @"激活失败";
    [self.statusTipLable setHidden:NO];
    self.statusTipLable.text = @"您当前仍有持仓，请清仓后再次尝试";
    self.statusTipLable.frame = CGRectMake(0, TXAdaptHeight(118.5) + 59 + 19.5 + 16.5 + 6, kScreenWidth, 14.5);
    self.confirmBtn.frame = CGRectMake((kScreenWidth - 99) * 0.5, TXAdaptHeight(118.5) + 59 + 19.5 + 16.5 + 6 + 15.5 + 38, 99, 33);
}


- (void)layoutUnknowError {
    self.statusImageView.image = [UIImage imageNamed:@"activation_failed_icon"];
    self.statusLable.text = @"激活失败";
    [self.statusTipLable setHidden:NO];
    self.statusTipLable.text = @"出现了未知的错误，请联系期智行客服人员协助解决";
    self.statusTipLable.frame = CGRectMake(0, TXAdaptHeight(118.5) + 59 + 19.5 + 16.5 + 6, kScreenWidth, 14.5);
    self.confirmBtn.frame = CGRectMake((kScreenWidth - 99) * 0.5, TXAdaptHeight(118.5) + 59 + 19.5 + 16.5 + 6 + 15.5 + 38, 99, 33);
}
 
- (void)layoutSuccess {
    self.statusImageView.image = [UIImage imageNamed:@"activation_success_icon"];
    self.statusLable.text = @"恭喜，您的资产单元已激活成功！";
    [self.statusTipLable setHidden:YES];
    self.confirmBtn.frame = CGRectMake((kScreenWidth - 99) * 0.5, TXAdaptHeight(118.5) + 59 + 36 + 46, 99, 33);
}
 
#pragma mark - Getter/Setter

- (UIImageView *)statusImageView {
    if (!_statusImageView) {
        _statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 59) * 0.5, TXAdaptHeight(118.5), 59, 59)];
        _statusImageView.image = [UIImage imageNamed:@"activation_success_icon"];
    }
    return _statusImageView;
}

- (UILabel *)statusLable {
     if (!_statusLable) {
         _statusLable = [[UILabel alloc] initWithFrame:CGRectMake(0, TXAdaptHeight(118.5) + 59 + 19.5, kScreenWidth, 16.5)];
         _statusLable.textAlignment = NSTextAlignmentCenter;
         _statusLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
         _statusLable.textColor = [UIColor tx_colorNamed:@"#D0D0D0"];
         _statusLable.text = @"激活失败";
     }
     return _statusLable;
}

- (UILabel *)statusTipLable {
    if (!_statusTipLable) {
        _statusTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, TXAdaptHeight(118.5) + 59 + 19.5 + 16.5 + 6, kScreenWidth, 14.5)];
        _statusTipLable.textAlignment = NSTextAlignmentCenter;
        _statusTipLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _statusTipLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _statusTipLable.text = @"您当前仍有持仓，请清仓后再次尝试";
    }
    return _statusTipLable;
}
- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake((kScreenWidth - 99) * 0.5, TXAdaptHeight(118.5) + 59 + 19.5 + 16.5 + 6 + 15.5 + 38, 99, 33);
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_confirmBtn setTitleColor:[UIColor tx_colorNamed:@"#976C1C"] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [UIColor tx_colorNamed:@"#FFD87E"];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 5;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}

@end
