//
//  TXBaseModalPresentationViewController.m
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXBaseModalPresentationViewController.h"

@interface TXBaseModalPresentationViewController()
@property (nonatomic, weak) TXModalPresentationViewController *modalVC; 
@end

@implementation TXBaseModalPresentationViewController

- (instancetype)initWithModalPresentationController:(TXModalPresentationViewController *)modalVC {
    if (self = [super init]) {
        self.modalVC = modalVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (TXModalPresentationViewController *)getModalVC {
    return self.modalVC;
}

#pragma mark - TXModalPresentationContentViewProtocol

- (CGSize)preferredContentSizeInModalPresentationVC:(TXModalPresentationViewController *)controller
                                          limitSize:(CGSize)limitSize {
    return CGSizeZero;
} 

@end
