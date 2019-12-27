//
//  CornerForUIViewController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUIViewController.h"
#import "UIView+Add.h"
#import "CornerView.h"

#define kHeight 20

/**
 1、对于 contents 无内容或者内容的背景透明(无涉及到圆角以外的区域)的layer，直接设置layer的 backgroundColor 和 cornerRadius 属性来绘制圆角:
    UIView的contents无内容可以直接通过设置cornerRadius达到效果。
    UILable的contents也一样，所以也可通过
 设置cornerRadius达到效果。不过label不能直接设置backgroundColor，因为这样设置的是contents的backgroundColor，需要设置layer. backgroundColor。
 
 2、注意点：UIView 只要设置图层的 cornerRadius 属性即可（不明白的话，可以看看官方文档里对 cornerRadius 的描述），如果设置 layer.masksToBounds = YES，会造成不必要的离屏渲染。

 3、单独某个方向的圆角/特殊情况需要设置layer.masksToBounds，就不要通过cornerRadius方式了
 
 */
@interface CornerForUIViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CornerForUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIView设置圆角";
    
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
            if (i % 2 == 0) {
                UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(kHeight * (i-1) + 8, 2, kHeight, kHeight)];
                imageView.backgroundColor = [UIColor orangeColor];
                imageView.layer.cornerRadius = kHeight * 0.5;
                [cell.contentView addSubview:imageView];
            }
            else {
                if (i % 3 == 0) {
                    CornerView *imageView = [[CornerView alloc]initWithFrame:CGRectMake(kHeight * (i-1) + 8, 2, kHeight, kHeight)];
                    [imageView cornerWithRadius:kHeight * 0.5 size:CGSizeMake(kHeight, kHeight) corner:(UIRectCornerTopRight | UIRectCornerBottomLeft) fillColor:[UIColor redColor]];
                    [cell.contentView addSubview:imageView];
                }
                else {
                    //通过分类实现
                    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(kHeight * (i-1) + 8, 2, kHeight, kHeight)];
                    [imageView cc_addRounderCornerWithRadius:kHeight * 0.5 size:CGSizeMake(kHeight, kHeight) corners:(UIRectCornerTopLeft | UIRectCornerBottomRight)];
                    [cell.contentView addSubview:imageView];
                }
            }
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
