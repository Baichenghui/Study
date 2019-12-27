//
//  CornerForUILabelController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUILabelController.h"

#define kHeight 20

/*
 注意： 设置视图的图层背景色，千万不要直接设置 label.backgroundColor
       而是：label.layer.backgroundColor = [UIColor grayColor].CGColor;
 */
@interface CornerForUILabelController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation CornerForUILabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UILable设置圆角";
    
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
            UILabel *imageView = [[UILabel alloc]initWithFrame:CGRectMake(kHeight * (i-1) + 8, 2, kHeight, kHeight)];
            imageView.numberOfLines = 3;
            imageView.font = [UIFont systemFontOfSize:10];
            imageView.text = [NSString stringWithFormat:@"row:%ld index:%d",indexPath.row, i];
            // 千万不要直接设置 label.backgroundColor
            imageView.layer.backgroundColor = [UIColor grayColor].CGColor;
            imageView.layer.cornerRadius = 10;
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
