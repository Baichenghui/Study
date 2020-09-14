//
//  ViewController.m
//  Test
//
//  Created by tianxi on 2019/10/30.
//  Copyright © 2019 tianxi. All rights reserved.
//

#import "ViewController.h"
#import "JLRoutes.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *btnA;
@property (nonatomic, strong) UIButton *btnB;
@property (nonatomic, strong) UIButton *btnC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btnA = [self buildButtonWithTarget:self action:@selector(actionA:) title:@"A"];
    self.btnB = [self buildButtonWithTarget:self action:@selector(actionB:) title:@"B"];
    self.btnC = [self buildButtonWithTarget:self action:@selector(actionC:) title:@"C"];
    
    [self.view addSubview:self.btnA];
    [self.view addSubview:self.btnB];
    [self.view addSubview:self.btnC];
}

- (void)viewDidLayoutSubviews{
    self.btnA.frame = CGRectMake(100, 100, 100, 100);
    self.btnB.frame = CGRectMake(100, 300, 100, 100);
    self.btnC.frame = CGRectMake(100, 500, 100, 100);
}

- (void)actionA:(id)sender {
    NSString *customURL = @"SKJLRoute://NaPush/AViewController?userID=20";
    [[JLRoutes globalRoutes] routeURL:[NSURL URLWithString:customURL]];
}

- (void)actionB:(id)sender {
    NSString *customURL = @"SKJLRoute://Present/BViewController?userID=20";
    [[JLRoutes globalRoutes] routeURL:[NSURL URLWithString:customURL]];
}

- (void)actionC:(id)sender {
    NSString *customURL = @"SKJLRoute://Present/CViewController?userID=20";
    [[JLRoutes routesForScheme:@"xxx"] routeURL:[NSURL URLWithString:customURL]];
//    [JLRoutes routeURL:[NSURL URLWithString:customURL]];
}

- (UIButton *)buildButtonWithTarget:(id)target action:(SEL)selector title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
