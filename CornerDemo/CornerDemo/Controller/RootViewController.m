//
//  RootViewController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "RootViewController.h"
#import "YYFPSLabel.h"

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
    
    self.title = @"圆角";
    _lists = @[
        @{ @"设置视图圆角":
               @[@{@"CornerForUIView":@"UIVIew设置圆角"},
                @{@"CornerForUITextField":@"UITextField设置圆角"},
                @{@"CornerForUITextView":@"UITextView设置圆角"},
                @{@"CornerForUILabel":@"UILabel设置圆角"},
                @{@"CornerForUIButton":@"UIButton设置圆角"},
                @{@"CornerForUIImageView":@"UIImageView设置圆角"}]
        },
        @{
            @"设置视图阴影":@[@{@"ShadowForView":@"各视图设置阴影"}]
        }
    ];
     
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    YYFPSLabel *lable = [[YYFPSLabel alloc] initWithFrame:CGRectMake(240,0,100,44)];
    lable.backgroundColor = [UIColor whiteColor];
    [keyWindow addSubview:lable];
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
    NSString *className = [name stringByAppendingString:@"Controller"];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = name;
    [self.navigationController pushViewController:controller animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
