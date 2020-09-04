
//
//  TXActivationContentViewController.m
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXActivationContentViewController.h"
#import "TXActivationLoadingView.h"
#import "TXActivationStatusView.h"
 
@interface TXActivationContentViewController ()<TXActivationStatusViewDelegate>
@property (nonatomic, strong) TXActivationLoadingView *loadingView;
@property (nonatomic, strong) TXActivationStatusView *statusView; 
@end

@implementation TXActivationContentViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
    self.view.layer.cornerRadius = 10;
    
    [self.view addSubview:self.loadingView];
    [self.view addSubview:self.statusView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.loadingView updateProgress:1];
    
    [self.statusView updateStatus:(TXActivationStatusSuccess)];
    self.loadingView.hidden = self.statusView.hidden;
    self.statusView.hidden = !self.loadingView.hidden;
}

#pragma mark - TXActivationStatusViewDelegate

- (void)activationStatusView:(TXActivationStatusView *)activationStatusView
        didConfirmWithStatus:(TXActivationStatus)status{
    [[self getModalVC] hideWithAnimated:YES completion:nil];
}

#pragma mark - TXModalPresentationContentViewProtocol

- (CGSize)preferredContentSizeInModalPresentationVC:(TXModalPresentationViewController *)controller
                                          limitSize:(CGSize)limitSize {
    return CGSizeMake(kScreenWidth, TXAdaptHeight(491));
}
  
#pragma mark - Getter/Setter

- (TXActivationLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[TXActivationLoadingView alloc] initWithFrame:self.view.bounds];
        [_loadingView updateProgress:0.0];
    }
    return _loadingView;
}

- (TXActivationStatusView *)statusView {
    if (!_statusView) {
        _statusView = [[TXActivationStatusView alloc] initWithFrame:self.view.bounds];
        _statusView.hidden = YES;
        _statusView.delegate = self;
    }
    return _statusView;
}

@end
