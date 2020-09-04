//
//  TXRecapitalizeView.m
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXRecapitalizeView.h"
#import "UIButton+TXAdd.h"

@interface TXRecapitalizeTabItemView : UIView
@property (nonatomic, weak) UILabel *timeLable;
@property (nonatomic, weak) UILabel *actionLable;
@property (nonatomic, weak) UILabel *detailLable;
@property (nonatomic, assign) BOOL isHeader;
@end
@implementation TXRecapitalizeTabItemView
- (instancetype)initWithFrame:(CGRect)frame isHeader:(BOOL)isHeader {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor tx_colorNamed:@"#0E0F0F"]; 
        self.isHeader = isHeader;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {//133/78/119
    [self addSubview:self.timeLable];
    [self addSubview:self.actionLable];
    [self addSubview:self.detailLable];
}
- (void)setTime:(NSString *)time action:(NSString *)action detail:(NSString *)detail {
    self.timeLable.text = time;
    self.actionLable.text = action;
    self.detailLable.text = detail;
}
- (UILabel *)timeLable {
    if (!_timeLable) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width * 0.4, 49.5)];
        _timeLable = view;
        _timeLable.textAlignment = NSTextAlignmentCenter;
        _timeLable.backgroundColor = [UIColor tx_colorNamed:@"#1B1D1F"];
        _timeLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        if (self.isHeader) {
            _timeLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        } else {
            _timeLable.textColor = [UIColor tx_colorNamed:@"#FFFFFF"];
        }
        _timeLable.text = @"截止时间";
        _timeLable.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLable;
}
- (UILabel *)actionLable {
    if (!_actionLable) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLable.frame)+0.5, 0, self.bounds.size.width * 0.24, 49.5)];
        _actionLable = view;
        _actionLable.backgroundColor = [UIColor tx_colorNamed:@"#1B1D1F"];
        _actionLable.textAlignment = NSTextAlignmentCenter;
        if (self.isHeader) {
            _actionLable.textColor = [UIColor tx_colorNamed:@"#767676"];
            _actionLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        } else {
            _actionLable.textColor = [UIColor tx_colorNamed:@"#FFFFFF"];
            _actionLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        }
        _actionLable.text = @"行为";
    }
    return _actionLable;
}
- (UILabel *)detailLable {
    if (!_detailLable) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.actionLable.frame) + 0.5, 0, self.bounds.size.width - (CGRectGetMaxX(self.actionLable.frame) + 1), 49.5)];
        _detailLable = view;
        _detailLable.backgroundColor = [UIColor tx_colorNamed:@"#1B1D1F"];
        _detailLable.textAlignment = NSTextAlignmentCenter;
        _detailLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        if (self.isHeader) {
            _detailLable.textColor = [UIColor tx_colorNamed:@"#767676"];
            _detailLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        } else {
            _detailLable.textColor = [UIColor tx_colorNamed:@"#FFFFFF"];
            _detailLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        }
        _detailLable.text = @"详情";
    }
    return _detailLable;
}
@end

@interface TXRecapitalizeView()
@property (nonatomic, weak) UIButton *titleBtn;
@property (nonatomic, weak) UILabel *tipContactLable;
@property (nonatomic, weak) UIView *tableView;
@property (nonatomic, weak) UIView *needAdjustmentView;
@property (nonatomic, weak) UILabel *needAdjustmentLable;
@property (nonatomic, weak) UILabel *needAdjustmentContentLable;
@property (nonatomic, weak) UILabel *noticeLable;
@property (nonatomic, weak) UILabel *tipLable;
@property (nonatomic, weak) UIButton *confirmBtn;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray <TXRecapitalizeTabItemView *> *tabItemViews;

@property (nonatomic, assign) BOOL hasNeedAdjustmentContent;
@end

@implementation TXRecapitalizeView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
        self.hasNeedAdjustmentContent = YES;
        [self initSubviews];
        [self didLayoutSubviews];
    }
    return self;
}
  
- (void)initSubviews {
    self.layer.cornerRadius = 10;
    
    [self addSubview:self.titleBtn];
    [self addSubview:self.scrollView];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.tipLable];
    
    [self.scrollView addSubview:self.tipContactLable];
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.needAdjustmentView];
    [self.scrollView addSubview:self.noticeLable];
    
    TXRecapitalizeTabItemView *headerView = [[TXRecapitalizeTabItemView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 20, 50) isHeader:YES];
    [self.tableView addSubview:headerView];
    
    [self.needAdjustmentView addSubview:self.needAdjustmentLable];
    [self.needAdjustmentView addSubview:self.needAdjustmentContentLable];
}

- (void)didLayoutSubviews {
    self.titleBtn.frame = CGRectMake(0, 0, (kScreenWidth - 24), 45);
     
    self.tipContactLable.frame = CGRectMake(10, 15, self.bounds.size.width - 20, 100);
    [self.tipContactLable sizeToFit];
 
    for (int i = 0; i < self.tabItemViews.count; i++) {
        TXRecapitalizeTabItemView *itemView = self.tabItemViews[i];
        if (i == self.tabItemViews.count - 1) {
            itemView.frame = CGRectMake(0, 50 * (i + 1), self.bounds.size.width - 20, 49.5);
        } else {
            itemView.frame = CGRectMake(0, 50 * (i + 1), self.bounds.size.width - 20, 50);
        }
    }
    self.tableView.frame = CGRectMake(10,  CGRectGetMaxY(self.tipContactLable.frame) + 18,self.bounds.size.width - 20, self.tabItemViews.count * 50 + 50);
    if (self.hasNeedAdjustmentContent) {
        self.needAdjustmentLable.frame = CGRectMake(14, 12, kScreenWidth - 72, 14);
        self.needAdjustmentContentLable.frame = CGRectMake(10,  CGRectGetMaxY(self.needAdjustmentLable.frame) + 14,self.bounds.size.width - 40, 137.5);
        [self.needAdjustmentContentLable sizeToFit];
        self.needAdjustmentView.frame = CGRectMake(10,  CGRectGetMaxY(self.tableView.frame) + 16,self.bounds.size.width - 20, CGRectGetMaxY(self.needAdjustmentContentLable.frame) + 14);
    } else {
        self.needAdjustmentLable.frame = CGRectMake(14, 12, kScreenWidth - 72, 0); 
        self.needAdjustmentContentLable.frame = CGRectZero;
        [self.needAdjustmentContentLable sizeToFit];
        self.needAdjustmentView.frame = CGRectMake(10,  CGRectGetMaxY(self.tableView.frame) + 16,self.bounds.size.width - 20, 0);
    }
    self.noticeLable.frame = CGRectMake(10, CGRectGetMaxY(self.needAdjustmentView.frame) + 14.5, self.bounds.size.width - 20, 100);
    [self.noticeLable sizeToFit];
    
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, CGRectGetMaxY(self.noticeLable.frame));
    
    CGFloat scrollHeight = CGRectGetMaxY(self.noticeLable.frame);
    CGFloat scrollMaxHeight = kScreenHeight - TXNavigationAddsionStatusHeight() - TXTabBarHeight() - 168 - 40;
    self.scrollView.frame = CGRectMake(0, 45, self.bounds.size.width, MIN(scrollHeight, scrollMaxHeight));
    
    self.confirmBtn.frame = CGRectMake(18, CGRectGetMaxY(self.scrollView.frame) + 27.5, self.bounds.size.width - 36, 48);
 
    self.tipLable.frame = CGRectMake(10, CGRectGetMaxY(self.confirmBtn.frame) + 17, self.bounds.size.width - 20, 100);
    [self.tipLable sizeToFit];
     
    self.frame = CGRectMake(0, 0, kScreenWidth - 24, CGRectGetMaxY(self.tipLable.frame) + 17);
}

#pragma mark - Event

- (void)confirmAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(recapitalizeViewDidConfirm:)]) {
        [self.delegate recapitalizeViewDidConfirm:self];
    }
}

#pragma mark - TXBaseAlertViewProtocol

- (CGSize)preferredContentSizeInAlertView:(TXBaseAlertView *)alertView limitSize:(CGSize)limitSize {
    return self.bounds.size;
}

#pragma mark - Public
  
- (void)setExceptions:(NSArray<TXExceptionModel *> *)exceptions {
    for (TXRecapitalizeTabItemView *itemView in self.tabItemViews) {
        [itemView removeFromSuperview];
    }
    [self.tabItemViews removeAllObjects];
    [exceptions enumerateObjectsUsingBlock:^(TXExceptionModel * _Nonnull exception, NSUInteger idx, BOOL * _Nonnull stop) {
        TXRecapitalizeTabItemView *itemView = [[TXRecapitalizeTabItemView alloc] initWithFrame:CGRectMake(0, idx * 50, self.bounds.size.width - 20, 50) isHeader:NO];
        [itemView setTime:exception.formatTime action:exception.formatOperation detail:exception.formatDetail];
        [self.tableView addSubview:itemView];
        [self.tabItemViews addObject:itemView];
    }];
    [self didLayoutSubviews];
} 

- (void)setSolutionSteps:(NSString *)formatSolutionSteps {
    self.hasNeedAdjustmentContent = (formatSolutionSteps != nil && formatSolutionSteps.length > 0);
    self.needAdjustmentContentLable.text = formatSolutionSteps;
    [self didLayoutSubviews];
} 
#pragma mark - Private

- (NSMutableAttributedString *)buildAttriWithPrefix:(NSString *)prefix content:(NSString *)content suffix:(NSString *)suffix {
    NSString *string = [NSString stringWithFormat:@"%@%@%@",prefix,content,suffix];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
     [attString addAttribute:NSForegroundColorAttributeName value:[UIColor tx_colorNamed:@"#767676"] range:NSMakeRange(0, prefix.length)];
     [attString addAttribute:NSForegroundColorAttributeName value:[UIColor tx_colorNamed:@"#FFFFFF"] range:[string rangeOfString:content]];
    return attString;
}
 
#pragma mark - Getter/Setter

- (NSMutableArray<TXRecapitalizeTabItemView *> *)tabItemViews {
    if (!_tabItemViews) {
        _tabItemViews = [NSMutableArray array];
    }
    return _tabItemViews;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGRect frame = CGRectMake(0, 45, self.bounds.size.width, kScreenHeight - 155 - 89 - 27.5);
        UIScrollView *view = [[UIScrollView alloc]initWithFrame:frame];
        view.backgroundColor = [UIColor tx_colorNamed:@"#1E2024"];
        _scrollView = view;
    }
    return _scrollView;
}
   
- (UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.frame = CGRectMake(0, 0, (kScreenWidth - 24), 45);
        _titleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        [_titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"recapitalize_confirm_icon"] forState:UIControlStateNormal];
        _titleBtn.backgroundColor = [UIColor tx_colorNamed:@"#181A1C"];
        [_titleBtn setTitle:@"调整确认" forState:UIControlStateNormal];
        [_titleBtn setupImageStyle:(TXButtonImageStyleLeft) spacing:6.5];
        _titleBtn.enabled = NO;
    }
    return _titleBtn;
}

- (UIView *)tableView {
    if (!_tableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 42, 144)];
        view.backgroundColor = [UIColor tx_colorNamed:@"#181A1C"];
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor tx_colorNamed:@"#0E0F0F"].CGColor;
        _tableView = view;
    }
    return _tableView;
}

- (UIView *)needAdjustmentView {
    if (!_needAdjustmentView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 42, 137)];
        view.backgroundColor = [UIColor tx_colorNamed:@"#181A1C"];
        view.layer.cornerRadius = 10;
        _needAdjustmentView = view;
    }
    return _needAdjustmentView;
}

- (UILabel *)needAdjustmentLable {
    if (!_needAdjustmentLable) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(14, 12, kScreenWidth - 72, 14)];
        _needAdjustmentLable = view;
        _needAdjustmentLable.textAlignment = NSTextAlignmentLeft;
        _needAdjustmentLable.numberOfLines = 0;
        _needAdjustmentLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _needAdjustmentLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _needAdjustmentLable.text = @"所需调整：";
    }
    return _needAdjustmentLable;
}
 
- (UILabel *)needAdjustmentContentLable {
    if (!_needAdjustmentContentLable) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 42, 137)];
        _needAdjustmentContentLable = view;
        _needAdjustmentContentLable.textAlignment = NSTextAlignmentLeft;
        _needAdjustmentContentLable.numberOfLines = 0;
        _needAdjustmentContentLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _needAdjustmentContentLable.textColor = [UIColor tx_colorNamed:@"#FFFFFF"];
        _needAdjustmentContentLable.text = @"";
    }
    return _needAdjustmentContentLable;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_confirmBtn setTitleColor:[UIColor tx_colorNamed:@"#976C1C"] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [UIColor tx_colorNamed:@"#FFD87E"];
        [_confirmBtn setTitle:@"确认并立即调整" forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 5;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}
 
- (UILabel *)tipContactLable {
    if (!_tipContactLable) {
        UILabel *tipContactLable = [[UILabel alloc] init];
        _tipContactLable = tipContactLable;
        _tipContactLable.textAlignment = NSTextAlignmentLeft;
        _tipContactLable.numberOfLines = 0;
        _tipContactLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        _tipContactLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _tipContactLable.text = @"经过期智行客服与您沟通，您申请期智行对您的资产单元做出如下调整，请点击确认是否立即调整：";
    }
    return _tipContactLable;
}

- (UILabel *)noticeLable {
    if (!_noticeLable) {
        UILabel *noticeLable = [[UILabel alloc] init];
        _noticeLable = noticeLable;
        _noticeLable.textAlignment = NSTextAlignmentLeft;
        _noticeLable.numberOfLines = 0;
        _noticeLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        _noticeLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _noticeLable.text = @"注：点击确认并立即调整后系统将为您恢复量化模式功能的使用。如有疑问，请联系您的专属客服，我们将竭诚为您服务。";
    }
    return _noticeLable;
}

- (UILabel *)tipLable {
    if (!_tipLable) {
        UILabel *tipLable = [[UILabel alloc] init];
        _tipLable = tipLable;
        _tipLable.textAlignment = NSTextAlignmentLeft;
        _tipLable.numberOfLines = 0;
        _tipLable.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        _tipLable.textColor = [UIColor tx_colorNamed:@"#767676"];
        _tipLable.text = @"温馨提示：您的策略已被暂停，点击确认后您需要进入PC端点击运行方可恢复量化策略运行。";
    }
    return _tipLable;
}
  
@end
