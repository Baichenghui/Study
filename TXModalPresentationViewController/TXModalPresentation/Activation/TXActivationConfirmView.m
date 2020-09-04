//
//  TXActivationConfirmView.m
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXActivationConfirmView.h"

@interface TXActivationConfirmView()
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *tipLable;
@property (nonatomic, weak) UILabel *rightsLable;
@property (nonatomic, weak) UILabel *rightsContentLable;
@property (nonatomic, weak) UILabel *freezingFundsLable;
@property (nonatomic, weak) UILabel *freezingFundsContentLable;
@property (nonatomic, weak) UILabel *bondLable;
@property (nonatomic, weak) UILabel *bondContentLable;
@property (nonatomic, weak) UIButton *confirmBtn;
@end

@implementation TXActivationConfirmView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
        [self initSubviews];
        [self initLayoutSubviews];
    }
    return self;
}
  
- (void)initSubviews {
    self.layer.cornerRadius = 10;
    
    [self addSubview:self.titleLable];
    [self addSubview:self.rightsLable];
    [self addSubview:self.rightsContentLable];
    [self addSubview:self.freezingFundsLable];
    [self addSubview:self.freezingFundsContentLable];
    [self addSubview:self.bondLable];
    [self addSubview:self.bondContentLable];
    [self addSubview:self.tipLable];
    [self addSubview:self.confirmBtn];
}

- (void)initLayoutSubviews {
    self.titleLable.frame = CGRectMake(0, 0, (kScreenWidth - 24), 45);
     
    self.rightsLable.frame = CGRectMake(23, CGRectGetMaxY(self.titleLable.frame) + 18, (self.bounds.size.width - 46) * 0.5, 14);
    self.rightsContentLable.frame = CGRectMake((self.bounds.size.width - 46) * 0.5 + 33, CGRectGetMaxY(self.titleLable.frame) + 18, (self.bounds.size.width - 46) * 0.5 - 10, 14);
    
    self.freezingFundsLable.frame = CGRectMake(23, CGRectGetMaxY(self.rightsLable.frame) + 14, (self.bounds.size.width - 46) * 0.5, 14);
    self.freezingFundsContentLable.frame = CGRectMake((self.bounds.size.width - 46) * 0.5 + 33, CGRectGetMaxY(self.rightsLable.frame) + 14, (self.bounds.size.width - 46) * 0.5 - 10, 14);
    
    self.bondLable.frame = CGRectMake(23, CGRectGetMaxY(self.freezingFundsLable.frame) + 14, (self.bounds.size.width - 46) * 0.5, 14);
    self.bondContentLable.frame = CGRectMake((self.bounds.size.width - 46) * 0.5 + 33, CGRectGetMaxY(self.freezingFundsLable.frame) + 14, (self.bounds.size.width - 46) * 0.5 - 10, 14);
    
    self.tipLable.frame = CGRectMake(23, CGRectGetMaxY(self.bondContentLable.frame) + 18, self.bounds.size.width - 46, 100);
    [self.tipLable sizeToFit];
       
    self.confirmBtn.frame = CGRectMake(18, CGRectGetMaxY(self.tipLable.frame) + 26, self.bounds.size.width - 36, 44);
     
    self.frame = CGRectMake(0, 0, kScreenWidth - 24, CGRectGetMaxY(self.confirmBtn.frame)+17);
}

#pragma mark - Event

- (void)confirmAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(activationConfirmViewDidConfirm:)]) {
        [self.delegate activationConfirmViewDidConfirm:self];
    }
}
  
#pragma mark - Public
  

#pragma mark - Private
  
 
#pragma mark - Getter/Setter

- (UILabel *)titleLable {
    if (!_titleLable) {
        UILabel *lable = [[UILabel alloc] init];
        _titleLable = lable;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor tx_colorNamed:@"#181A1C"];
        _titleLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        _titleLable.textColor = [UIColor tx_colorNamed:@"#FFFFFF"];
        _titleLable.text = @"激活确认";
    }
    return _titleLable;
}


- (UILabel *)rightsLable {
    if (!_rightsLable) {
        UILabel *rightsLable = [[UILabel alloc] init];
        _rightsLable = rightsLable;
        _rightsLable.textAlignment = NSTextAlignmentRight;
        _rightsLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _rightsLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _rightsLable.text = @"您当前权益：";
    }
    return _rightsLable;
}

- (UILabel *)rightsContentLable {
    if (!_rightsContentLable) {
        UILabel *rightsContentLable = [[UILabel alloc] init];
        _rightsContentLable = rightsContentLable;
        _rightsContentLable.textAlignment = NSTextAlignmentLeft;
        _rightsContentLable.font = [UIFont fontWithName:@"DIN-Regular" size:16];
        _rightsContentLable.textColor = [UIColor tx_colorNamed:@"#FFFFFF"];
        _rightsContentLable.text = @"15,250,000.00";
    }
    return _rightsContentLable;
}

- (UILabel *)freezingFundsLable {
    if (!_freezingFundsLable) {
        UILabel *freezingFundsLable = [[UILabel alloc] init];
        _freezingFundsLable = freezingFundsLable;
        _freezingFundsLable.textAlignment = NSTextAlignmentRight;
        _freezingFundsLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _freezingFundsLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _freezingFundsLable.text = @"冻结资金：";
    }
    return _freezingFundsLable;
}

- (UILabel *)freezingFundsContentLable {
    if (!_freezingFundsContentLable) {
        UILabel *freezingFundsContentLable = [[UILabel alloc] init];
        _freezingFundsContentLable = freezingFundsContentLable;
        _freezingFundsContentLable.textAlignment = NSTextAlignmentLeft;
        _freezingFundsContentLable.font = [UIFont fontWithName:@"DIN-Regular" size:16];
        _freezingFundsContentLable.textColor = [UIColor tx_colorNamed:@"#FFFFFF"];
        _freezingFundsContentLable.text = @"10,000.00";
    }
    return _freezingFundsContentLable;
}
 
- (UILabel *)bondLable {
    if (!_bondLable) {
        UILabel *bondLable = [[UILabel alloc] init];
        _bondLable = bondLable;
        _bondLable.textAlignment = NSTextAlignmentRight;
        _bondLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _bondLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _bondLable.text = @"持仓保证金：";
    }
    return _bondLable;
}

- (UILabel *)bondContentLable {
    if (!_bondContentLable) {
        UILabel *bondContentLable = [[UILabel alloc] init];
        _bondContentLable = bondContentLable;
        _bondContentLable.textAlignment = NSTextAlignmentLeft;
        _bondContentLable.numberOfLines = 0;
        _bondContentLable.font = [UIFont fontWithName:@"DIN-Regular" size:16];
        _bondContentLable.textColor = [UIColor tx_colorNamed:@"#FFFFFF"];
        _bondContentLable.text = @"0";
    }
    return _bondContentLable;
}


- (UILabel *)tipLable {
    if (!_tipLable) {
        UILabel *tipLable = [[UILabel alloc] init];
        _tipLable = tipLable;
        _tipLable.textAlignment = NSTextAlignmentLeft;
        _tipLable.numberOfLines = 0;
        _tipLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _tipLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _tipLable.text = @"量化模式激活后，您的权益将同步激活至您的手动资产单元。";
    }
    return _tipLable;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(12, 0, (kScreenWidth - 24), 45);
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_confirmBtn setTitleColor:[UIColor tx_colorNamed:@"#976C1C"] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [UIColor tx_colorNamed:@"#FFD87E"];
        [_confirmBtn setTitle:@"确定激活" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:17];
        _confirmBtn.layer.cornerRadius = 5;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}
  


@end
