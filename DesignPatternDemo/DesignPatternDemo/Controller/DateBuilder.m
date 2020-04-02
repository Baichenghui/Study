//
//  DateBuilder.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "DateBuilder.h"

@interface DateBuilder()
@property (nonatomic,strong) NSDateComponents *components;
@property (nonatomic,strong) NSDateFormatter *formatter;
@end

@implementation DateBuilder

- (instancetype)init {
    if (self = [super init]) {
        self.components = [NSDateComponents new];
        self.components.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        self.formatter = [NSDateFormatter new];
        self.formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return self;
}

- (NSDate *)date {
    return [self.components date];
}

- (NSString *)dateFormat:(NSString *)format {
    self.formatter.dateFormat = format;
    return [self.formatter stringFromDate:self.components.date];
}

- (NSDateComponents *)setCalender:(NSString *)identifier {
    self.components.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:identifier];
    return self.components;
}
 
- (NSDateComponents *)setSecond:(NSInteger)second {
    self.components.second = second;
    return self.components;
}

- (NSDateComponents *)setMinute:(NSInteger)minute {
    self.components.minute = minute;
    return self.components;
}

- (NSDateComponents *)setHour:(NSInteger)hour {
    self.components.hour = hour;
    return self.components;
}

- (NSDateComponents *)setDay:(NSInteger)day {
    self.components.day = day;
    return self.components;
}

- (NSDateComponents *)setMonth:(NSInteger)month {
    self.components.month = month;
    return self.components;
}

- (NSDateComponents *)setYear:(NSInteger)year {
    self.components.year = year;
    return self.components;
}

@end
