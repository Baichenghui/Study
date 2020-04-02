//
//  IDateBuilderProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

@protocol IDateBuilderProtocol <NSObject>

- (NSDateComponents *)setCalender:(NSString *)identifier;
- (NSDateComponents *)setSecond:(NSInteger)second;
- (NSDateComponents *)setMinute:(NSInteger)minute;
- (NSDateComponents *)setHour:(NSInteger)hour;
- (NSDateComponents *)setDay:(NSInteger)day;
- (NSDateComponents *)setMonth:(NSInteger)month;
- (NSDateComponents *)setYear:(NSInteger)year;
- (NSDate *)date;
- (NSString *)dateFormat:(NSString *)format;

@end
