//
//  TXActivationConfirmViewController.m
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXActivationConfirmViewController.h"
#import "TXActivationContentViewController.h"
#import "TXActivationConfirmView.h"

@interface TXActivationConfirmViewController ()<TXActivationConfirmViewDelegate> 
@property (nonatomic, strong) TXActivationConfirmView *confirmView;
@end

@implementation TXActivationConfirmViewController
  
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
     
    [self.view addSubview:self.confirmView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - TXModalPresentationContentViewProtocol

- (CGSize)preferredContentSizeInModalPresentationVC:(TXModalPresentationViewController *)controller
                                          limitSize:(CGSize)limitSize {
    return self.confirmView.bounds.size;
}

#pragma mark - TXActivationConfirmViewDelegate

- (void)activationConfirmViewDidConfirm:(TXActivationConfirmView *)activationConfirmView {
    [[self getModalVC] hideWithAnimated:YES completion:nil];
    
    TXModalPresentationViewController *modalVC = [[TXModalPresentationViewController alloc] init];
    TXActivationContentViewController *contentVC = [[TXActivationContentViewController alloc] initWithModalPresentationController:modalVC];
    modalVC.animationStyle = TXModalPresentationAnimationStyleSlide;
    modalVC.contentViewController = contentVC;
    modalVC.contentViewMargins = UIEdgeInsetsZero;
    __weak typeof(modalVC) weakModalVC = modalVC;
    __weak typeof(contentVC) weakContentVC = contentVC;
    modalVC.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        weakModalVC.contentViewFrameApplyTransform = CGRectSetXY(weakContentVC.view.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(weakContentVC.view.frame)), CGRectGetHeight(containerBounds) - CGRectGetHeight(weakContentVC.view.frame));
    };
    [modalVC showWithAnimated:YES completion:nil];
}

#pragma mark - Getter/Setter

- (TXActivationConfirmView *)confirmView {
    if (!_confirmView) {
        _confirmView = [[TXActivationConfirmView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, 268)];
        _confirmView.delegate = self;
    }
    return _confirmView;
}

@end
