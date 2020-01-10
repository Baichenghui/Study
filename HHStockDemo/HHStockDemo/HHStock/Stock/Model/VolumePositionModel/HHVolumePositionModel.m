//
//  HHVolumePositionModel.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHVolumePositionModel.h"

@implementation HHVolumePositionModel
+ (instancetype) modelWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint dayDesc:(NSString *)dayDesc;
{
    HHVolumePositionModel *volumePositionModel = [HHVolumePositionModel new];
    volumePositionModel.StartPoint = startPoint;
    volumePositionModel.EndPoint = endPoint;
    volumePositionModel.DayDesc = dayDesc;
    return volumePositionModel;
}
@end
