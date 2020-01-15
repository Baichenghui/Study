//
//  ViewController.m
//  BCHTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/16.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "ViewController.h"
#import "BCHTimer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [BCHTimer executeTask:^{
        NSLog(@"%@",[NSThread currentThread]);
    } start:1 interval:1 repeats:NO async:YES];
}



@end
