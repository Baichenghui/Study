//
//  ViewController.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "HHStock.h"
#import "HHStockVariable.h"
#import "AppServer.h"
#import "HDLineDataModel.h"

@interface ViewController ()<HHStockDataSource>
@property (strong, nonatomic) UIView *stockContainerView;
@property (strong, nonatomic) HHStock *stock;
/**
 K线数据源
 */
@property (strong, nonatomic) NSMutableDictionary *stockDatadict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.stockContainerView];
    [_stockContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(@0);
        make.top.mas_equalTo(@100);
        make.height.mas_equalTo(@500);
    }];
    
    
    [HHStockVariable setStockLineWidthArray:@[@5,@5,@5,@5]];
    HHStock *stock = [[HHStock alloc] initWithFrame:self.stockContainerView.frame dataSource:self];
    _stock = stock;
    [self.stockContainerView addSubview:stock.mainView];
    [stock.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stockContainerView);
    }];
    
    
    [self fetchData];
}

- (void)fetchData {

    __weak typeof(self) weakSelf = self;
    [AppServer Get:@"day" params:nil success:^(NSDictionary *response) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray *array = [NSMutableArray array];
        __block HDLineDataModel *preModel;
        [response[@"dayhqs"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HDLineDataModel *model = [[HDLineDataModel alloc]initWithDict:obj];
            model.preDataModel = preModel;
            [model updateMA:response[@"dayhqs"] index:idx];
            [array addObject: model];
            preModel = model;
        }];
        [strongSelf.stockDatadict setObject:array forKey:@"dayhqs"];
        [strongSelf.stock draw];
    } fail:^(NSDictionary *info) {
        
    }];
}

#pragma mark - HHStockDataSource

- (NSArray *)HHStock:(HHStock *)stock stockDatasOfIndex:(NSInteger)index {
    return self.stockDatadict[@"dayhqs"];
}

-(HHStockType)stockTypeOfIndex:(NSInteger)index {
    return HHStockTypeLine;
}
 
#pragma mark - getter
 
- (UIView *)stockContainerView {
    if (!_stockContainerView) {
        _stockContainerView = [UIView new];
        _stockContainerView.backgroundColor = [UIColor orangeColor];
    }
    return _stockContainerView;
}

- (NSMutableDictionary *)stockDatadict {
    if (!_stockDatadict) {
        _stockDatadict = [NSMutableDictionary dictionary];
    }
    return _stockDatadict;
}
@end
