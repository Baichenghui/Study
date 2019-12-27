//
//  ShadowForUIViewController.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/12.
//  Copyright © 2019 hh. All rights reserved.
//

#define kHeight 50

#import "ShadowForViewController.h"
#import "UIImageView+Add.h"
#import "UIImage+Add.h"
#import "UIView+Add.h"


@interface ShadowForViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ShadowForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIVIew设置阴影";
     
//    [self.tableView r]
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    NSInteger total = CGRectGetWidth(self.view.frame)/(kHeight + 10);
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        for (int i=1; i<=total; i++) {
            if (i == 1) {
                UILabel *imageView = [[UILabel alloc]initWithFrame:CGRectMake((kHeight + 10) * (i-1) + 8, 10, kHeight, kHeight)];
                imageView.layer.backgroundColor = [UIColor brownColor].CGColor;
                imageView.layer.cornerRadius = kHeight * 0.5;
                imageView.layer.shadowColor = [UIColor greenColor].CGColor;
                imageView.layer.shadowOffset = CGSizeMake(0, 0);
                imageView.layer.shadowOpacity = 0.5;
                imageView.layer.shadowRadius = 3;
                imageView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:kHeight * 0.5].CGPath;
                [cell.contentView addSubview:imageView];
            }
            else if (i == 2) {
                UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake((kHeight + 10) * (i-1) + 8, 10, kHeight, kHeight)];
                imageView.layer.cornerRadius = kHeight * 0.5;
                imageView.backgroundColor = [UIColor orangeColor];
                imageView.layer.shadowColor = [UIColor blackColor].CGColor;
                imageView.layer.shadowOffset = CGSizeMake(0, 0);
                imageView.layer.shadowOpacity = 0.5;
                imageView.layer.shadowRadius = 3;
                imageView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:kHeight * 0.5].CGPath;
                [cell.contentView addSubview:imageView];
            }
            else if (i == 3) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake((kHeight + 10) * (i-1) + 8, 10, kHeight, kHeight)];
                view.layer.cornerRadius = kHeight * 0.5;
                view.layer.backgroundColor = [UIColor whiteColor].CGColor;
                view.layer.shadowColor = [UIColor redColor].CGColor;
                view.layer.shadowOffset = CGSizeMake(0, 0);
                view.layer.shadowOpacity = 0.5;
                view.layer.shadowRadius = 3;
                view.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:kHeight * 0.5].CGPath;
                
                //CGRectMake(3, 3, kHeight - 6, kHeight - 6)
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kHeight, kHeight)];
                //注意不要设置背景色
//                imageView.backgroundColor = [UIColor whiteColor];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                NSString * urlString = @"https://t10.baidu.com/it/u=3985252014,1442168763&fm=76";
                [imageView cc_setImageWithURLString:urlString placeholder:nil];
                
                [view addSubview:imageView];
                [cell.contentView addSubview:view];
            }
            else if (i == 4) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake((kHeight + 10) * (i-1) + 8, 10, kHeight, kHeight)];
                view.layer.cornerRadius = kHeight * 0.5;
                view.layer.backgroundColor = [UIColor yellowColor].CGColor;
                view.layer.shadowColor = [UIColor redColor].CGColor;
                view.layer.shadowOffset = CGSizeMake(0, 0);
                view.layer.shadowOpacity = 0.5;
                view.layer.shadowRadius = 3;
                view.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:kHeight * 0.5].CGPath;
                
                UITextView *imageView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kHeight, kHeight)];
                imageView.layer.cornerRadius = kHeight * 0.5;
                [view addSubview:imageView];
                [cell.contentView addSubview:view];
            }
            else if (i == 5) {
                UITextField *imageView = [[UITextField alloc]initWithFrame:CGRectMake((kHeight + 10) * (i-1) + 8, 10, kHeight, kHeight)];
                imageView.layer.cornerRadius = kHeight * 0.5;
                imageView.backgroundColor = [UIColor greenColor];
                imageView.layer.shadowColor = [UIColor redColor].CGColor;
                imageView.layer.shadowOffset = CGSizeMake(0, 0);
                imageView.layer.shadowOpacity = 0.5;
                imageView.layer.shadowRadius = 3;
                imageView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:kHeight * 0.5].CGPath;
                [cell.contentView addSubview:imageView];
            }
            else {
                UIButton *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
                imageView.frame = CGRectMake((kHeight + 10) * (i-1) + 8, 10, kHeight, kHeight);
                // 设置 UIButton 的背景图片。
                UIImage *image = [UIImage cc_pureColorImageWithSize:CGSizeMake(kHeight, kHeight) color:[UIColor purpleColor] cornRadius:kHeight * 0.5];
                [imageView setBackgroundImage:image forState:UIControlStateNormal];
                imageView.layer.shadowColor = [UIColor blueColor].CGColor;
                imageView.layer.shadowOffset = CGSizeMake(0, 0);
                imageView.layer.shadowOpacity = 0.5;
                imageView.layer.shadowRadius = 3;
                imageView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:kHeight * 0.5].CGPath;
                
                [cell.contentView addSubview:imageView];
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight+20;
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
