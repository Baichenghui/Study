//
//  HDLineDataModel.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HDLineDataModel.h"
 
@interface HDLineDataModel()
/**
 持有字典数组，用来计算ma值
 */
@property (nonatomic, strong) NSArray *parentDictArray;
@end

@implementation HDLineDataModel
{
    NSDictionary * _dict;
    NSString *Close;
    NSString *Open;
    NSString *Low;
    NSString *High;
    NSString *Volume;
    NSNumber *MA5;
    NSNumber *MA10;
    NSNumber *MA20;
    
}

- (NSString *)Day {
    return  @""; 
}

- (NSString *)DayDatail {
    NSString *day = [_dict[@"day"] stringValue];
    return [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
}

- (id<HHDataModelProtocol>)preDataModel {
    if (_preDataModel != nil) {
        return _preDataModel;
    } else {
        return [[HDLineDataModel alloc]init];
    }
}

- (NSNumber *)Open {
//    NSLog(@"%i",[[_dict[@"day"] stringValue] hasSuffix:@"01"]);
    return _dict[@"open"];
}

- (NSNumber *)Close {
    return _dict[@"close"];
}

- (NSNumber *)High {
    return _dict[@"high"];
}

- (NSNumber *)Low {
    return _dict[@"low"];
}

- (CGFloat)Volume {
    return [_dict[@"volume"] floatValue]/100.f;
}

- (BOOL)isShowDay {
    return NO; 
}

- (NSNumber *)MA5 {
    return MA5;
}

- (NSNumber *)MA10 {
    return MA10;
}

- (NSNumber *)MA20 {
    return MA20;
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _dict = dict;
        Close = _dict[@"close"];
        Open = _dict[@"open"];
        High = _dict[@"high"];
        Low = _dict[@"low"];
        Volume = _dict[@"volume"];
    }
    return self;
}

- (void)updateMA:(NSArray *)parentDictArray index:(NSInteger)index{
    _parentDictArray = parentDictArray;
    
    if (index >= 4) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-4, 5)];
        CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA5 = @(average);
    } else {
        if (index < 4) {
            NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(0, index)];
            CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
            MA5 = @(average);
        } else {
            MA5 = @0;
        }
    }
    
    if (index >= 9) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-9, 10)];
        CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA10 = @(average);
    } else {
        if (index < 9) {
            NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(0, index)];
            CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
            MA10 = @(average);
        } else {
            MA10 = @0;
        }
    }
    
    if (index >= 19) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-19, 20)];
        CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA20 = @(average);
    } else {
        if (index < 19) {
            NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(0, index)];
            CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
            MA20 = @(average);
        } else {
            MA20 = @0;
        }
    }
    
}

@end
