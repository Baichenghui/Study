//
//  HHLinePositionModel.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHLinePositionModel.h"

@implementation HHLinePositionModel
+ (instancetype) modelWithOpen:(CGPoint)openPoint close:(CGPoint)closePoint high:(CGPoint)highPoint low:(CGPoint)lowPoint
{
    HHLinePositionModel *model = [HHLinePositionModel new];
    model.OpenPoint = openPoint;
    model.ClosePoint = closePoint;
    model.HighPoint = highPoint;
    model.LowPoint = lowPoint;
    return model;
}
@end
