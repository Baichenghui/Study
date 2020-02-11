//
//  DaysMatterTests.swift
//  HHTimeTests
//
//  Created by tianxi on 2019/12/4.
//  Copyright © 2019 hh. All rights reserved.
//

import XCTest
@testable import HHTime

class HHDaysMatterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: - 倒数日接口测试
    
    // 2019-12-05 测试数据
    
    func testDaysBeforeNewYear() {
        let distancesAt20191205 = HHDateUtil.distanceInDays(fromDate: HHDateUtil.getDateFromYMD(time: "2019-12-05"), toDate: Date.init())
        
        let days = HHDateUtil.daysBeforeNewYear()
        XCTAssert(days + distancesAt20191205  == 27, "距离新年还有\(days)天")
    }
 
    func testDaysOfAnniversaryWeekly() {
        let distancesAt20191205 = HHDateUtil.distanceInDays(fromDate: HHDateUtil.getDateFromYMD(time: "2019-12-05"), toDate: Date.init())
        
        let days = HHDateUtil.daysOfAnniversaryWeekly(weekDay: 7)
        XCTAssert(days + distancesAt20191205 == 2, "距离周六还有\(days)天")
    }
    
    func testDaysOfAnniversaryMonthly() {
        let distancesAt20191205 = HHDateUtil.distanceInDays(fromDate: HHDateUtil.getDateFromYMD(time: "2019-12-05"), toDate: Date.init())
        
        let days = HHDateUtil.daysOfAnniversaryMonthly(dateOfDay: 10)
        XCTAssert(days + distancesAt20191205 == 5, "距离发工资还有\(days)天")
    }
    
    func testDaysOfAnniversaryAnnual() {
        let distancesAt20191205 = HHDateUtil.distanceInDays(fromDate: HHDateUtil.getDateFromYMD(time: "2019-12-05"), toDate: Date.init())
        
        let days = HHDateUtil.daysOfAnniversaryAnnual(date:HHDateUtil.getDateFromYMD(time: "2019-1-29"))
        XCTAssert(days + distancesAt20191205 == 55, "结婚纪念日还有\(days)天")
    }
    
    func testDaysDistanceInDays() {
        let distancesAt20191205 = HHDateUtil.distanceInDays(fromDate: HHDateUtil.getDateFromYMD(time: "2019-12-05"), toDate: Date.init())
        
        let days = HHDateUtil.distanceInDays(fromDate: HHDateUtil.getDateFromYMD(time: "1992-09-13"), toDate: Date.init())
        XCTAssert(days == 9944 + distancesAt20191205, "我已经来到这个世界\(days)天")
    }
    
    func testAddDays() {
        let date = HHDateUtil.dateByAddingDays(date: HHDateUtil.getDateFromYMD(time: "2019-12-05"), days: 5)
        let dateString = HHDateUtil.convertToYMD(date: date)
        
        XCTAssert(dateString == "2019-12-10", "5天之后是"+dateString)
    }
    
    func testSubtractingDays() {
        let date = HHDateUtil.dateBySubtractingDays(date: HHDateUtil.getDateFromYMD(time: "2019-12-05"), days: 5)
        let dateString = HHDateUtil.convertToYMD(date: date)
        
        XCTAssert(dateString == "2019-11-30", "5天之前是"+dateString)
    }
    
    func testWeekDay() {
        let weekday = HHDateUtil.weekday(date: HHDateUtil.getDateFromYMD(time: "2019-12-05"))
        
        XCTAssert(weekday == 5, "2019-12-05 星期四")
    }
    
    func testScheduleOfYear() {
        let persent = HHDateUtil.scheduleOfYear(HHDateUtil.getDateFromYMD(time: "2019-12-05"))
        let persentString = String.init(format: "%.1f", persent * 100)  + "%"
        XCTAssert(persent >= 0 && persent <= 1, "今年已过" + persentString)
    }
    
    func testScheduleOfMonth() {
        let persent = HHDateUtil.scheduleOfMonth(HHDateUtil.getDateFromYMD(time: "2019-12-30"))
        let persentString = String.init(format: "%.1f", persent * 100)  + "%"
        XCTAssert(persent >= 0 && persent <= 1, "本月已过" + persentString)
    }
    
    func testScheduleOfWeek() {
        let persent = HHDateUtil.scheduleOfWeek(HHDateUtil.getDateFromYMD(time: "2019-12-05"))
        let persentString = String.init(format: "%.1f", persent * 100)  + "%"
        XCTAssert(persent >= 0 && persent <= 1, "本周已过" + persentString)
    }
    
    func testZodiac() {
        let zodiac = HHDateUtil.zodiac(withDate: HHDateUtil.getDateFromYMD(time: "2019-12-05"))
        XCTAssert(zodiac == "猪", "2019是猪年")
    }
}
