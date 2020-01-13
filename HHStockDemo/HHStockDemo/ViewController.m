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

@interface ViewController ()<HHStockDelegate,HHStockDataSource>
@property (strong, nonatomic) UIView *stockContainerView;
@property (strong, nonatomic) HHStock *stock;
/**
 K线数据源
 */
@property (strong, nonatomic) NSMutableDictionary *stockDatadict;

@property (strong, nonatomic) NSMutableArray *array;

@property (assign, nonatomic) BOOL isLoading;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.stockContainerView];
    [_stockContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(@0);
        make.top.mas_equalTo(@200);
        make.height.mas_equalTo(@300);
    }];
    
    
    [HHStockVariable setStockLineWidthArray:@[@6,@6,@6,@6]];
    HHStock *stock = [[HHStock alloc] initWithFrame:self.stockContainerView.frame dataSource:self delegate:self];
    stock.mainView.backgroundColor = [UIColor blueColor];
    _stock = stock;
    [self.stockContainerView addSubview:stock.mainView];
    [stock.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stockContainerView);
    }];
    
    self.array = [NSMutableArray array];
    
    [self fetchData];
}

- (void)fetchData {

    self.isLoading = YES;
    __weak typeof(self) weakSelf = self;
    [AppServer Get:@"day" params:nil success:^(NSDictionary *response) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        __block HDLineDataModel *preModel;
        [response[@"dayhqs"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HDLineDataModel *model = [[HDLineDataModel alloc]initWithDict:obj];
            model.preDataModel = preModel;
            [model updateMA:response[@"dayhqs"] index:idx];
            [strongSelf.array addObject: model];
            preModel = model;
        }];
        [strongSelf.stockDatadict setObject:strongSelf.array forKey:@"dayhqs"];
        
        strongSelf.isLoading = NO;
        [strongSelf.stock draw:strongSelf.array.count < 127];
    } fail:^(NSDictionary *info) {
        
    }];
}

#pragma mark - HHStockDataSource

- (NSArray *)stock:(HHStock *)stock stockDatasOfIndex:(NSInteger)index {
    return self.stockDatadict[@"dayhqs"];
}

-(HHStockType)stockTypeOfIndex:(NSInteger)index {
    return HHStockTypeLine;
}

/// 是否正在为 stock 加载数据
/// @param stock stock
- (BOOL)isLoadingDataForStock:(HHStock *)stock {
    return self.isLoading;
}

/// 是否还有更多数据
/// @param stock stock
- (BOOL)hasMoreDataForStock:(HHStock *)stock {
    return YES;
}
 
#pragma mark - HHStockDelegate

- (void)stock:(HHStock *)stock didScrollViewToLoadData:(UIScrollView *)scrollView {
    NSLog(@"HHStockDelegate didScrollViewToLoadData");
    
    self.isLoading = YES;
    [self fetchData];
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
