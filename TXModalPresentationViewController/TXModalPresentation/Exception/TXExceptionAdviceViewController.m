//
//  TXExceptionAdviceViewController.m
//  QZX
//
//  Created by tianxi on 2020/8/25.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXExceptionAdviceViewController.h"
#import "TXExceptionAdviceView.h"

@interface TXExceptionAdviceViewController ()<TXExceptionAdviceViewDelegate>
@property (nonatomic, strong) TXExceptionAdviceView *exceptionAdviceView;
@end

@implementation TXExceptionAdviceViewController
  
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    [self.view addSubview:self.exceptionAdviceView]; 
}
 
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - TXModalPresentationContentViewProtocol

- (CGSize)preferredContentSizeInModalPresentationVC:(TXModalPresentationViewController *)controller
                                          limitSize:(CGSize)limitSize {
    return self.exceptionAdviceView.bounds.size;
}

#pragma mark - TXExceptionAdviceViewDelegate
 
- (void)exceptionAdviceViewDidApply:(TXExceptionAdviceView *)exceptionAdviceView {
    
}

- (void)exceptionAdviceViewDidToggle:(TXExceptionAdviceView *)exceptionAdviceView {
    
}

#pragma mark - Getter/Setter

- (TXExceptionAdviceView *)exceptionAdviceView {
    if (!_exceptionAdviceView) {
        _exceptionAdviceView = [[TXExceptionAdviceView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, 355)];
        _exceptionAdviceView.delegate = self;
        [_exceptionAdviceView setApplyed:YES];
    }
    return _exceptionAdviceView;
}

@end
