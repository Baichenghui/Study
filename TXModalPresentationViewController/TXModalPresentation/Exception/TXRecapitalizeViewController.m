//
//  TXRecapitalizeViewController.m
//  QZX
//
//  Created by tianxi on 2020/8/26.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXRecapitalizeViewController.h"
#import "TXRecapitalizeView.h"

@interface TXRecapitalizeViewController ()<TXRecapitalizeViewDelegate>
@property (nonatomic, strong) TXRecapitalizeView *recapitalizeView;
@end

@implementation TXRecapitalizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor tx_colorNamed:@"#202222"];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    [self.view addSubview:self.recapitalizeView];
    
//    [self.recapitalizeView setNeedAdjustmentContent:[NSString stringWithFormat:
//                                                     @"%@\n%@\n%@\n%@",
//                                                     @"【手动资产单元】：  -400000.00",
//                                                     @"【策略资产单元1】：-100000.00",
//                                                     @"【手动动产单元】：焦炭、买开   3手  1980.5  ",
//                                                     @"【手动动产单元】： 焦炭、卖平 3手 1970.5"]];
//    
//    [self.recapitalizeView setTabsContents:@[
//    @{@"time":@"2020-08-0712:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0713:30",@"action":@"出金",@"detail":@"-500000.00"},
//    @{@"time":@"2020-08-0722:30",@"action":@"入金",@"detail":@"500000.00"}]];
} 

#pragma mark - TXModalPresentationContentViewProtocol

- (CGSize)preferredContentSizeInModalPresentationVC:(TXModalPresentationViewController *)controller
                                          limitSize:(CGSize)limitSize {
    return self.recapitalizeView.bounds.size;
}
 
#pragma mark - TXRecapitalizeViewDelegate

- (void)recapitalizeViewDidConfirm:(TXRecapitalizeView *)recapitalizeView {
    [[self getModalVC] hideWithAnimated:YES completion:nil];
}

#pragma mark - Getter/Setter

- (TXRecapitalizeView *)recapitalizeView {
    if (!_recapitalizeView) {
        _recapitalizeView = [[TXRecapitalizeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, kScreenHeight - 89)];
        _recapitalizeView.delegate = self;
    }
    return _recapitalizeView;
}

@end
