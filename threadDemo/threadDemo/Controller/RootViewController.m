//
//  RootViewController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController (){
    NSArray *_lists;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"GCD";
    _lists = @[
        @{ @"对列":
               @[@{@"GCDSerialQueue":@"Serial Dispatch Queue"},
                @{@"GCDConcurrentQueue":@"Concurrent Dispatch Queue"} ]
        },
        @{
            @"任务":@[@{@"GCDDispatchSync":@"dispatch_sync"},
                    @{@"GCDDispatchAsync":@"dispatch_async"} ]
        },
        @{
            @"其他函数":@[@{@"GCDDispatchGroup":@"dispatch_group"},
             @{@"GCDDispatchSemaphore":@"dispatch_semaphore"},
             @{@"GCDDispatchBarrier":@"dispatch_barrier"},
             @{@"GCDDispatchOnce":@"dispatch_once"},
             @{@"GCDDispatchApply":@"dispatch_apply"},
             @{@"GCDDispatchAfter":@"dispatch_after"} ]
        },
        @{
            @"Dispatch Source":@[@{@"GCDDispatchTimer":@"GCD 定时器"}]
        },
        @{
            @"demo test":@[@{@"ThreadSafeMutableArray":@"线程安全的可变数组"},
                           @{@"ThreadSafeMutableDictionary":@"线程安全的可变字典"}]
        }
    ];
     
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_lists count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dict = _lists[section];
    return dict.allKeys.firstObject;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict = _lists[section];
    NSArray *values = dict.allValues;
    NSArray <NSDictionary *> *rows = values.firstObject;
    
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
     
    NSDictionary *dict = _lists[indexPath.section];
    NSArray *values = dict.allValues;
    NSArray <NSDictionary *> *rows = values.firstObject;
    
    cell.textLabel.text = rows[indexPath.row].allValues.firstObject;
    cell.textLabel.backgroundColor = [UIColor whiteColor];
    cell.textLabel.layer.masksToBounds = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = _lists[indexPath.section];
    NSArray *values = dict.allValues;
    NSArray <NSDictionary *> *rows = values.firstObject;
     
    NSString *name = rows[indexPath.row].allKeys.firstObject;
    NSString *value = rows[indexPath.row].allValues.firstObject;
    NSString *className = [name stringByAppendingString:@"Controller"];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = value;
    [self.navigationController pushViewController:controller animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
