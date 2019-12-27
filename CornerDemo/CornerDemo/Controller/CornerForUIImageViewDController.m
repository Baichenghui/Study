//
//  CornerForUIImageViewDController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUIImageViewDController.h"

#define kHeight 20

/**
 最不推荐做法（当一个页面只有少量圆角图片时才推荐使用）
 
 设置 layer.masksToBounds = YES，会造成离屏渲染。
 
 但是在iOS10之后使用该方式，性能方面有很大的提升，会复用缓存，当圆角不是特别多，可以使用该方式设置圆角
 
 Color Hits Green and Misses Red  检测：显示绿色
 如果shouldRasterize被设置成YES，对应的渲染结果会被缓存，如果图层是绿色，就表示这些缓存被复用；
 如果是红色就表示缓存会被重复创建，这就表示该处存在性能问题了。
 
 */

@interface CornerForUIImageViewDController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CornerForUIImageViewDController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIImageView 最不推荐做法 设置圆角";
    
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
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kHeight + 5) * (i-1) + 8, 2, kHeight, kHeight)];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.layer.cornerRadius = kHeight * 0.5;
            imageView.layer.masksToBounds = YES;
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
