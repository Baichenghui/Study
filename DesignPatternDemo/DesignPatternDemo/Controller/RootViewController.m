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
    
    self.title = @"设计模式学习Demo";
    _lists = @[
        @{
            @"创建型设计模式":@[
                    @{@"SimpleFactoryVC":@"简单工厂模式"},
                    @{@"FactoryVC":@"工厂模式"},
                    @{@"AbstructFactoryVC":@"抽象工厂模式"},
                    @{@"SingletonVC":@"单利模式"},
                    @{@"BuilderVC":@"建造者模式"},
                    @{@"PrototypeVC":@"原型模式"}]
        },
        @{
            @"结构型设计模式":@[
                    @{@"AdapterVC":@"适配器模式"},
                    @{@"DecoratorVC":@"装饰模式"},
                    @{@"ProxyVC":@"代理模式"},
                    @{@"FacadeVC":@"外观模式"},
                    @{@"BridgeVC":@"桥接模式"},
                    @{@"CompositeVC":@"组合模式"},
                    @{@"FlyweightVC":@"享元模式"}]
        },
        @{
            @"行为型设计模式":@[
                    @{@"StrategyVC":@"策略模式"},
                    @{@"TemplateMethodVC":@"模板方法模式"},
                    @{@"ObserverVC":@"观察者模式"},
                    @{@"IteratorVC":@"迭代子模式"},
                    @{@"ChainOfResponsibilityVC":@"责任链模式"},
                    @{@"CommandVC":@"命令模式"},
                    @{@"MementoVC":@"备忘录模式"},
                    @{@"StateVC":@"状态模式"},
                    @{@"VisitorVC":@"访问者模式"},
                    @{@"MediatorVC":@"中介者模式"},
                    @{@"InterpreterVC":@"解释器模式"} ]
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
     
    NSString *className = rows[indexPath.row].allKeys.firstObject;
    NSString *title = rows[indexPath.row].allValues.firstObject; 
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = title;
    [self.navigationController pushViewController:controller animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
