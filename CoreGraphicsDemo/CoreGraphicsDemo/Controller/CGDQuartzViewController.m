//
//  CGDQuartzViewController.m
//  CoreGraphicsDemo
//
//  Created by tianxi on 2019/12/27.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CGDQuartzViewController.h"
#import "CGDQuartzView.h"

//CGContextRef 的作用：
//保存图片信息、绘图状态；决定绘制的输出目标(绘制到哪去？pdf文件、Bitmap或者显示器窗口)
//绘制好的图形---》保存到：CGContextRef ---》显示：输出目标
//相同的一套绘图序列，指定不同的Graphics Context，就可将相同的图像绘制到不同的目标上
//Graphics Context 类型：Bitmap/PDF/Window/Layer/Printer Graphics Context

@interface CGDQuartzViewController ()
@property (nonatomic, strong)CGDQuartzView *qView;
@end

@implementation CGDQuartzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.qView = [[CGDQuartzView alloc] initWithFrame:CGRectMake(0, 0, 414, 736)];
    self.qView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.qView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
