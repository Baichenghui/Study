//
//  HHLuanarCore.h
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
   
typedef void(^HHCalendarDataBlock)(NSMutableDictionary *_Nullable);
typedef void(^HHCalendarDataListBlock)(NSMutableArray *_Nullable);

/**,
 *  获取指定年月的日历数据
 *
 *  @param _year  公历年
 *  @param _month 公历月
 *
 *  @return 该月日历
 */
NSMutableDictionary * _Nullable hh_calendar(int _year, int _month);

/// 获取指定年月的日历数据
/// @param _year  公历年
/// @param _month  公历月
/// @param calendarDataListBlock calendarDataListBlock
void hh_calendarWithCalendarDatas(int _year, int _month,_Nonnull HHCalendarDataListBlock calendarDataListBlock);

/**
 *  公历转换成农历
 *
 *  @param _year  公历年
 *  @param _month 公历月
 *  @param _day 公历日
 *
 *  @return 农历年月日
 */
NSMutableDictionary * _Nullable hh_solarToLunar(int _year, int _month, int _day);

/// 公历转换成农历
/// @param _year 公历年
/// @param _month 公历月
/// @param _day 公历日
/// @param calendarDataBlock 农历年月日
void hh_solarToLunarWithCalendarData(int _year, int _month, int _day, HHCalendarDataBlock _Nonnull calendarDataBlock);

/**
 *  农历转换成公历
 *
 *  @param _year  农历年
 *  @param _month 农历月
 *  @param _day 农历日
 *
 *  @return 公历年月日
 */
NSMutableDictionary * _Nullable hh_lunarToSolar(int _year, int _month, int _day);
