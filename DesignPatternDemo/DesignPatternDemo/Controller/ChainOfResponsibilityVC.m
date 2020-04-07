//
//  ChainOfResponsibilityVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ChainOfResponsibilityVC.h"
#import "ChainManagerLevel1.h"
#import "ChainManagerLevel2.h"
#import "ChainManagerLevel3.h"


@interface ChainOfResponsibilityVC ()

@end

@implementation ChainOfResponsibilityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AbstructChainManager *l1 = [ChainManagerLevel1 new];
    AbstructChainManager *l2 = [ChainManagerLevel2 new];
    AbstructChainManager *l3 = [ChainManagerLevel3 new];
    
    [l1 configChain:l2];
    [l2 configChain:l3];
    
    NSArray *requests = @[@1,@2,@10,@5,@2,@3,@1,@3,@2];
    for (NSNumber *requestNum in requests) {
        NSInteger request = [requestNum integerValue];
        [l1 request:request];
    }
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
