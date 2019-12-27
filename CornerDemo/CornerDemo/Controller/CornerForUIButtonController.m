//
//  CornerForUIButtonController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CornerForUIButtonController.h"
#import "UIImage+Add.h"

#define kHeight 20

//UIButton 的背景图片，如果是复杂的图片，可以依靠 UI 切图来实现。
//如果是简单的纯色背景图片，可以利用代码绘制带圆角的图片。
@interface CornerForUIButtonController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CornerForUIButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIButton设置圆角";
    
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
            UIButton *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
            imageView.frame = CGRectMake(kHeight * (i-1) + 8, 2, kHeight, kHeight);
            // 设置 UIButton 的背景图片。
            UIImage *image = [UIImage cc_pureColorImageWithSize:CGSizeMake(kHeight, kHeight) color:[UIColor purpleColor] cornRadius:kHeight * 0.5];
            [imageView setBackgroundImage:image forState:UIControlStateNormal];
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
