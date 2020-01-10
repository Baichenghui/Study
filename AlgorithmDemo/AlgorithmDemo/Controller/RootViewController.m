//
//  RootViewController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController (){
    NSArray *_lists;
    NSDictionary *_items;
    NSDictionary *_itemsName;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"图解算法学习Demo";
    _lists = @[
        @{
            @"算法简介":@[@{@"BinarySearch":@"二分查找"}]
        },
        @{
            @"选择排序":@[@{@"SelectionSort":@"选择排序"}]
        },
        @{
            @"递归":@[@{@"Recursion":@"递归"}]
        },
        @{
            @"快速排序":@[@{@"QuickSort":@"二分查找"}]
        },
        @{
            @"散列表":@[@{@"HashTable":@"散列表"}]
        },
        @{
            @"广度优先搜索":@[@{@"BreadthFirstSearch":@"广度优先搜索"}]
        },
        @{
            @"狄克斯特拉算法":@[@{@"DixstraAlgorithm":@"狄克斯特拉算法"}]
        },
        @{
            @"贪婪算法":@[@{@"GreedyAlgorithm":@"贪婪算法"}]
        },
        @{
            @"K最近邻算法":@[@{@"KNearestNeighborAlgorithm":@"K最近邻算法"}]
        },
        @{
            @"接下来如何做":@[@{@"Tree":@"树"}
                        ,@{@"InvertedIndex":@"反向索引"}
                        ,@{@"ParallelAlgorithm":@"并行算法"}
                        ,@{@"FourierTransform":@"傅里叶变换"}
                        ,@{@"MapReduce":@"MapReduce"}
                        ,@{@"HyperogLog":@"HyperogLog"}
                        ,@{@"ShaAlgorithm":@"SHA算法"}
                        ,@{@"HashTableAlgorithm":@"k局部敏感的散列算法"}
                        ,@{@"DiffeHellman":@"DiffeHellman密钥交换"}
                        ,@{@"LinearProgramming":@"线性规划"}]
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
    NSString *title = rows[indexPath.row].allValues.firstObject;
    NSString *className = [name stringByAppendingString:@"Controller"];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = title;
    [self.navigationController pushViewController:controller animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
