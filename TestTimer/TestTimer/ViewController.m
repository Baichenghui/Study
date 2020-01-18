//
//  ViewController.m
//  TestTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/15.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "ViewController.h"

#import "AViewController.h"

@interface ViewController ()
@end

@implementation ViewController
- (IBAction)action:(id)sender {
    
    AViewController *vc = [[AViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     
}


@end
