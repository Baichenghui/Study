//
//  CornerForUIImageViewEController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUIImageViewEController.h"
#import "UIImageView+Add.h"
#import "UIImageView+WebCache.h"

#define kHeight 20

/**
 SDWebImage:
 0、根据cacheUrl为key获取缓存图片
 1、获取到了，直接赋值给UIImageView的image
 2、未获取到，则请求网络获取图片
 3、将图片根据contentMode，size绘制图片
 4、将重新生成的图片绘制圆角
 5、将圆角图片赋值给UIImageView的image
 6、将该圆角图片缓存到内存中
 7、注意：由于有较多的图片绘制等操作，尽量避免在主线程操作
 
 YYWebImage:    已经做了相关处理
 */

@interface CornerForUIImageViewEController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CornerForUIImageViewEController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIImageView 加载网络图片 设置圆角";
    
    [SDWebImageManager sharedManager].transformer = [SDImageRoundCornerTransformer
                                                     transformerWithRadius:200
                                                     corners:(UIRectCornerAllCorners)
                                                     borderWidth:0
                                                     borderColor:nil];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    imageView.contentMode = UIViewContentModeScaleToFill;
    NSString * urlString = @"https://t10.baidu.com/it/u=3985252014,1442168763&fm=76";
//    [imageView cc_setImageWithURLString:urlString placeholder:nil];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    [self.view addSubview:imageView];
     
//        [self.view addSubview:self.tableView];
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
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            NSString * urlString = @"https://t10.baidu.com/it/u=3985252014,1442168763&fm=76";
            [imageView cc_setImageWithURLString:urlString placeholder:nil];
//            [imageView sd_setImageWithURL: [NSURL URLWithString:urlString]];
            
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
