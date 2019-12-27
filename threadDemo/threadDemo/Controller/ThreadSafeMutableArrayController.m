//
//  ThreadSafeMutableArrayController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/25.
//  Copyright © 2019 hh. All rights reserved.
//

#import "ThreadSafeMutableArrayController.h"
#import "ThreadSafeMutableArray.h"

@interface ThreadSafeMutableArrayController ()

@end

@implementation ThreadSafeMutableArrayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ThreadSafeMutableArray *safeArr = [[ThreadSafeMutableArray alloc] init];
      
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for ( int i = 0; i < 1000; i ++) {
        dispatch_async(queue, ^{

            NSLog(@"添加第%d个",i);
            [safeArr addObject:[NSString stringWithFormat:@"%d",i]];

        });

        dispatch_async(queue, ^{

            NSLog(@"删除第%d个",i);
            [safeArr removeObjectAtIndex:i];

        });
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
