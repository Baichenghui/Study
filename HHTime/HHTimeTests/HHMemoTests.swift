//
//  HHMemoTests.swift
//  HHTimeTests
//
//  Created by tianxi on 2019/12/4.
//  Copyright © 2019 hh. All rights reserved.
//

import XCTest
@testable import HHTime

class HHMemoTests: XCTestCase {

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

    func testAddReminder() {
        let expect = expectation(description: "超时")
        HHEventKitUtil.saveReminderCalendar(title: "测试提醒日历添加😆", identifier: nil,color:UIColor.orange) { (granted, error, success) in
            if success {
                XCTAssertTrue(success, "测试提醒日历添加😆")
            }
            else {
                XCTFail("请求失败!")
            }

            //告知异步测试结束
            expect.fulfill()
        }
 
        // 请求超时
        waitForExpectations(timeout: 10) { (error) in
            //超时后做一些事情
        }
    }
    
    func testAddEvent() {
        let expect = expectation(description: "超时")
        HHEventKitUtil.saveEventCalendar(title: "测试日历添加XX", identifier: nil,color:UIColor.cyan) { (granted, error, success) in
            if success {
                XCTAssertTrue(success, "测试日历添加😆")
            }
            else {
                XCTFail("请求失败!")
            }

            //告知异步测试结束
            expect.fulfill()
        }
    
        // 请求超时
        waitForExpectations(timeout: 10) { (error) in
            //超时后做一些事情
        }
    }
}
