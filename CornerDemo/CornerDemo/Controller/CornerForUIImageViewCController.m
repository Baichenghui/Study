//
//  CornerForUIImageViewCController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUIImageViewCController.h"
#import "CoverCornerImageView.h"

#define kHeight 20

/**
 在 UIImageView 上添加一个四个角有内容，其它部分是透明的视图，只对 UIImageView 圆角部分进行遮挡。
 但要保证被遮挡的部分背景色要与周围背景相同，避免穿帮。
 所以当 UIImageView 处于一个复杂的背景时，是不适合使用这个方法的
 当只需要每个圆角，或者圆角半径有大有小，需要各种圆角图。
 
 Color Misaligned Images 检测：显示黄色
 如果图片需要缩放则标记为黄色，如果没有像素对齐则标记为紫色。
 由于圆角中间部分是透明的，而且圆角遮罩会缩放

 */

@interface CornerForUIImageViewCController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CornerForUIImageViewCController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIImageView 绘制四个角的遮罩 设置圆角";
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    NSInteger total = CGRectGetWidth(self.view.frame)/(kHeight + 5);
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        for (int i=1; i<=total; i++) {
            CoverCornerImageView *imageView = [[CoverCornerImageView alloc] initWithFrame:CGRectMake((kHeight + 5) * (i-1) + 8, 2, kHeight, kHeight)];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.image = [UIImage imageNamed:@"popup_box_ai_header_img"];
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
