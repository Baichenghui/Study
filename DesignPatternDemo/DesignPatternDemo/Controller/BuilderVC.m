//
//  BuilderVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "BuilderVC.h"
#import "DateBuilder.h"
#import "BuilderDirector.h"

@interface BuilderVC ()

@end

@implementation BuilderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DateBuilder *builder = [DateBuilder new];
    
    BuilderDirector *director = [BuilderDirector new];
    [director builderWithbuilder:builder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
