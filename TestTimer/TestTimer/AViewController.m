//
//  AViewController.m
//  TestTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/15.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "AViewController.h"
#import "BCHProxy.h"
#import "BCHProxy1.h"

@interface AViewController ()

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[BCHProxy1 proxyWithTarget:self] selector:@selector(testTimer) userInfo:nil repeats:YES];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)testTimer {
    NSLog(@"%s",__FUNCTION__);
}

- (void)btnAction:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    [self.timer invalidate];
}

@end
