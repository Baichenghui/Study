//
//  ViewController.m
//  CopyTest
//
//  Created by 白成慧&瑞瑞 on 2019/3/16.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *p1 = [[Person alloc] init];
    p1.name = [NSString stringWithFormat:@"abc"];
//    p1.age = 10;
    
    NSLog(@"p1 name:%@  ",p1.name );
    NSLog(@"p1:%p   p1 name:%p    ",p1,p1.name );
    
    Person *p2 = [p1 copy];
//    p2.name = @"def";
//    p2.age = 20;
    
    NSLog(@"p2 name:%@    age:%zd",p2.name);
    NSLog(@"p2:%p   p2 name:%p  ",p2,p2.name);
}


@end
