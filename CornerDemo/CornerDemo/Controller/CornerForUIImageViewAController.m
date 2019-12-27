//
//  CornerForUIImageViewAController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUIImageViewAController.h"
#import "UIImage+Add.h"
 
#define kHeight 20

/**
 1、本地图片圆角设置
    [image  cc_imageCornerWithRadius:20 corners:UIRectCornerTopRight andSize:CGSizeMake(kHeight, kHeight)];
 
 2、网络图片圆角设置
    YYWebImage
    SDWebImage 拓展修改实现
 */

@interface CornerForUIImageViewAController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation CornerForUIImageViewAController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIImageView 截取图片方式 设置圆角";
    
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
        UIImage *reSizeImage = [[UIImage imageNamed:@"popup_box_ai_header_img"] cc_imageByResizeToSize:CGSizeMake(kHeight, kHeight) contentMode:(UIViewContentModeScaleAspectFill)];
        UIImage *image = [reSizeImage cc_imageCornerWithRadius:20 corners:UIRectCornerTopRight|UIRectCornerBottomLeft andSize:CGSizeMake(kHeight, kHeight)];
        for (int i=1; i<=total; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kHeight + 5) * (i-1) + 8, 2, kHeight, kHeight)];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.image = image;
            
//            //本地图片圆角设置
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                UIImage *image = [[UIImage imageNamed:@"popup_box_ai_header_img"] cc_imageCornerWithRadius:20 corners:UIRectCornerTopRight|UIRectCornerBottomLeft andSize:CGSizeMake(kHeight, kHeight)];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    imageView.image = image;
//                });
//            });
             
            //不设置图片的时候可以看见设置的圆角，当设置图片的时候，会被图片遮住圆角
//            imageView.layer.cornerRadius = kHeight * 0.5;
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

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super",
                      @"https://www.baidu.com/img/bd_logo1.png?where=super"];
    }
    return _imageArray;
}

@end
