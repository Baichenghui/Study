//
//  CornerForUIImageViewController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUIImageViewController.h"

@interface CornerForUIImageViewController (){ 
    NSDictionary *_items;
    NSDictionary *_itemsName;
}

@end

@implementation CornerForUIImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"UIImageView圆角";
    _items = @{
               @"UIImageView设置圆角方式":@[
                       @"CornerForUIImageViewA",
                       @"CornerForUIImageViewB",
                       @"CornerForUIImageViewC",
                       @"CornerForUIImageViewD",
                       @"CornerForUIImageViewE",
                       ],
             };
    
    _itemsName = @{
               
                   @"Test":@[
                           @"截取图片方式（性能较好，基本不掉帧）",
                           @"设置mask（不推荐，离屏渲染）",
                           @"绘制四个角的遮罩（使用场景受限）",
                           @"cornerRadius & masksToBounds（多个圆角时不推荐做法）",
                           @"加载网络图片",
                           ],
               };
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
  
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_items allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_items allKeys][section];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_items objectForKey:[_items allKeys][section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text =  [_itemsName objectForKey:[_itemsName allKeys][indexPath.section]][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name =  [_items objectForKey:[_items allKeys][indexPath.section]][indexPath.row];
    NSString *className = [name stringByAppendingString:@"Controller"];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = name;
    [self.navigationController pushViewController:controller animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
