//
//  CornerForUITextFieldController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUITextFieldController.h"

#define kHeight 20

@interface CornerForUITextFieldController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;  
@end

@implementation CornerForUITextFieldController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UITextField设置圆角";
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    NSInteger total = CGRectGetWidth(self.view.frame)/kHeight;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        for (int i=1; i<=total; i++) {
            UITextField *imageView = [[UITextField alloc]initWithFrame:CGRectMake(kHeight * (i-1) + 8, 2, kHeight, kHeight)];
            // 天然支持设置圆角边框
            //textField.borderStyle = UITextBorderStyleRoundedRect;
            // 与 UIView 类似
            imageView.layer.cornerRadius = kHeight * 0.5;
            imageView.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:imageView];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight+4;
}
 
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
 
@end
