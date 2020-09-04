//
//  TXExceptionAdviceView.m
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXExceptionAdviceView.h"
#import "UIButton+TXAdd.h"

@interface TXExceptionAdviceItemView : UIView
@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *contentLable;
@end

@implementation TXExceptionAdviceItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
        [self initSubviews];
        [self initLayoutSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.dotView];
    [self addSubview:self.contentLable];
}

- (void)initLayoutSubviews {
    
}

- (void)setContent:(NSString *)content {
    self.contentLable.text = content;
}

- (UIView *)dotView {
    if (!_dotView) {
        _dotView = [[UIView alloc] initWithFrame:CGRectMake(4.5, 5, 4, 4)];
        _dotView.layer.cornerRadius = 2;
        _dotView.backgroundColor = [UIColor tx_colorNamed:@"#FFB400"];
    }
    return _dotView;
}

- (UILabel *)contentLable {
    if (!_contentLable) {
        _contentLable = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, self.bounds.size.width - 16, 14.5)];
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.numberOfLines = 0;
        _contentLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _contentLable.textColor = [UIColor tx_colorNamed:@"#D0D0D0"];
        _contentLable.text = @"禁用该交易模式下所有操作功能;";
    }
    return _contentLable;
}

@end

@interface TXExceptionAdviceView() 
@property (nonatomic, weak) UIButton *titleBtn;
@property (nonatomic, weak) UILabel *tipLable;
@property (nonatomic, weak) UILabel *tipItemLable1;
@property (nonatomic, weak) UILabel *tipItemLable2;
@property (nonatomic, weak) UILabel *tipContactLable;
@property (nonatomic, weak) UILabel *tipToggleLable;
@property (nonatomic, weak) UIButton *applyBtn;
@property (nonatomic, weak) UIButton *toggleBtn;
@property (nonatomic, weak) TXExceptionAdviceItemView *itemView1;
@property (nonatomic, weak) TXExceptionAdviceItemView *itemView2;
@end

@implementation TXExceptionAdviceView
 
#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
        [self initSubviews];
        [self initLayoutSubviews];
        [self renderData];
    }
    return self;
}
  
- (void)initSubviews {
    self.layer.cornerRadius = 10; 
    [self addSubview:self.titleBtn];
    [self addSubview:self.tipLable];
    [self addSubview:self.itemView1];
    [self addSubview:self.itemView2];
    [self addSubview:self.tipContactLable];
    [self addSubview:self.applyBtn];
    [self addSubview:self.tipToggleLable];
    [self addSubview:self.toggleBtn];
}

- (void)initLayoutSubviews {
    /// title
    self.titleBtn.frame = CGRectMake(0, 0, (kScreenWidth - 24), 45);
    /// tip
    self.tipLable.frame = CGRectMake(23, 70, self.bounds.size.width - 46, 100);
    [self.tipLable sizeToFit];
    /// items
    self.itemView1.frame = CGRectMake(23, CGRectGetMaxY(self.tipLable.frame) + 11, self.bounds.size.width - 46, 14.5);
    self.itemView2.frame = CGRectMake(23, CGRectGetMaxY(self.itemView1.frame) + 6.5, self.bounds.size.width - 46, 14.5);
    /// tip contact
    self.tipContactLable.frame = CGRectMake(23, CGRectGetMaxY(self.itemView2.frame) + 11, self.bounds.size.width - 46, 100);
    [self.tipContactLable sizeToFit];
    /// apply
    self.applyBtn.frame = CGRectMake(23, CGRectGetMaxY(self.tipContactLable.frame) + 23, self.bounds.size.width - 46, 44);
    /// toggle
    self.tipToggleLable.frame = CGRectMake(23, CGRectGetMaxY(self.applyBtn.frame) + 11, self.bounds.size.width - 46, 100);
    [self.tipToggleLable sizeToFit];
    self.toggleBtn.frame = CGRectMake(23, CGRectGetMaxY(self.tipToggleLable.frame) + 4, self.bounds.size.width - 46, 48);
    self.frame = CGRectMake(0, 0, kScreenWidth - 24, CGRectGetMaxY(self.toggleBtn.frame));
}

- (void)renderData {
    BOOL hasApply = [[NSUserDefaults standardUserDefaults] boolForKey:kExceptionAdviceHasApplyKey];
    [self setApplyed:hasApply];
}

#pragma mark - Event

- (void)applyAction:(UIButton *)sender {
    /// 这种状态应该统一管理，
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kExceptionAdviceHasApplyKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self renderData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(exceptionAdviceViewDidApply:)]) {
        [self.delegate exceptionAdviceViewDidApply:self];
    }
}

- (void)toggleAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(exceptionAdviceViewDidToggle:)]) {
        [self.delegate exceptionAdviceViewDidToggle:self];
    }
}

#pragma mark - Public
 
- (void)setApplyed:(BOOL)applyed {
    if (applyed) {
        [self layoutApplyed];
    } else {
        [self layoutApply];
    }
}

#pragma mark - TXBaseAlertViewProtocol

- (CGSize)preferredContentSizeInAlertView:(TXBaseAlertView *)alertView limitSize:(CGSize)limitSize {
    return self.bounds.size;
}

#pragma mark - Private

- (void)layoutApplyed {
    [_applyBtn setTitleColor:[UIColor tx_colorNamed:@"#DEDEDE"] forState:UIControlStateNormal];
    _applyBtn.backgroundColor = [UIColor tx_colorNamed:@"#7D7F83"];
    [_applyBtn setTitle:@"申请已提交，期智行客服将尽快联系您" forState:UIControlStateNormal];
    _applyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    _applyBtn.enabled = NO;
}

- (void)layoutApply {
   [_applyBtn setTitleColor:[UIColor tx_colorNamed:@"#976C1C"] forState:UIControlStateNormal];
   _applyBtn.backgroundColor = [UIColor tx_colorNamed:@"#FFD87E"];
   [_applyBtn setTitle:@"申请协助" forState:UIControlStateNormal];
   _applyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:17];
    _applyBtn.enabled = YES;
}
 
#pragma mark - Getter/Setter
 
- (UIButton *)applyBtn {
    if (!_applyBtn) {
        _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyBtn.frame = CGRectMake(12, 0, (kScreenWidth - 24), 45);
        [_applyBtn addTarget:self action:@selector(applyAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_applyBtn setTitleColor:[UIColor tx_colorNamed:@"#976C1C"] forState:UIControlStateNormal];
        _applyBtn.backgroundColor = [UIColor tx_colorNamed:@"#FFD87E"];
        [_applyBtn setTitle:@"申请协助" forState:UIControlStateNormal];
        _applyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:17];
        _applyBtn.layer.cornerRadius = 5;
        _applyBtn.layer.masksToBounds = YES;
    }
    return _applyBtn;
}

- (UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.frame = CGRectMake(0, 0, (kScreenWidth - 24), 45);
        [_titleBtn addTarget:self action:@selector(applyAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _titleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        [_titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"exception_advice_icon"] forState:UIControlStateNormal];
        _titleBtn.backgroundColor = [UIColor tx_colorNamed:@"#181A1C"];
        [_titleBtn setTitle:@"异常通知" forState:UIControlStateNormal];
        [_titleBtn setupImageStyle:(TXButtonImageStyleLeft) spacing:6.5];
        _titleBtn.enabled = NO;
    }
    return _titleBtn;
}

- (UIButton *)toggleBtn {
    if (!_toggleBtn) {
        _toggleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _toggleBtn.frame = CGRectMake(30, 0, (kScreenWidth - 60), 44);
        [_toggleBtn setImage:[UIImage imageNamed:@"exception_arrow_icon"] forState:UIControlStateNormal];
        [_toggleBtn addTarget:self action:@selector(toggleAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _toggleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        [_toggleBtn setTitleColor:[UIColor tx_colorNamed:@"#4289FF"] forState:UIControlStateNormal];
        [_toggleBtn setTitle:@"经典模式" forState:UIControlStateNormal];
        [_toggleBtn setupImageStyle:(TXButtonImageStyleLeft) spacing:5.5];
    }
    return _toggleBtn;
}

- (UILabel *)tipLable {
    if (!_tipLable) {
        UILabel *tipLable = [[UILabel alloc] init];
        _tipLable = tipLable;
        _tipLable.textAlignment = NSTextAlignmentLeft;
        _tipLable.numberOfLines = 0;
        _tipLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _tipLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _tipLable.text = @"您好，系统检测到您在非期智行软件有出金或开平仓交易操作，为了确保您的资产单元安全及数据完整性，系统已采取以下处理：";
    }
    return _tipLable;
}

- (UILabel *)tipContactLable {
    if (!_tipContactLable) {
        UILabel *tipContactLable = [[UILabel alloc] init];
        _tipContactLable = tipContactLable;
        _tipContactLable.textAlignment = NSTextAlignmentLeft;
        _tipContactLable.numberOfLines = 0;
        _tipContactLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _tipContactLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _tipContactLable.text = @"您可以联系您的专属客服协助您恢复当前交易模式。";
    }
    return _tipContactLable;
}

- (UILabel *)tipToggleLable {
    if (!_tipToggleLable) {
        UILabel *tipToggleLable = [[UILabel alloc] init];
        _tipToggleLable = tipToggleLable;
        _tipToggleLable.textAlignment = NSTextAlignmentLeft;
        _tipToggleLable.numberOfLines = 0;
        _tipToggleLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _tipToggleLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _tipToggleLable.text = @"如果您仍需要手动操作您的期货账户，您可以通过切换登录到  经典模式  继续进行操作。";
    }
    return _tipToggleLable;
}

- (TXExceptionAdviceItemView *)itemView1 {
    if (!_itemView1) {
        TXExceptionAdviceItemView *view = [[TXExceptionAdviceItemView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 70), 14.5)];
        _itemView1 = view;
        [_itemView1 setContent:@"禁用该交易模式下所有操作功能;"];
    }
    return _itemView1;
}

- (TXExceptionAdviceItemView *)itemView2 {
    if (!_itemView2) {
        TXExceptionAdviceItemView *view = [[TXExceptionAdviceItemView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 70), 14.5)];
        _itemView2 = view;
        [_itemView2 setContent:@"暂停您当前运行的所有量化策略。"];
    }
    return _itemView2;
}

@end
